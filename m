Return-Path: <linux-hyperv+bounces-11132-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCbSEacyD2qSHgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11132-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 18:28:23 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A48BA5A9479
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 18:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C30AD30804C2
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 15:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE76345CBD;
	Thu, 21 May 2026 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="vT8R+7lr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012056.outbound.protection.outlook.com [52.103.10.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739D332E696;
	Thu, 21 May 2026 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377952; cv=fail; b=iGCrNgE8m/O4Gr33jrAK5PMvbwSzI83Pn6+W6/alXmPe81UfMt3A8ags9WQD4nmLVp025PL8Omsl75qQ01gLecS59hEqV8rJMzB2ds+z4JzWnys4YfNhMX4XaXcXxyjqep4mIATwT58bHUE14aDumu19E/60wHpMUa951zrcZhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377952; c=relaxed/simple;
	bh=4dpgy1t+Ce+YNPLP0heo5Ysfwb9kNTjZz/OLuUNSzHU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bbGjJQynvStY36/DGn+s6U8TrORXCdeeAq+HGgBCr4gUpN5u9ES9tUsahlqXO1vox+N9bv1MAE3Mamqah0Mxh5zHo+bQeEmPQj5L6AdCfFrc+itXdivMTg5lsy2FD5eep6qKHwp1TFU0QC9L2DcQkB1kACfi9bOO4ZRJolqQ/6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=vT8R+7lr; arc=fail smtp.client-ip=52.103.10.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xr6S+oJ7lP5owfgUI8DmnIUgEF51K7bulKT5gyTgbnUh5dqvRE7//+9pESk3uAhZwh2TXahjhnotqo1KctuKBg4QM6ejGyBCXRJraM3cqJQrN23K6vuAt4tlAbZDnDMSSZ1XCA91NngNfeyXbYIQTsa1UG6Rl5pOodUOO6NHDUDAg8Q42Gaf5rPehBKdciQSoNy1htByc3hBTibLgQ1EPZPJBLKsn9W/j8pl7B9Lbf2AFqnFEa76AwhQJiGNTd9TD0x5NG2f5o8obR/rJo4wUCqx6ZRjdX8t98elPAPWOFbczaKj8rYcDVRKW40QR+b4r8FGd3M38sMli++1Q6gaWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ahf5OZtbHk+9DnkswdRx72kSMPGT3xQ9Dszguwog8jg=;
 b=Ozou4NNCLqVrEUAG8jmeCsFzupAkWC/t2YaS1M+C0N3UMjCqqkV/bvtfgO6I/yZHGyey4E8CWUlPoasFuvaF2ILMTcscqrjA3TTJ71jiM3e4xU4ynqsDHuN0kXW/ZLMEMEQll6BbmYdMVkuE9vCEayxhPFDAe+rzuiLcrRGLTe6fnQhM36UkM5gg4IHT4rKvhgdSgyfBfZn5D1gGJgWPnMjgdWH8ESdzj20HOZhFoxA4H22jGvKTjfvkVcxEliEtc1sNiwHrwqoB3LzzU/K1Mo/6XgQ/WQmnWZdj8ekMIwjOKbXmQy66c0snkIG1Du+cC4HboMzXwHwhCVJmfVEAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ahf5OZtbHk+9DnkswdRx72kSMPGT3xQ9Dszguwog8jg=;
 b=vT8R+7lrU6gNFSFC6wKvPcSpCNBK0YN0GI+9seIE83svcNuJYRn+fprtboGmyfz+njCLYA/rapDtf1El8JWhiPMUUxXHiPmWdxD59KPyiDENGPa9j05lBjL7Esa/IfyKRskz525YOidcsXnK4X9vmvCI32OX7fqMYy487lGN+kjLJB2u0n8W1mBY3hTnZSHAtz0ObWzm4QIB/iHOwQhgZFHQhVs3ENE1Fg+9iYhao3tfg0CNjb09SRls2bcXa4hyqPHRilaDRUAlaRZ3kPLUZQZHUEGyZ8TaHoWORXT0BydwF7pP4YvhREpPrRlXkei5zTypZJREHejDENB0u4PqUA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8352.namprd02.prod.outlook.com (2603:10b6:806:1e7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Thu, 21 May
 2026 15:39:08 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 15:39:08 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de"
	<arnd@arndb.de>, "jacob.pan@linux.microsoft.com"
	<jacob.pan@linux.microsoft.com>, "tgopinath@linux.microsoft.com"
	<tgopinath@linux.microsoft.com>, "easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>
Subject: RE: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Thread-Topic: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Thread-Index:
 AQJDuACGb2SFxAgG/WSEtOdKOL4HjAGk+UcvAojevN21KBm8AIAAHqSwgAFGswCAABIWYA==
Date: Thu, 21 May 2026 15:39:07 +0000
Message-ID:
 <SN6PR02MB4157ACF39421019BCFB08838D40E2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>
 <20260515223545.GL7702@ziepe.ca>
 <lxmfd2ml5dafkxquuf5i45uqgh6wxl44hlqphu77kvximqrnmi@b3htoyjc6d5z>
 <SN6PR02MB4157C1EC7F5F69C5ABDA9C7FD4012@SN6PR02MB4157.namprd02.prod.outlook.com>
 <pxod76qh3jtpvnxdlflvntc5svqgibaeu6tywn2ejrlnea65w3@djehcr3vidnk>
In-Reply-To: <pxod76qh3jtpvnxdlflvntc5svqgibaeu6tywn2ejrlnea65w3@djehcr3vidnk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8352:EE_
x-ms-office365-filtering-correlation-id: 03bc5731-61fd-4de3-bede-08deb74f18de
x-ms-exchange-slblob-mailprops:
 Vs63Iqe4sQmM7KNZxyCfd+5xcyAOZnIEFheE2WWi5GDJ0+mpnbuxL7q+W5rRkbfxaZKRTaqpL21wZjwJA0vykqDUDoWJoS6sHMX3ejWeafRiL3UQCuoJDG7eREKIYNUk333oi5BT4qx/tciUDJBSy6B5DRGymyEIc1gFyF7KIWOv1CccW6erRMeiU0BwR/Bl92YpWKtVe4o+Himn0FEoqKeN9VzRJJprpGXAppdt01zScdrt3IE+r4Kz5EUEKuT2YQNU3lMZsGodRiRsT7wmR9BItGUqSJ7tO+rfk4e5oEtKPggV2j4TQZHjHadWi+VZuspyIvHs6b612Hc8XWajifqXjxkZCAJfXDWO6Zg1APapFgpN819is3phL5U0/REfNcbWg5X8UUmDk7NbdRX7jMcnxE842u+SdEzAvk3iaTZNO4DI/g8Hc03OGOCDp/sQQLzgPGdVrsExJsCLefLuve0Bo29QPgC0RYkQZPHUpm4d9z0wCHZMzXlYIxViHe6xpc0DhQNQWcHf2RjI1np05hAjdweXFjYeqGN++o9AxU7WA7BR/Sx+wdJ718ECimJ6PG4QW+PMidmAiBxOWsaJvOfSCA9+HytOBGTkuWjafSkj9rN83fwNewkd5DmUiPUa+2eYflkO2VFjF8zobFmWrIz8doA/yUX+Te06FGis8cH950KN8MtMnQ9Cvx3L3tXVPA8xdWBh2Df3OETf9XuSZ2FpVYQwIe2LiKtoye8dtPg=
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|19101099003|15080799012|8062599012|19110799012|8060799015|41001999006|37011999003|51005399006|31061999003|440099028|3412199025|12091999003|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?au84V2Buc59jjO8RO2FUXl94G0MVrjYP0Hy+UEns1lKMcG6ohJTjW5m+MVfm?=
 =?us-ascii?Q?RDYOx9+m0Tn5/t6XVm8mw16QvzgoRE3ipP0lTXtsxuOC8AAiHtZcjjMpHPSq?=
 =?us-ascii?Q?8HpYHfODmOaoQKNPMhLffKuYodC8pmMKsKtauM5c98lqw/i5cbU6VbDvD7mc?=
 =?us-ascii?Q?Ssg/zDqXBS4UvTOzNtww6xF1owYKPHzk1yGsm9VRH7nA4jEcRCXq9Se0eCdK?=
 =?us-ascii?Q?KZWLOLkFeSmOlbjuv4EujkGDUzFjbXto+jHAkC3QDDOLmq8P+r4xofbLLV60?=
 =?us-ascii?Q?OYmQPHWBP24z3D20S1HaN3g4V5l+3nB0oVcKWsKm5zWUmvPUq+y0930ncri0?=
 =?us-ascii?Q?g7WUTY9z3nBgRGwWaf8sZ5vmx483YpHu5YeRpQ14uRDZVw44ryDGU6MF4UrI?=
 =?us-ascii?Q?d78Z265ugJaUn5RL5ieTOLo9bcC8acg/KhR442nifbAWMwOdDcb9bIbIqCIw?=
 =?us-ascii?Q?uzporEnDLz8CQjvvgkzmdDP7+6CsyWes5TP3qlrZxtPcjjz8Q7/V0CWKmHLj?=
 =?us-ascii?Q?zDIHJ5EgQAW3MydUMWZpoq1SZz6UoK9rdrRXfY/qM3PJHt7k93fJGTBNdUN3?=
 =?us-ascii?Q?gdCMvRu5LGNZzSD/t1jYC4p3UpcYtbupkIm0IOLN30wCGSk79+Umtm1ILjg4?=
 =?us-ascii?Q?g+lYK95vYWfQxczL77remG2hGctPh03CRZaVTFDRmVaLa9c4LjJe0lb+nJet?=
 =?us-ascii?Q?oKymGMjZ9lM9RrrMAWEvhVjul1f/eoKUlWshNZnjXG7cV8AD2KzrKUd6UWoC?=
 =?us-ascii?Q?Z+Zr5zQN9U4hAmvQayObaFnS2IoHRBB6rLtadKuCTWPWkrAs5e8V9qptszXg?=
 =?us-ascii?Q?XGF9v/076RUX9vibTsbic7dsXYvSZkkOJ2KKwCvjAVtOv0QlgzzG/qTfQ89H?=
 =?us-ascii?Q?4hhDXh8qnfEgw+p3V3V8sYkgpzRaB+/0jkT/HaQtWfTMSYz65Rk4lQGWRzRy?=
 =?us-ascii?Q?y3o8XYfsb9WGErcHNI3BOjKfCQXx2qTUpRSAQ4UDxAdLP27wVekyMCt5FfaA?=
 =?us-ascii?Q?CrIaaM1Zd2bpu0kZm+q3P7NSlGXegeKpo2BtNq/AgXMtE3643JWmYzeEJvV3?=
 =?us-ascii?Q?VcZGbUunDRJvOagw7L64NOa4arV/kA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Lfoo6m1Thk4T3kaJdt9Vchy1Gx4TySMLdMvla/952TwUxqHzkrrpaUWx/0QJ?=
 =?us-ascii?Q?MfmxHcXn099GqbirI6YRNlhQ06d25plss30aGLhey0vQwvPYtUb2HQ4bvtEh?=
 =?us-ascii?Q?petN5L5r2gmpgzdhXPXIRhU/YtLVyWnK8gLsvZQWmyMaF2jp77o6UlU15VPc?=
 =?us-ascii?Q?mYPYomZLYjwe9/31OQpmGT9ubO0W4L7bKCf4Kq5M/jf7YHqZa00WoUwwIlzF?=
 =?us-ascii?Q?Z5hHoaisyCLn4huWiSJ6uyuDZ4u4YmQQT8R4+0zwLuZGfUgxQHXpXdHCr9a3?=
 =?us-ascii?Q?+OlnWjSNk7gJ98/kWdBeO2TGJCcPzMGOpjAtz7t5ANpInpu1LBkHVo0hWCbr?=
 =?us-ascii?Q?zeBJF9yTUdYRoH9fZu1mbsBVCo5pQoVlLOuBRMTWTboOPlxX1/6vVn/vtIe4?=
 =?us-ascii?Q?W6E8+gFI0wFFS8tkmLjWSHQF1ElJ28pQhDq9yKxubghr/7A/O2a+aErsRCnA?=
 =?us-ascii?Q?dKUKa5WhjVTAqGYzHhM46cbwyCqUrVwCdVi1o59oUkgXTexjWJvAd4Su1UOK?=
 =?us-ascii?Q?AY2ODTXK56rZnbtGdLfszkWH/V9jFvCOxT9zuvnHZhZlKESqu7rPiHzLAOEb?=
 =?us-ascii?Q?jVDNZtiVpKEFKtxCgz23nPIjC0mJPMdsW5fltXDVWbQDZfqWTgekO6Yqy1zT?=
 =?us-ascii?Q?Q/xEVRZCCM/cyrjmJSNDIiT/sRAjR+ugxY5O+9gB3nMairsOvdK9s7QiTF7X?=
 =?us-ascii?Q?pVewRxEnkYjMy310+dM8HaRHzM+96bps60hj77JJW9WlWFFAdjcRKELVPSOi?=
 =?us-ascii?Q?PcbSA1qLztVrbJarxSITfH1D4RNQ4iq1cn67JDobXON5IxO77PNhIFZdHIcY?=
 =?us-ascii?Q?XoznHXDu7hQ54qacQ0VbNDujVXyazXpGMpn+wL8QyuwmEWvnwYEiX7HfxNSU?=
 =?us-ascii?Q?pIVPdobUs2VP7bu4IfnQ+n3RngQn74HIEIfxufOx8QZNZ5kB6TOHSSlJz2Xi?=
 =?us-ascii?Q?M3uKa/Jgh0n4xOUJxOpnytCqJj7bw2U1b8jFnIkYVcOjD1PzFkCRhz2dxWfT?=
 =?us-ascii?Q?lIHW+Xh8inmtwMDqjnkQpeMB7Kyembwpa//56EZDQifqDrUH83NnQKu1xYs+?=
 =?us-ascii?Q?ZYpYbVeQByR9U4LBRW/7/kRN0w1owvryPah0SxRkMC3molksuoL5ADpOmsjt?=
 =?us-ascii?Q?yPG2ER70OnSi8gYOFpoi+GL/U5SeMEnvT0FuT/qcK9pCmM5RkIeGxZOgZe+v?=
 =?us-ascii?Q?Msmiw76VeVg2+vv8Iou2wJI17suv0hPWJPh6h6pf8Zg5hEcQ9MPz/D1cK23+?=
 =?us-ascii?Q?TR8/tCu5vyK5ayBcvF0viw2XCOr6HbWAl9t5212l0Sfztot8sLdVRYfA8dIz?=
 =?us-ascii?Q?6kD7Z7YJxKIKZPG/LRTnbvMt1xKPU63RZIXUNjARN81trh7eie4PSqxkSKnt?=
 =?us-ascii?Q?R/mrMto=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bc5731-61fd-4de3-bede-08deb74f18de
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 15:39:08.0283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8352
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11132-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_TO(0.00)[linux.microsoft.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SN6PR02MB4157.namprd02.prod.outlook.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,outlook.com:dkim]
X-Rspamd-Queue-Id: A48BA5A9479
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Thursday, May 21, 2026 =
7:34 AM
>=20
> On Wed, May 20, 2026 at 07:26:24PM +0000, Michael Kelley wrote:
> > From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Wednesday, May 20, =
2026 10:15 AM
> > >
> > > On Fri, May 15, 2026 at 07:35:45PM -0300, Jason Gunthorpe wrote:
> > > > On Tue, May 12, 2026 at 12:24:08AM +0800, Yu Zhang wrote:
> > > > > +static inline u16 hv_iommu_fill_iova_list(union hv_iommu_flush_v=
a *iova_list,
> > > > > +					  unsigned long start,
> > > > > +					  unsigned long end)
> > > > > +{
> > > > > +	unsigned long start_pfn =3D start >> PAGE_SHIFT;
> > > > > +	unsigned long end_pfn =3D PAGE_ALIGN(end) >> PAGE_SHIFT;
> > > > > +	unsigned long nr_pages =3D end_pfn - start_pfn;
> > > > > +	u16 count =3D 0;
> > > > > +
> > > > > +	while (nr_pages > 0) {
> > > > > +		unsigned long flush_pages;
> > > > > +		int order;
> > > > > +		unsigned long pfn_align;
> > > > > +		unsigned long size_align;
> > > > > +
> > > > > +		if (count >=3D HV_IOMMU_MAX_FLUSH_VA_COUNT) {
> > > > > +			count =3D HV_IOMMU_FLUSH_VA_OVERFLOW;
> > > > > +			break;
> > > > > +		}
> > > > > +
> > > > > +		if (start_pfn)
> > > > > +			pfn_align =3D __ffs(start_pfn);
> > > > > +		else
> > > > > +			pfn_align =3D BITS_PER_LONG - 1;
> > > > > +
> > > > > +		size_align =3D __fls(nr_pages);
> > > > > +		order =3D min(pfn_align, size_align);
> > > > > +		iova_list[count].page_mask_shift =3D order;
> > > > > +		iova_list[count].page_number =3D start_pfn;
> > > > > +
> > > > > +		flush_pages =3D 1UL << order;
> > > > > +		start_pfn +=3D flush_pages;
> > > > > +		nr_pages -=3D flush_pages;
> > > > > +		count++;
> > > > > +	}
> > > >
> > > > This seems like a really silly hypervisor interface. Why doesn't it
> > > > just accept a normal range? Splitting it into power of two aligned
> > > > ranges is very inefficient.
> > >
> > > Fair point. I'm not sure how much flexibility we have to change
> > > this hypercall interface at the moment - it predates the pvIOMMU
> > > work and may have other consumers beyond Linux guest. On the other
> > > hand, having the guest specify 2^N-aligned blocks does save the
> > > hypervisor from having to decompose ranges itself before issuing
> > > hardware invalidation commands - the guest-provided entries can be
> > > fed to the HW more or less directly.
> > >
> > > That said, the way I'm currently using this interface may be
> > > more precise than necessary. Maybe we have 2 options:
> > >
> > > 1) Current approach: decompose the range into multiple exact
> > >    2^N-aligned blocks with no over-flush, but at the cost of
> > >    more complex calculations and more entries.
> > >
> > > 2) Follow what Intel/AMD drivers do: find a single minimal
> > >    2^N-aligned block that covers the entire range, but may
> > >    over-flush.
> > >
> > > Any preference?
> > >
> > > @Michael, since you've also been reviewing this patch, I'd
> > > appreciate your thoughts on the above as well. :)
> > >
> >
> > I'm just guessing, but perhaps flushing an aligned power-of-2
> > range can be processed by the hypervisor at a relatively fixed
> > cost, regardless of the size. Having the guest do the decomposing
> > of an arbitrary range allows the hypervisor to make use of the
> > existing "rep" hypercall mechanism if the hypercall is taking
> > "too long". The hypervisor can pause its processing, return to
> > the guest temporarily, and then continue the hypercall. If the
> > arbitrary range were passed into the hypercall for the hypervisor
> > to do the decomposing, that pause-and-restart mechanism
> > wouldn't be available.
> >
> > Of course, Linux doesn't really take advantage of the pause to
> > reduce guest interrupt latency because the Hyper-V code in
> > Linux typically disable interrupts around a hypercall due to the
> > way the hypercall input page is allocated. But other guest
> > operating systems might benefit from such a pause. And we could
> > probably fix the Hyper-V code in Linux to allow interrupts during a
> > hypercall pause/restart if long-running hypercalls turn out to be
> > a problem.
> >
> > Regarding proposal (1) vs. (2), perhaps you could confirm with
> > the Hyper-V team that flushing an aligned power-of-2 range
> > has relatively fixed cost, regardless of the size. And what do the
> > flush requests coming from the generic IOMMU subsystem look
> > like? Do they match dma_unmap() ranges, which are probably
> > dominated by relatively small ranges of a few pages at most,
> > with a few outliers for disk I/O requests of 1 MiB or some such?
> > If the dominant flush request is for a few pages at most, then
> > doing (2) seems reasonable.
>=20
> Thanks for the thoughtful suggestions, Michael!
>=20
> I believe the time might be dominated by the number of descriptors,
> instead of the size of each range, especially when device TLB
> invalidations are involved.
>=20
> Here's my understanding of what hypervisor does in its handler:
>=20
> Hyper-V constructs one IOTLB invalidation descriptor (and possibly
> a Device TLB invalidation descriptor as well) per iova_list entry
> and submits them to the HW invalidation queue, then synchronously
> waits for completion. So multiple 2^N-aligned entries should be less
> efficient than a single larger 2^N aligned one.

Agreed. The hypercall time should be roughly linear in the number
of descriptors.

If the approach is to do a precise flush, my argument is that
it is better for the guest to construct the 2^N aligned descriptors
instead of having the host do it. In the former case, the hypercall
can do the pause/resume thing, which provides the opportunity
to reduce interrupt latency in the guest. In the latter case, it cannot.

But my argument is moot if you do Option 2. And I'm fine with
Option 2 if the assumptions about it are true.

Michael

>=20
> Since both options submit 2^N-aligned entries to the hypervisor,
> either one single coarser-grained entry or a precise decomposition,
> I'm now also leaning towards option 2, which is also what Intel/AMD
> drivers do for page-selective IOTLB flush. Simpler guest code, faster
> flush, and the hypervisor can feed the single entry almost directly
> to HW.
>=20
> Yu


