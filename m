Return-Path: <linux-hyperv+bounces-11873-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 90YOK7FRTmq4KgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11873-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 15:33:37 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 452EF726D4F
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 15:33:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=BqpBfc+3;
	dmarc=pass (policy=none) header.from=outlook.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11873-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11873-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78371303ADD6
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jul 2026 13:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71D534104B;
	Wed,  8 Jul 2026 13:28:47 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011028.outbound.protection.outlook.com [52.103.13.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D9F274FDF;
	Wed,  8 Jul 2026 13:28:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517327; cv=fail; b=f1m9m9IUz/VJ52hCp06XpRvepP2GNIEvnkUF+ECJgAWx7P2sB+4+sN62BK97AHGcKfj3tIieVSmgUejIzkEiaXKaVNrrPISiqzFfOBZMGJ8e5nB4uT8/Gw38DxxuynFQqUwVajNNIhc445wDiuc5x7tLRfDdSvhWqNBV6cZbJTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517327; c=relaxed/simple;
	bh=alAgnXA2pdxxrqw4XPSSgucJdKMTwrNuFDDr3thxIVY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BecbHNMML5vWhIRQ+UZvEUwlf1aP2DRoT3jeau4AkQJ7o97cu6MYW7bF+DS8Dph0UfFqnuwHhukOKRgMGxGYDTYB5jU6UuN782StFKBAOT/YFocX3PFQKTHDTmr5d2pCgzgCdJ6zPAx9BjaI8LoSa0DgJmajm42OBDO4L4UdiGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BqpBfc+3; arc=fail smtp.client-ip=52.103.13.28
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8gH14SP9yQXKlDS5aPKrbxSelV06au7BtsYdf4vxy/B79n3mYKLK+UMFeeix13edPQC8Sm+iexbE7CJ9SyEVgF3qZ3sNoCWgk55rt9qzEekNvuCsQo9M6IW2gx1cXa1GtSNQ1tjwtmIZukyddsb9tGGiYKAFKJ5aYctXgVbMRCTP4ewuRqjOAU+NbcWhnRb5ckF8P9sxp1EmUU/xFZNcBk5JUoDQLGHBzF97nII85C/Mjstt8TyLcjRm4UzcoVqb436mRZ3vtpuaymdyR3LnJMs9Dg7RXwmP4q353Sfdw7deoTdO5mxrmRPSE/s6n7h20qRrSvvPjk9EGa/oyfETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alAgnXA2pdxxrqw4XPSSgucJdKMTwrNuFDDr3thxIVY=;
 b=UGEIy1VrCIPnmBRt6nTBxMGpSw2CYMlpPQ1rkLQZcgb4i5X4YpailEk5GXhnrmarnKP6w8C4Wk82pNOOqy31VxezsjkfacLEf/ZD3SQGLXgNoq9zN2LWyyMVjqCtKWh2voDi3wudwyjuFaxvKZOpoVOFQP5V7h96GJesP+rEaukFRZ8oNOql8JkpfQIMcJQRGX+y2Ik0XLnC4d5Z3kbp6P/dN55a4Xy8oo5Z0OKktbJJxU062ZMsKv+lX+IwkecBcaymvvGstyPDXMbXBhLT5+5tSFls7pZkDQJMuSXct6mJT+wRhMVnvMMDCm3LykwRDRahaaAPLymVRNyvLXH78g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alAgnXA2pdxxrqw4XPSSgucJdKMTwrNuFDDr3thxIVY=;
 b=BqpBfc+3ETlmu/IasMaS5Bsno1VF9fQP5rVSNSCUHCURBHg6N6UIfrDXViNbu4VvmN1PufGcMwlTV9oytOKYtiyePhh9vnw3eRJ/Ka/9XmzpelVxhAMvdWMNiSUmtnZDoun/8Y1dCbAP3F+ByRPiotC77C9e3GfWi96RlWFzqQHgOSKHH3TN2rVf3FDXmu23Krn6daCABkool7vMmJ4MjfkHlyiOn7kAJqaGUElAUZQVlFZ7DiyoF2+g3gvVuyQ7ZpwemvZMsMKhrioPhTkuMsR4ZHTuon52kr5eGt4YGQJ9lpktQR2xNW+Omo6H4LktFI3YUaKbfF2aAN1rbCZpxg==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by MN2PR02MB6909.namprd02.prod.outlook.com (2603:10b6:208:202::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Wed, 8 Jul
 2026 13:28:43 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::6007:d1a1:bcf9:58ef%6]) with mapi id 15.21.0181.014; Wed, 8 Jul 2026
 13:28:43 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
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
	<arnd@arndb.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
	"tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>,
	"easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>
Subject: RE: [PATCH v2 2/4] Drivers: hv: Add logical device ID registry for
 vPCI devices
Thread-Topic: [PATCH v2 2/4] Drivers: hv: Add logical device ID registry for
 vPCI devices
Thread-Index: AQHdCjyhy62fRqTOH0yC7zsP+xZ0eLZi9TRggACsLoCAAAMJMA==
Date: Wed, 8 Jul 2026 13:28:42 +0000
Message-ID:
 <BN7PR02MB4148C8DB748CFD863B97D1B7D4FF2@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-3-zhangyu1@linux.microsoft.com>
 <SN6PR02MB415798534DFCC14E5202D021D4FF2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <u2l4lz5skybcukrb6hwp2u6v3jdibrugokxmclgv3uq4ljj3vw@x7mlfvuwb5f4>
