# [3.1.0](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/compare/v3.0.1...v3.1.0) (2024-09-09)


### Features

* **resolves #32:** Allow AES256 ([76c9540](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/commit/76c9540c5482987a8b9b9053df4fbba9af71d5ea)), closes [#32](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/issues/32)

## [3.0.1](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/compare/v3.0.0...v3.0.1) (2024-09-08)


### Bug Fixes

* **resolves #30:** Allow aws:kms uploads. ([f521d35](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/commit/f521d35a4e4f06cf920fd74f124c0de4edb5ee0a)), closes [#30](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/issues/30)

# [3.0.0](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/compare/v2.3.1...v3.0.0) (2024-09-07)


### Bug Fixes

* **cleanup:** remove index ([906037b](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/commit/906037b490cad5e7b68b38d739ed9ad312b5832a))


### cicd

* **resolves #28:** Cicd fix. ([44bf14d](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/commit/44bf14de26c90989ca6c2170dbdb445ed81208df)), closes [#28](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/issues/28)


* Merge pull request #27 from flagscript/allow-owned-kms ([d915d42](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/commit/d915d4284c74a38d73afa8261c01fcc8b21dd10b)), closes [#27](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/issues/27)


### Features

* **resolves #22:** Allow kms key. ([ae9d1c6](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/commit/ae9d1c67417d7f93ab3a9535844af018a6706b44)), closes [#22](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/issues/22)
* **resolves #22:** Refactor kms usages. ([d385112](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/commit/d38511268251580c527cb6a47dc28d7624b7f909)), closes [#22](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/issues/22)
* **resolves #23:** husky lflint ([45f25cc](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/commit/45f25cc3bd354b36a902f6f428a9e0345eab7a90)), closes [#23](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/issues/23)
* **resolves #24:** Allow mfa delete. ([9fe19b5](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/commit/9fe19b5b42312c90a91393f09f63cd09f12c02dd)), closes [#24](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/issues/24)
* **resolves #25:** Merge standard policy document. ([6256e95](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/commit/6256e959ff077dd5590f7813cd2c0a494cb780fd)), closes [#25](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/issues/25)
* **resolves #25:** Move policies to new file. ([7d201b4](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/commit/7d201b41fc39e47c4fa613e8157dc076bb988921)), closes [#25](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/issues/25)
* **resolves #26:** Migrate cloudfront policy to main module. ([85e5643](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/commit/85e5643694fe3778c404d7ba1662f3ee1ad9a869)), closes [#26](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/issues/26)


### BREAKING CHANGES

* **resolves #28:** Policies have been moved into main module.
* Features and policy rollup.
* **resolves #22:** Policies have been moved into main module.

## [2.3.1](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/compare/v2.3.0...v2.3.1) (2024-08-19)


### Bug Fixes

* **resolves #20:** Delete deletion replication ([5d529fe](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/commit/5d529fe02c6efd53df745534945415259dbdaed1)), closes [#20](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/issues/20)

# [2.3.0](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/compare/v2.2.0...v2.3.0) (2024-08-18)


### Features

* **resolves #18:** Fix replication module variable. ([46c9624](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/commit/46c962476dbed2f48cb5c8f77451688865b572e4)), closes [#18](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/issues/18)

# [2.2.0](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/compare/v2.1.1...v2.2.0) (2024-08-18)


### Features

* **resolves #15:** Add replication module. ([2b81273](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/commit/2b812731a2be7ba92d8c12173de7eca7c6a67a39)), closes [#15](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/issues/15)
* **resolves #16:** Bump existing terraform and aws versions ([cf0ee35](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/commit/cf0ee356e1b0c320537b6df1d07a36cefc1aadae)), closes [#16](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/issues/16)

## [2.1.1](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/compare/v2.1.0...v2.1.1) (2024-08-18)


### Bug Fixes

* **resolves #13:** use commit message ([6dc8cfd](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/commit/6dc8cfd39775183450ef6c28d2b854f75c6e6e6b)), closes [#13](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/issues/13)
* **resolves #14:** Misspell branch ([1260c8a](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/commit/1260c8a47864b96687ba1cd71a266f7f31db23d0)), closes [#14](https://github.com/flagscript/terraform-aws-flagscript-s3-bucket/issues/14)
