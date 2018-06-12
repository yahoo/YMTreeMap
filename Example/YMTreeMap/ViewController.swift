//  Created by Adam Kaplan on 08/25/2017.
//  Copyright 2017 Yahoo Holdings Inc.

import UIKit
import YMTreeMap

class Layout: UICollectionViewLayout {

    var rects = [CGRect]() {
        didSet {
            invalidateLayout()
        }
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    override var collectionViewContentSize: CGSize {
        return self.collectionView?.frame.size ?? .zero
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var index = 0
        return rects.compactMap { (itemRect: CGRect) -> UICollectionViewLayoutAttributes? in
            let attrs = rect.intersects(itemRect) ?
                    self.layoutAttributesForItem(at: IndexPath(item: index, section: 0)) : nil
            index += 1
            return attrs
        }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attrs.frame = rects[indexPath.item]
        return attrs
    }
}

class ViewController: UICollectionViewController {

    //let values = TestValues_OneThousand.AllValues
    let values = TestValuesDow30.AllValues

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(collectionViewLayout: Layout())
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(collectionViewLayout: Layout())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let treeMap = YMTreeMap(withValues: values)
        treeMap.alignment = .retinaSubPixel
        if let layout = self.collectionViewLayout as? Layout {
            let bounds = self.collectionView?.bounds ?? .zero
            layout.rects = treeMap.tessellate(inRect: bounds)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Uncomment to benchmark
        DispatchQueue.global(qos: .userInitiated)
                .asyncAfter(deadline: DispatchTime.now() + .seconds(3)) { [weak self] in
            let iterations = 1_000

            // Run all tests twice. Looks like the second round tend to run a little
            // faster as there's that needs to warm up (VM allocation?)
            self?.runBenchmark(TestValuesDow30.self, iterations: iterations)
            self?.runBenchmark(TestValuesOneThousand.self, iterations: iterations)

            self?.runBenchmark(TestValuesDow30.self, iterations: iterations)
            self?.runBenchmark(TestValuesOneThousand.self, iterations: iterations)
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        let treeMap = YMTreeMap(withValues: values)
        if let layout = self.collectionViewLayout as? Layout {
            layout.rects = treeMap.tessellate(inRect: CGRect(origin: .zero, size: size))
        }
    }

    func runBenchmark(_ spec: TestValues.Type, iterations: Int) {
        let rect = CGRect(x: 0, y: 0, width: 375, height: 667)
        let values = spec.AllValues

        let begin = mach_absolute_time()
        for _ in 0..<iterations {
            autoreleasepool {
                _ = YMTreeMap(withValues: values).tessellate(inRect: rect)
            }
        }
        let end = mach_absolute_time()
        logBenchmark(spec.description, iterations: iterations, begin: begin, end: end)

        let numberValues = values.map { NSNumber(value: $0) }

        let begin2 = mach_absolute_time()
        for _ in 0..<iterations {
            autoreleasepool {
                _ = ObjCBenchmark.run(withValues: numberValues, in: rect)
            }
        }
        let end2 = mach_absolute_time()
        logBenchmark(spec.description.appending("-ObjC"), iterations: iterations, begin: begin2, end: end2)
    }

    func logBenchmark(_ description: String, iterations: Int, begin: UInt64, end: UInt64) {
        var info = mach_timebase_info(numer: 0, denom: 0)
        mach_timebase_info(&info)
        let diff = Double(end - begin) * Double(info.numer) / Double(info.denom)
        let msDiff = diff / Double(NSEC_PER_MSEC)

        let msDiffStr = String(format: "%fms", msDiff)
        let msOpsStr = String(format: "%f", Double(iterations) / msDiff)
        let msEachStr = String(format: "%fms", msDiff / Double(iterations))

        print("[\(description)] Performed \(iterations) iterations in \(msDiffStr); \(msOpsStr)/ms; \(msEachStr) each")
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return values.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)

        if let cell = cell as? CollectionViewCell {
            let company = TestValuesDow30.Companies[indexPath.item]
            let color = self.color(forValue: company.percentChange)

            cell.tintColor = color
            cell.symbolLabel.text = company.symbol
            cell.valueLabel.text = String(format: "%+.2f%%", company.percentChange)
        }
        return cell
    }

    func color(forValue value: Double) -> UIColor {
        var previousBucketCutoff = Double.greatestFiniteMagnitude
        var colors = TestValuesDow30.colors
        var (nextBucketCutoff, color) = colors.removeFirst()

        while !colors.isEmpty {
            let bucketCutoff = nextBucketCutoff
            let currentColor = color
            (nextBucketCutoff, color) = colors.removeFirst()

            if value < 0 { // negative
                if value >= bucketCutoff && value < nextBucketCutoff {
                    return currentColor
                }
            } else { // positive
                if value <= bucketCutoff && value > previousBucketCutoff {
                    return currentColor
                } else if value <= nextBucketCutoff && value > bucketCutoff {
                    return color
                }
            }

            previousBucketCutoff = bucketCutoff
        }

        return UIColor.white
    }
}