In-Reply-To: <u2l4lz5skybcukrb6hwp2u6v3jdibrugokxmclgv3uq4ljj3vw@x7mlfvuwb5f4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|MN2PR02MB6909:EE_
x-ms-office365-filtering-correlation-id: 2d29e9d8-8767-41f5-4560-08dedcf4d494
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|41001999006|19110799012|8022599003|8062599012|31061999003|8060799015|15080799012|37011999003|25010399006|19101099003|10035399007|1602099012|12091999003|56899033|102099032|4302099013|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?aEc1d3dmS0FZV1BjRHZkWnZRamlIWDlBcFl2UXlwcUp3ejNHRnJWYzNvcG45?=
 =?utf-8?B?RVBzbS9yWUJqdU1KSTFGS2MxaGs0L201dldYQjgrUVcxYmE1R0lFRjkwTXc1?=
 =?utf-8?B?TCsvczArbmNzOSsySlFkVDFRZ1oxQWljbE9semkrOTh3UE5rM2t1SzNMSzVp?=
 =?utf-8?B?TVpHVHZyOWlnaGNsWVBmSTA1RUNTekhmSCttcHRXQ0NaMm1QaXZXTGhLQ3VN?=
 =?utf-8?B?djdLK1dZcDhmTEdqQ1M4K2grUmxhUEFPOUNKc3NrWW9RR2ZGazZYYnNYOFdh?=
 =?utf-8?B?OFF6anhVVzBuRTNxVVlneE5Qa3JhT1dQeklISUJGckM4VmsyQ1NZTEFBdXEw?=
 =?utf-8?B?MzMvMUxSeXdLcHJGd3FBMWRaMENhWWg4Z09mZi9nSlR3RVdWN0VpbVdFSDBS?=
 =?utf-8?B?dTlZVlFWa0ZBWG5sNmJWaDhZQVFQYWN1L1JqbTBXZzg4bSttMG9ZNWxmN0VP?=
 =?utf-8?B?RmlGa00raGZsRVJ1U2I1aW1DUWx4MlYvTTFwNENEbnNhMkVLaG1lMUp3cGZQ?=
 =?utf-8?B?UnlLYWltR2hPWG5hS1lxaDhPMGFKT0xhUWRMMDlRVzY4NVF6SmRsOUVmUkFW?=
 =?utf-8?B?S1FCeWp1VjhtK3BZMVVXbm5teCtIU2lDdlI4NUpzSWdyZUpOTEZVWHB2VHd5?=
 =?utf-8?B?ekJWaWxYRDFEeEpjZUN0RVdQRVJzRDI2dnNsUDBrUHk5dUdFQVhWQkpuYmk4?=
 =?utf-8?B?WVB4TzJKM3lMc3RtTFBVZDFrcjRMSGZwY1pMV2pkR0xha2pDZ1doMkJmTWZy?=
 =?utf-8?B?Z3F0Ums0eDFrSnRYSmYxWUNnSTVPdVM0WjdiejRqam82K0xjVU5rWk1oUXFp?=
 =?utf-8?B?bWNPeFdaM3ZzdExnd1JTeFgwNjZDcHFQTHRmSktmTXUvNUVGNFgwL3VwYlZV?=
 =?utf-8?B?c2pGeUprWHBuaFJySGFVWnZ3eVdyWkN5c25KakZnRnQrakxEVkNnQWFBeXNq?=
 =?utf-8?B?c0dnQjFUZS96ek5DSzBSSzFBS3RzU1NRNGhscWpkR1hhclNnVGd3NTRMVExX?=
 =?utf-8?B?WExLNkJWTVB1OFVhYVR3UWd6Tm85U0JsV2I5Z3hzNk0wTk92eFNKM0I2cnBj?=
 =?utf-8?B?QnBwSVY1KzVQemVDNlNPMkJMREs3aktmOWhjT0ZNMFBSYnNwL092RFZ1OEV3?=
 =?utf-8?B?YzRFaUFQdkt4QW9LL3J5OSt2WHFlcVo1bTlJOW83RTdFbTV1QjY0c0J2WGRm?=
 =?utf-8?B?bTVrei9BMVJaY2kxbk1SYUVFQVZoU3MwZjR1U2o4ZFExSjQ4MlE1bFQvcFVx?=
 =?utf-8?B?bkJiMW1OU01jMWdtd0hmNy9jeVIyVEovRGk0ZzVoTjZiSDFTUUdlWjk0K2Qr?=
 =?utf-8?B?WWIrUDF3S2oyenUwaGdsNUs1bU14K21YcTNGQjZCRk9Ccy9XTmUva2c1U2sz?=
 =?utf-8?B?L0xTSU13VDZUMUp2WGhwVTd2eURTZEJUZ2xJQWRXcUp2SnlzN2pGYkNaOHdr?=
 =?utf-8?B?N0tOS1lSd3FXUU4ycGNGOFV6dDNWU21zZWZWVVZMRDBkVXpwRmVBaUNLYklO?=
 =?utf-8?Q?oLvvJaNtcl2tm9XX7i12tkNFGwh?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VW9tSUwwQURpamEzMzRKMEtIcVEybnFrOEVSWDhhMnkrVWRIMit3Z2p4TGw4?=
 =?utf-8?B?ajZrK0Z1dEcvd3FKdytHelhQMDA5S2pGSGlFRjlDZjBBRmpUd1ZRMW1OVFZ5?=
 =?utf-8?B?dUt1OTU0WmZaZ3hvRG4zR3YxaTYrUzh4b28yN3hHbXRPT2c2NE9abEFCY1RQ?=
 =?utf-8?B?WGlBT0s3NzRCN2pySU9kTXBLeFRwenFHK1ZxYzNFbUF2b2QzVDZSWXdvRnEx?=
 =?utf-8?B?MnBvWDUwVnRFQmlGK1BSb0l1ZXZPTlpEenc3L0tWRXd4NjIyaWlGUVRnT3Bl?=
 =?utf-8?B?ajdWMWlxZ2Z4VWVtOGNOeEd3SmpMMkpFemplQVhRK09RcUhwKzJOSDAxV0tS?=
 =?utf-8?B?NGhoR2NiZWg1QUFJR3dqNFU4K1JQWWlIS1pMd3ZEL0tBM0hUMmc5MTNtSWRN?=
 =?utf-8?B?UGZ6WHRDQkZGSzEreHBHL2dXYUM1MFZoQThnd3ExT3lEUDdzMWcrL1p3bThO?=
 =?utf-8?B?aDBvNUhxUlp1VEpBc1YrVTVGRGtBUVkyUzloZmpIOXdJV2RYdnVWNkNvTlFw?=
 =?utf-8?B?bW01bTFqUWpsQ0MrZzhvRkRhWEpoV3B5eU5MbXdjRlpJbUNBYktGWDQwTmZZ?=
 =?utf-8?B?RElwemFCWW9SNzFpN0syOTZtSXBWdFJ5WEM5Zk11WERKWERncmFOUXdBdHYr?=
 =?utf-8?B?SElHM2lsK1FqVTdlR3piNHlCc3lWR0lHbThBSHREZlFQTmd4Z2FpZVMvcWFD?=
 =?utf-8?B?NkE3LzMwaCtRMG8za3NkWTF5MGhnWk1zaEdtOGEvdk1IaVAvdUFJKytLRzVq?=
 =?utf-8?B?UGZ3alJLRG4zRzRNNG5oWk8zbm9xcEFxZHBkL3BvTVFIS0pvRVpjQ2RsVURl?=
 =?utf-8?B?OHhWYUNidlUyV2hOWG53Y05qNnNoSHRxOHZndnhvV1E5SERzN0dPa205eFdp?=
 =?utf-8?B?MVpEcWJWSnN3WCtFT1pDZldXb0owQjh0N25NbzkzZ3dFbVVDUnBlOTZTdWx3?=
 =?utf-8?B?bVNoMkpldThoa3M2bjVLQk50K1luTGZFU2VXR1RoTVFReDNVbi83V1R5N2I1?=
 =?utf-8?B?ZklhUFJ3Vmp4RTd6ekVGd01mNHZxMzBEcjJZUTlRMS9DNG9zeEpFVHdWa0F3?=
 =?utf-8?B?SDFSdHpZMW5neFpaNUhyRVJuQjJWOUNYS01IQjdJY2tCemlHMUMva1EyS3Vr?=
 =?utf-8?B?MGpOYmNxNkttT29mZ2hoS3J5ZWc5UldpRFZHa093N0pvclNEZHpSa3JZKzF5?=
 =?utf-8?B?VlNYeG41VXFmdDNBeVV5dk9CZXVrbGJZeG9Cc1prcitSenBWS2xCRUMvSHNa?=
 =?utf-8?B?ZWlNZkN1QVc5OTRiU0Fxc0t3TXRwUjFwTWJoQUliR0w1eVIra05ra3hvTHQr?=
 =?utf-8?B?eVk0bURiODhUSiswSTdmYXVBZDRYcjlmek9uR1VjYlAyUTE3RGdHYlZsTkRX?=
 =?utf-8?B?K0MzL25mQUxuS2dsWHBVMjAzTFZsbzVLeVJHSnQyVVUvSE5qK3Q1aUF2UW42?=
 =?utf-8?B?V2FjaktMbUkrNmRpYjFKTUw5SXJseGYzV241NTZjOTdCa3ltUklEaEYrZ1dW?=
 =?utf-8?B?aHREVGpZVjJDY3lpbjM2NlJKRkd0TWxjUFpKbzl1NWVLdXRsU01HaFlIMStz?=
 =?utf-8?B?cHN1cHlZRkh6VXQxMmVYRkRuRGw1T2VKSXVzc1dIdFozekFzaDRiVytmQ3g5?=
 =?utf-8?B?MStzRGswd2lXeTJRWmtoaTRuRGV5K3Z5amppY2t2QjhHUUt0OHhEK3hsTURo?=
 =?utf-8?B?QVZ2UStNdWt5cGVBVFFHZDlEUDgyalhOZDVzcy9rOVg5amNZNDR6dHBTRjhs?=
 =?utf-8?B?dkJNR0pOYkErSTJKdHMza2dYM2JuWmg0L2ZyV2VOWFc5RHZubGdSaXJFM1Y4?=
 =?utf-8?Q?xTEgsUlNFHdi+qWa0mDhUabdG9comdkPclKRI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d29e9d8-8767-41f5-4560-08dedcf4d494
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 13:28:42.9621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6909
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11873-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zhangyu1@linux.microsoft.com,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-pci@vger.kernel.org,m:linux-arch@vger.kernel.org,m:wei.liu@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:decui@microsoft.com,m:longli@microsoft.com,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:lpieralisi@kernel.org,m:mani@kernel.org,m:robh@kernel.org,m:arnd@arndb.de,m:jgg@ziepe.ca,m:jacob.pan@linux.microsoft.com,m:tgopinath@linux.microsoft.com,m:easwar.hariharan@linux.microsoft.com,m:mrathor@linux.microsoft.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[outlook.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 452EF726D4F

RnJvbTogWXUgWmhhbmcgPHpoYW5neXUxQGxpbnV4Lm1pY3Jvc29mdC5jb20+IFNlbnQ6IFdlZG5l
c2RheSwgSnVseSA4LCAyMDI2IDY6MDkgQU0NCj4gDQo+IE9uIFdlZCwgSnVsIDA4LCAyMDI2IGF0
IDAyOjUyOjQzQU0gKzAwMDAsIE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+IEZyb206IFl1IFpo
YW5nIDx6aGFuZ3l1MUBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBUaHVyc2RheSwgSnVseSAy
LCAyMDI2IDk6MDUgQU0NCj4gPiA+DQo+ID4gPiBGcm9tOiBFYXN3YXIgSGFyaWhhcmFuIDxlYXN3
YXIuaGFyaWhhcmFuQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+ID4gPg0KPiA+ID4gSHlwZXItViBp
ZGVudGlmaWVzIGVhY2ggUENJIHBhc3MtdGhydSBkZXZpY2UgYnkgYSBsb2dpY2FsIGRldmljZSBJ
RCBpbg0KPiA+ID4gaXRzIGh5cGVyY2FsbCBpbnRlcmZhY2UuIFRoaXMgSUQgY29uc2lzdHMgb2Yg
YSBwZXItYnVzIHByZWZpeCwgZGVyaXZlZA0KPiA+ID4gZnJvbSB0aGUgVk1CdXMgZGV2aWNlIGlu
c3RhbmNlIEdVSUQsIGNvbWJpbmVkIHdpdGggdGhlIFBDSSBmdW5jdGlvbg0KPiA+ID4gbnVtYmVy
IG9mIHRoZSBlbmRwb2ludCBkZXZpY2UuDQo+ID4gPg0KPiA+ID4gQWRkIGEgc21hbGwgcmVnaXN0
cnkgaW4gaHZfY29tbW9uLmMgdGhhdCBtYXBzIGEgUENJIGRvbWFpbiBudW1iZXIgdG8gaXRzDQo+
ID4gPiBsb2dpY2FsIGRldmljZSBJRCBwcmVmaXguIFRoZSB2UENJIGJ1cyBkcml2ZXIgKHBjaS1o
eXBlcnYpIHJlZ2lzdGVycyB0aGUNCj4gPiA+IHByZWZpeCB3aGVuIGEgYnVzIGlzIHByb2JlZCBh
bmQgdW5yZWdpc3RlcnMgaXQgd2hlbiB0aGUgYnVzIGlzIHJlbW92ZWQuDQo+ID4gPiBDb25zdW1l
cnMgc3VjaCBhcyB0aGUgcGFyYS12aXJ0dWFsaXplZCBJT01NVSBkcml2ZXIgbG9vayB1cCB0aGUg
cHJlZml4DQo+ID4gPiBieSBQQ0kgZG9tYWluIG51bWJlciBhbmQgY29tYmluZSBpdCB3aXRoIHRo
ZSBmdW5jdGlvbiBudW1iZXIgdG8gZm9ybSB0aGUNCj4gPiA+IGNvbXBsZXRlIGxvZ2ljYWwgZGV2
aWNlIElEIGZvciBoeXBlcmNhbGxzLg0KPiA+ID4NCj4gPiA+IFRoZSBwcmVmaXggY29uc3RydWN0
aW9uIGlzIHNoYXJlZCB2aWEgaHZfYnVpbGRfbG9naWNhbF9kZXZfaWRfcHJlZml4KCkgc28NCj4g
PiA+IHRoYXQgcGNpLWh5cGVydidzIGludGVycnVwdCByZXRhcmdldGluZyBwYXRoIGFuZCB0aGUg
cmVnaXN0cnkgdXNlIGV4YWN0bHkNCj4gPiA+IHRoZSBzYW1lIGJ5dGUgbGF5b3V0LiBJdCBpcyBk
ZXJpdmVkIG9uIGRlbWFuZCBmcm9tIHRoZSBjb25zdGFudCBodl9kZXZpY2UNCj4gPiA+IGluc3Rh
bmNlIEdVSUQgcmF0aGVyIHRoYW4gY2FjaGVkIGluIHN0cnVjdCBodl9wY2lidXNfZGV2aWNlLCB3
aGljaCBpcw0KPiA+ID4gcHJpdmF0ZSB0byB0aGUgcGNpLWh5cGVydiBtb2R1bGU7IHRoaXMga2Vl
cHMgdGhlIGludGVyZmFjZSBuYXJyb3cgYW5kDQo+ID4gPiBhdm9pZHMgZGVwZW5kaW5nIG9uIHBj
aS1oeXBlcnYgaW50ZXJuYWxzLg0KPiA+ID4NCj4gPiA+IENvLWRldmVsb3BlZC1ieTogWXUgWmhh
bmcgPHpoYW5neXUxQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZ
dSBaaGFuZyA8emhhbmd5dTFAbGludXgubWljcm9zb2Z0LmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEVhc3dhciBIYXJpaGFyYW4gPGVhc3dhci5oYXJpaGFyYW5AbGludXgubWljcm9zb2Z0LmNv
bT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvaHYvaHZfY29tbW9uLmMgICAgICAgICAgICAg
IHwgOTUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ICBkcml2ZXJzL3BjaS9j
b250cm9sbGVyL3BjaS1oeXBlcnYuYyB8IDIxICsrKysrLS0NCj4gPiA+ICBpbmNsdWRlL2FzbS1n
ZW5lcmljL21zaHlwZXJ2LmggICAgICB8IDEzICsrKysNCj4gPiA+ICBpbmNsdWRlL2xpbnV4L2h5
cGVydi5oICAgICAgICAgICAgICB8ICA4ICsrKw0KPiA+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMTMy
IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaHYvaHZfY29tbW9uLmMgYi9kcml2ZXJzL2h2L2h2X2NvbW1vbi5jDQo+ID4gPiBp
bmRleCA2YjY3YWM2MTY3ODkuLjUzNDkzZjhkMTRkYyAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZl
cnMvaHYvaHZfY29tbW9uLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvaHYvaHZfY29tbW9uLmMNCj4g
PiA+IEBAIC0yNiw2ICsyNiw4IEBADQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2ttc2dfZHVtcC5o
Pg0KPiA+ID4gICNpbmNsdWRlIDxsaW51eC9zaXplcy5oPg0KPiA+ID4gICNpbmNsdWRlIDxsaW51
eC9zbGFiLmg+DQo+ID4gPiArI2luY2x1ZGUgPGxpbnV4L2xpc3QuaD4NCj4gPiA+ICsjaW5jbHVk
ZSA8bGludXgvc3BpbmxvY2suaD4NCj4gPiA+ICAjaW5jbHVkZSA8bGludXgvZG1hLW1hcC1vcHMu
aD4NCj4gPiA+ICAjaW5jbHVkZSA8bGludXgvc2V0X21lbW9yeS5oPg0KPiA+ID4gICNpbmNsdWRl
IDxoeXBlcnYvaHZoZGsuaD4NCj4gPiA+IEBAIC04NjMsMyArODY1LDk2IEBAIGNvbnN0IGNoYXIg
Kmh2X3Jlc3VsdF90b19zdHJpbmcodTY0IHN0YXR1cykNCj4gPiA+ICAJcmV0dXJuICJVbmtub3du
IjsNCj4gPiA+ICB9DQo+ID4gPiAgRVhQT1JUX1NZTUJPTF9HUEwoaHZfcmVzdWx0X3RvX3N0cmlu
Zyk7DQo+ID4gPiArDQo+ID4gPiArI2lmZGVmIENPTkZJR19IWVBFUlZfUFZJT01NVQ0KPiA+ID4g
Ky8qDQo+ID4gPiArICogTG9naWNhbCBkZXZpY2UgSUQgcmVnaXN0cnkgc2hhcmVkIGJldHdlZW4g
dGhlIHZQQ0kgYnVzIGRyaXZlcg0KPiA+ID4gKyAqIChwY2ktaHlwZXJ2KSBhbmQgdGhlIHBhcmEt
dmlydHVhbGl6ZWQgSU9NTVUgZHJpdmVyLiBUaGUgdlBDSSBkcml2ZXINCj4gPiA+ICsgKiByZWdp
c3RlcnMgdGhlIHBlci1idXMgbG9naWNhbCBkZXZpY2UgSUQgcHJlZml4IGF0IGJ1cyBwcm9iZSB0
aW1lLCBhbmQNCj4gPiA+ICsgKiB0aGUgcHZJT01NVSBkcml2ZXIgbG9va3MgaXQgdXAgdG8gYnVp
bGQgdGhlIGZ1bGwgbG9naWNhbCBkZXZpY2UgSUQgdXNlZA0KPiA+ID4gKyAqIGluIElPTU1VIGh5
cGVyY2FsbHMuDQo+ID4gPiArICovDQo+ID4gPiArc3RydWN0IGh2X3BjaV9idXNkYXRhIHsNCj4g
PiA+ICsJaW50CQkgcGNpX2RvbWFpbl9ucjsNCj4gPiA+ICsJdTMyCQkgbG9naWNhbF9kZXZfaWRf
cHJlZml4Ow0KPiA+ID4gKwlzdHJ1Y3QgbGlzdF9oZWFkIGxpc3Q7DQo+ID4gPiArfTsNCj4gPiA+
ICsNCj4gPiA+ICtzdGF0aWMgTElTVF9IRUFEKGh2X3BjaV9idXNfbGlzdCk7DQo+ID4gPiArc3Rh
dGljIERFRklORV9TUElOTE9DSyhodl9wY2lfYnVzX2xvY2spOw0KPiA+ID4gKw0KPiA+ID4gK2lu
dCBodl9pb21tdV9yZWdpc3Rlcl9wY2lfYnVzKGludCBwY2lfZG9tYWluX25yLCB1MzIgbG9naWNh
bF9kZXZfaWRfcHJlZml4KQ0KPiA+ID4gK3sNCj4gPiA+ICsJc3RydWN0IGh2X3BjaV9idXNkYXRh
ICpidXMsICpuZXc7DQo+ID4gPiArCWludCByZXQgPSAwOw0KPiA+ID4gKw0KPiA+ID4gKwluZXcg
PSBremFsbG9jX29iaigqbmV3LCBHRlBfS0VSTkVMKTsNCj4gPiA+ICsJaWYgKCFuZXcpDQo+ID4g
PiArCQlyZXR1cm4gLUVOT01FTTsNCj4gPiA+ICsNCj4gPiA+ICsJc3Bpbl9sb2NrKCZodl9wY2lf
YnVzX2xvY2spOw0KPiA+ID4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5KGJ1cywgJmh2X3BjaV9idXNf
bGlzdCwgbGlzdCkgew0KPiA+ID4gKwkJaWYgKGJ1cy0+cGNpX2RvbWFpbl9uciAhPSBwY2lfZG9t
YWluX25yKQ0KPiA+ID4gKwkJCWNvbnRpbnVlOw0KPiA+ID4gKw0KPiA+ID4gKwkJaWYgKGJ1cy0+
bG9naWNhbF9kZXZfaWRfcHJlZml4ICE9IGxvZ2ljYWxfZGV2X2lkX3ByZWZpeCkgew0KPiA+ID4g
KwkJCXByX2Vycigic3RhbGUgcmVnaXN0cmF0aW9uIGZvciBQQ0kgZG9tYWluICVkIChvbGQgcHJl
Zml4IDB4JTA4eCwgbmV3IDB4JTA4eClcbiIsDQo+ID4gPiArCQkJICAgICAgIHBjaV9kb21haW5f
bnIsIGJ1cy0+bG9naWNhbF9kZXZfaWRfcHJlZml4LA0KPiA+ID4gKwkJCSAgICAgICBsb2dpY2Fs
X2Rldl9pZF9wcmVmaXgpOw0KPiA+ID4gKwkJCXJldCA9IC1FRVhJU1Q7DQo+ID4gPiArCQl9DQo+
ID4gPiArDQo+ID4gPiArCQlnb3RvIG91dF9mcmVlOw0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4g
PiArCW5ldy0+cGNpX2RvbWFpbl9uciA9IHBjaV9kb21haW5fbnI7DQo+ID4gPiArCW5ldy0+bG9n
aWNhbF9kZXZfaWRfcHJlZml4ID0gbG9naWNhbF9kZXZfaWRfcHJlZml4Ow0KPiA+ID4gKwlsaXN0
X2FkZCgmbmV3LT5saXN0LCAmaHZfcGNpX2J1c19saXN0KTsNCj4gPiA+ICsJc3Bpbl91bmxvY2so
Jmh2X3BjaV9idXNfbG9jayk7DQo+ID4gPiArCXJldHVybiAwOw0KPiA+ID4gKw0KPiA+ID4gK291
dF9mcmVlOg0KPiA+ID4gKwlzcGluX3VubG9jaygmaHZfcGNpX2J1c19sb2NrKTsNCj4gPiA+ICsJ
a2ZyZWUobmV3KTsNCj4gPiA+ICsJcmV0dXJuIHJldDsNCj4gPiA+ICt9DQo+ID4gPiArRVhQT1JU
X1NZTUJPTF9GT1JfTU9EVUxFUyhodl9pb21tdV9yZWdpc3Rlcl9wY2lfYnVzLCAicGNpLWh5cGVy
diIpOw0KPiA+ID4gKw0KPiA+ID4gK3ZvaWQgaHZfaW9tbXVfdW5yZWdpc3Rlcl9wY2lfYnVzKGlu
dCBwY2lfZG9tYWluX25yKQ0KPiA+ID4gK3sNCj4gPiA+ICsJc3RydWN0IGh2X3BjaV9idXNkYXRh
ICpidXMsICp0bXA7DQo+ID4gPiArDQo+ID4gPiArCXNwaW5fbG9jaygmaHZfcGNpX2J1c19sb2Nr
KTsNCj4gPiA+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKGJ1cywgdG1wLCAmaHZfcGNpX2J1
c19saXN0LCBsaXN0KSB7DQo+ID4gPiArCQlpZiAoYnVzLT5wY2lfZG9tYWluX25yID09IHBjaV9k
b21haW5fbnIpIHsNCj4gPiA+ICsJCQlsaXN0X2RlbCgmYnVzLT5saXN0KTsNCj4gPiA+ICsJCQlr
ZnJlZShidXMpOw0KPiA+ID4gKwkJCWJyZWFrOw0KPiA+ID4gKwkJfQ0KPiA+ID4gKwl9DQo+ID4g
PiArCXNwaW5fdW5sb2NrKCZodl9wY2lfYnVzX2xvY2spOw0KPiA+ID4gK30NCj4gPiA+ICtFWFBP
UlRfU1lNQk9MX0ZPUl9NT0RVTEVTKGh2X2lvbW11X3VucmVnaXN0ZXJfcGNpX2J1cywgInBjaS1o
eXBlcnYiKTsNCj4gPiA+ICsNCj4gPiA+ICsvKg0KPiA+ID4gKyAqIExvb2sgdXAgdGhlIGxvZ2lj
YWwgZGV2aWNlIElEIHByZWZpeCByZWdpc3RlcmVkIGZvciBAcGNpX2RvbWFpbl9uci4NCj4gPiA+
ICsgKiBSZXR1cm5zIDAgb24gc3VjY2VzcyB3aXRoICpwcmVmaXggZmlsbGVkIGluOyAtRU5PREVW
IGlmIG5vIGVudHJ5IGlzDQo+ID4gPiArICogcmVnaXN0ZXJlZCBmb3IgdGhhdCBQQ0kgZG9tYWlu
Lg0KPiA+ID4gKyAqLw0KPiA+ID4gK2ludCBodl9pb21tdV9sb29rdXBfbG9naWNhbF9kZXZfaWQo
aW50IHBjaV9kb21haW5fbnIsIHUzMiAqcHJlZml4KQ0KPiA+ID4gK3sNCj4gPiA+ICsJc3RydWN0
IGh2X3BjaV9idXNkYXRhICpidXM7DQo+ID4gPiArCWludCByZXQgPSAtRU5PREVWOw0KPiA+ID4g
Kw0KPiA+ID4gKwlzcGluX2xvY2soJmh2X3BjaV9idXNfbG9jayk7DQo+ID4gPiArCWxpc3RfZm9y
X2VhY2hfZW50cnkoYnVzLCAmaHZfcGNpX2J1c19saXN0LCBsaXN0KSB7DQo+ID4gPiArCQlpZiAo
YnVzLT5wY2lfZG9tYWluX25yID09IHBjaV9kb21haW5fbnIpIHsNCj4gPiA+ICsJCQkqcHJlZml4
ID0gYnVzLT5sb2dpY2FsX2Rldl9pZF9wcmVmaXg7DQo+ID4gPiArCQkJcmV0ID0gMDsNCj4gPiA+
ICsJCQlicmVhazsNCj4gPiA+ICsJCX0NCj4gPiA+ICsJfQ0KPiA+ID4gKwlzcGluX3VubG9jaygm
aHZfcGNpX2J1c19sb2NrKTsNCj4gPiA+ICsJcmV0dXJuIHJldDsNCj4gPiA+ICt9DQo+ID4NCj4g
PiBJIHN0YXJ0ZWQgdGhpbmtpbmcgYWJvdXQgdGhlIG1lY2hhbmlzbSBoZXJlIGJlY2F1c2UgaXQn
cyBzb21ld2hhdA0KPiA+IGFubm95aW5nIHRoYXQgaXQgdGFrZXMgNzcgbGluZXMgb2YgY29kZSAo
c2FucyBjb21tZW50cykgdG8gbWFuYWdlDQo+ID4gdGhpcyBzaW1wbGUgbGl0dGxlIG1hcHBpbmcu
IEkgYWxzbyBzdGFydGVkIHRoaW5raW5nIGFib3V0IGhvdyBtYW55IGVudHJpZXMNCj4gPiBhcmUg
bGlrZWx5IHRvIGJlIGluIHRoZSBtYXBwaW5nLiBBIGd1ZXN0IFZNIHByb2JhYmx5IGhhcyBmZXdl
ciB0aGFuIDEwDQo+ID4gZW50cmllcyB1bmxlc3MgaXQgaGFzIG11bHRpcGxlIE5JQ3MgYW5kIG1h
eWJlIHNvbWUgR1BVcy4gQnV0IHRoaXMgY29kZQ0KPiA+IGlzIGFsc28gaW50ZW5kZWQgdG8gYmUg
dXNlZCBieSB0aGUgTGludXgtYXMtcm9vdCBjb2RlLCBhbmQgSSdtIHRoaW5raW5nDQo+ID4gdGhh
dCB0aGUgbnVtYmVyIG9mIFBDSSBkZXZpY2VzIG1hbmFnZWQgYnkgdGhlIHJvb3QgY291bGQgZWFz
aWx5IGJlIGENCj4gPiBodW5kcmVkIG9yIG1vcmUgaWYgdGhlIHJvb3QgaXMgbWFuYWdpbmcgYSBj
b3VwbGUgZG96ZW4gVk1zIG9uIGEgbGFyZ2UNCj4gPiBwaHlzaWNhbCBzZXJ2ZXIuIFNlYXJjaGlu
ZyBhIGxpbmtlZCBsaXN0IHdpdGggMTAwIG9yIG1vcmUgZW50cmllcyBjb3VsZCBiZQ0KPiA+IGEg
Yml0IHNsb3cuDQo+ID4NCj4gPiBJZiBvbmx5IHRoZSBndWVzdCBzY2VuYXJpbyB3ZXJlIG5lZWRl
ZCwgeW91IGNvdWxkIGRlY2xhcmUgYSBzdGF0aWMNCj4gPiBhcnJheSB3aXRoIDY0IGVudHJpZXMg
KDY0IGlzIGFuIGFyYml0cmFyeSB1cHBlciBib3VuZCksIGFuZCBqdXN0IHNlYXJjaA0KPiA+IHRo
cm91Z2ggdGhlIGFycmF5IGluc3RlYWQgb2YgaGF2aW5nIHRvIGFsbG9jYXRlIG1lbW9yeSwgZGVh
bCB3aXRoDQo+ID4gYWxsb2NhdGlvbiBmYWlsdXJlcywgYW5kIGRlYWwgd2l0aCBsaW5rZWQgbGlz
dHMuIEJ1dCBhIGZpeGVkIHNpemUgYXJyYXkNCj4gPiB3b3VsZCBuZWVkIHRvIGJlIG11Y2ggYmln
Z2VyIGZvciB0aGUgcm9vdCBzY2VuYXJpbywgYW5kIHlvdSB3b3VsZA0KPiA+IHN0aWxsIGJlIGRv
aW5nIGEgbGluZWFyIHNlYXJjaC4NCj4gPg0KPiA+IEEgYmV0dGVyIGFsdGVybmF0aXZlIHRvIGNv
bnNpZGVyIGlzIHJoYXNodGFibGUsIHdoaWNoIGlzIGFuIGV4aXN0aW5nDQo+ID4gTGludXgga2Vy
bmVsIGZhY2lsaXR5LiBCYXNlZCBvbiB3aGF0IGFuIEFJIGJvdCBnZW5lcmF0ZWQgZm9yIG1lLCB0
aGUNCj4gPiBjb2RlIGZvciBzZXR0aW5nIHVwIGFuZCB1c2luZyByaGFzaHRhYmxlIGlzIHN0cmFp
Z2h0Zm9yd2FyZCwgYW5kDQo+ID4gd291bGQgcHJvYmFibHkgcmVzdWx0IGluIGZhciBmZXdlciB0
aGFuIDc3IGxpbmVzIG9mIGNvZGUuIExvb2t1cHMNCj4gPiB3b3VsZCBhbHNvIGJlIGZhc3RlciB0
aGFuIGEgbGluZWFyIHNlYXJjaCwgYXQgbGVhc3QgZm9yIHRoZSByb290IGNhc2UNCj4gPiB3aXRo
IG1vcmUgdGhhbiBqdXN0IGEgZmV3IGVudHJpZXMuIEknZCBzdWdnZXN0IGxvb2tpbmcgYXQgcmhh
c2h0YWJsZQ0KPiA+IHRvIHNlZSB3aGV0aGVyIHlvdSBsaWtlIGhvdyB0aGUgcmVzdWx0aW5nIGNv
ZGUgY29tZXMgb3V0IGZvciB0aGlzDQo+ID4gdXNlIGNhc2UsIGFuZCB3aGV0aGVyIGl0IHJlYWxs
eSBpcyBzaW1wbGVyIHRoYW4gYSByb2xsLXlvdXItb3duIGxpbmtlZA0KPiA+IGxpc3QuDQo+ID4N
Cj4gDQo+IFRoYW5rIHlvdSBzbyBtdWNoIGZvciB0aGlua2luZyB0aGlzIHRocm91Z2gsIE1pY2hh
ZWwhIFRoYXQgaXMgcmVhbGx5DQo+IGEgdmFsaWQgY29uY2Vybi4NCj4gDQo+IEhvdyBhYm91dCB1
c2luZyBYQXJyYXk/IEl0IG1pZ2h0IGJlIG1vcmUgbGlnaHR3ZWlnaHQgY29tcGFyZWQgd2l0aA0K
PiByaGFzaHRhYmxlLiBVc2luZyBwY2lfZG9tYWluX25yIGFzIHRoZSBrZXkgYW5kIHByZWZpeCBh
cyB0aGUgdmFsdWUuDQo+IE1heWJlIHN0aC4gbGlrZToNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICDilIMNCj4gCXN0YXRpYyBERUZJTkVfWEFSUkFZKGh2X3BjaV9idXNf
eGEpOw0KPiANCj4gCWludCBodl9pb21tdV9yZWdpc3Rlcl9wY2lfYnVzKGludCBkb21haW5fbnIs
IHUzMiBwcmVmaXgpDQo+IAl7DQo+IAkJcmV0dXJuIHhhX2luc2VydCgmaHZfcGNpX2J1c194YSwg
ZG9tYWluX25yLA0KPiAJCQkJeGFfbWtfdmFsdWUocHJlZml4KSwgR0ZQX0tFUk5FTCk7DQo+IAl9
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg4pSDDQo+IA0KPiAJdm9pZCBodl9pb21tdV91
bnJlZ2lzdGVyX3BjaV9idXMoaW50IGRvbWFpbl9ucikNCj4gCXsNCj4gCQl4YV9lcmFzZSgmaHZf
cGNpX2J1c194YSwgZG9tYWluX25yKTsNCj4gCX0NCj4gDQo+IAlpbnQgaHZfaW9tbXVfbG9va3Vw
X2xvZ2ljYWxfZGV2X2lkKGludCBkb21haW5fbnIsIHUzMiAqcHJlZml4KQ0KPiAJew0KPiAJCXZv
aWQgKmVudHJ5ID0geGFfbG9hZCgmaHZfcGNpX2J1c194YSwgZG9tYWluX25yKTsNCj4gCQlpZiAo
IWVudHJ5KQ0KPiDilIMNCj4gCQkJcmV0dXJuIC1FTk9ERVY7DQo+IAkJKnByZWZpeCA9IHhhX3Rv
X3ZhbHVlKGVudHJ5KTsNCj4gCQlyZXR1cm4gMDsNCj4g4pSDDQo+IAl9DQo+IA0KDQp4YXJyYXkg
aXMgYmVzdCB3aGVyZSB0aGUga2V5cyBhcmUgZGVuc2Ugb3IgbW9zdGx5IGRlbnNlIGludGVnZXJz
LiBJbg0KdGhpcyB1c2UgY2FzZSwgdGhlIHBjaV9kb21haW5fbnIga2V5cyBhcmUgZXNzZW50aWFs
bHkgcmFuZG9tIDE2LWJpdA0KdmFsdWVzLCB3aGljaCBkb2Vzbid0IGZpdCB4YXJyYXkgYXMgd2Vs
bC4gSXQgd291bGQgd29yaywgYnV0IHdvdWxkbid0DQpiZSB2ZXJ5IGVmZmljaWVudC4gU2VlIHRo
ZSAybmQgcGFyYWdyYXBoIG9mIHRoZSBkb2N1bWVudGF0aW9uIGhlcmU6DQoNCmh0dHBzOi8vd3d3
Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L2NvcmUtYXBpL3hhcnJheS5odG1sI3hhcnJheQ0K
DQpNaWNoYWVsDQo=

