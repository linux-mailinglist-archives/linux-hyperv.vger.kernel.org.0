Return-Path: <linux-hyperv+bounces-9966-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFwgCuj8z2nt2AYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9966-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 19:46:16 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B70F397222
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 19:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63B6D3023E34
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2026 17:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1BE3AA514;
	Fri,  3 Apr 2026 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nMRA56+R"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazolkn19011025.outbound.protection.outlook.com [52.103.13.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D71B1DC9B5;
	Fri,  3 Apr 2026 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775238372; cv=fail; b=GANnWp0EcqLGPyLad5UaAaMYKDpZ0mgYnB6v0gVhPvL6mloA7JuEpivjilhCsUpcZq4XB7DoSI62kjU9F0C4llsG9b4h4O3qaVnETd7LF9u2aLiCMnT4uzKJ6m4R69mD0YuESucTKh+RmjWqFxnxI7x+/P2Vep1hNy+w7QWLHI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775238372; c=relaxed/simple;
	bh=ODJ7IUDSZWVMcjLFCYLTdWwWCDf+0KqzV2YTh/MlN8o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HYkWp5ZXmy3w1oVGRDxJKz79r4DZayNo6E2QSuqumErVztkxzr97dhY+ZDL59lJS6O7SKt6HTybDtw0Ck9RcywUG+ci/8BPPWQrW5OKbtuZnIVxi4IIPLvXFLiNidjE4w/x0ysFdkcK8rGYovGlt01eDySgZ/I7PDCtQk1lv3Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nMRA56+R; arc=fail smtp.client-ip=52.103.13.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3CQu+lKV0pMLUAh8SDpsKFrZnJK/J/b2vkm2nvuVyYErU8HLJ+dbi97wAttouD+68P9B8yV0L0Yn0/GbiXoUlNlBf3Te5O7c4rdNZYR4AcBkVxpqeB58wpvqjM+NjEzxN3WWJAuepHx2wbfSEHPBpJE2QMEn+k8QrAkcwVAbi/rfIxLQiHArTFbNg116gOOUGbrO4tQSXDQY5aVvTVm7DCYBEnHxUki8NaIyRXKL8EaKx8w3knsnplTzyuhqlKxT9SCIMaUDn8Z+gwjjPryPsppWC0Jc6w5AFq9sP+XwZbOYZ6IMF8sgM2yJF84tpa4rzXTPBKHfFpF0uLOiQ2rCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODJ7IUDSZWVMcjLFCYLTdWwWCDf+0KqzV2YTh/MlN8o=;
 b=W73wvEWYAwRi7AYmdCsAA6I8u/cEU5KPXVJ1Q2Ab9hiy43mV/XRg+L9dacPGf1G4nsaFBYmj9i58zgVlL7Bi+y0cuscivJxog0AHwD62cdqlE/9G+dbrgxtEbJzYUxae02Zu1mhwU5Ij/+2eRlFi5dj9BzIt5MBQg8DG0iWyshUK+5cWO3cf0yqMsFZ/px8T86H3jYxAvpm/9XxUwQlu7DZL2tWFeekpeschdOmU8V2omF92ST7YQj84UfzCBq80W93r0Y2snMYLw5cEO8yHZdk24+QqdOLb8TnDPsvIEZ2Ajd8QarZfTfHFZsOXRvTLEVvs2AuTXCXHNdvENEByIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODJ7IUDSZWVMcjLFCYLTdWwWCDf+0KqzV2YTh/MlN8o=;
 b=nMRA56+RCS9ZdX8+LFh95GnNKDg7Z0pd7civs183lsnzrnXMJArzuA6OoN4S4vmnqlo7NdBytDXfA+pTRSZqB2mnkeFxC2E/hIZsmRpdBhmkVEgT2967U6+51JwmjDPFe5Vka/7OtShbfK0DS8KZnWbmGDRF11kzYbK/UuaQOttbV2SM2q3PAspJZu3qx+Q/NluwNN1ATAyN2NALLdjQPYJaoLkcKXsvdnKFvA6YbgGVxlHe+V9D6Kf3aigo0zuQui9EAx4w+L8Exn9L6BCu9erkAuMOZ7xQtd+nPEtvQPDJM2+EU5GciIVOI8MK8mU9nV6XsV/bmnrS49JNDvGd3w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DS4PR02MB10866.namprd02.prod.outlook.com (2603:10b6:8:2a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 17:46:09 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Fri, 3 Apr 2026
 17:46:09 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, Michael
 Kelley <mhklinux@outlook.com>
CC: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Long Li <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/4] drivers: hv: mark channel attributes as const
Thread-Topic: [PATCH v2 4/4] drivers: hv: mark channel attributes as const
Thread-Index: AQHcw0P3z45RK3Oy6Uq/8UKRaZzrg7XNfm8AgAAFPYCAABlKIA==
Date: Fri, 3 Apr 2026 17:46:08 +0000
Message-ID:
 <SN6PR02MB4157E78194EB62F1D73FFA75D45EA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260403-sysfs-const-hv-v2-0-8932ab8d41db@weissschuh.net>
 <20260403-sysfs-const-hv-v2-4-8932ab8d41db@weissschuh.net>
 <SN6PR02MB4157D5F04608E4E3C21AB56ED45EA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <8d8fdf46-5374-4e23-9c79-140117724441@t-8ch.de>
In-Reply-To: <8d8fdf46-5374-4e23-9c79-140117724441@t-8ch.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DS4PR02MB10866:EE_
x-ms-office365-filtering-correlation-id: a23d689e-38be-4372-2d0e-08de91a8e37f
x-ms-exchange-slblob-mailprops:
 P1EfU6pZOd8VPwDsmXmpSwyPl9aRR8R+2HUhb5AATOIsvaxHp4hyJOqGcHv/DYZIiJOT9HvpTAUuS82TW6wq7QzCk3mPs4Gv5fNcCfK3xCTOsFinbdTlygSnoI7kgePtBB1zt3N0oKgsQZX/7oAV/lEMDwcfBdUQddUc7hSK+oX1mfXDEeWWSgpNU6FTEKxi2UbxG2LLCKYVkvGe2+GZF4qZ8edoz3jaO99+RjB/GgLTxEvDGYMLvjEn1K2jqbJHHBaPSyrmO3hOkm0qRLMuj17YUOnWWsFpCDfMgQJo3DzetvGBrrR2SdRMXbXg7IX6PUH9v+nmNyj+6Sx42IjXnyuG54OvjpjBnBAvd+Vy2a0Y4U1uS7Ojy0m4i7jMeAgpd8FGSiwOyw9L/TYkP0A3vtG4x6q4nUZSs/4dM/6hOAOEzyE6t/Fo+skTR59l7PnjT7nxaGf++NPX56rFISBZEduMUvMYmk+aqpFjizulgOJifKjT+drBzTKw9omwSPJ2H1k7jfwnzEe6ovOXeX+wk1zQcohFvIGkj9aYIJGpO8E0knjBLsrtVwOm+z4fdhcVmecIJVXMtXWlUy+sQTZaMVJIBwGFRpN6XAqOkCOPspr1cXVzBmhHboLIaQCeuFkP3676141BQEh63JEffP6OHMTA9A6S3+gx7RbWxceKYOxUJCvFr2rkTmPYY8lsjrxqiEH+aldERYHeQmak/oOFijqK2m3GQGODPIHb6W+936zrsr9xDbHQJSQ7stIrUOoWLP8pO3XYddcCIKDF58jj43OF2JRVuOOefGPCiAFLtvDA0Q82BxS18Q==
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|51005399006|37011999003|19110799012|31061999003|461199028|8062599012|15080799012|8060799015|1602099012|40105399003|440099028|3412199025|4302099013|10035399007|102099032|26121999003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?SWxGcFE5WmpuOEp0THNBbm5POWNWQTlScWFkdVRqNnpRMHBMdzVrTTNmSExp?=
 =?utf-8?B?blN5L0pIcVFKclVvN25GaFBuRXFsaDRST3VNeURkMFdCYkh1RXVTSndqNEsv?=
 =?utf-8?B?NTR0T3hua2JNK2tBdmdtaHFLeEtjV21mOG13UXNtb1N2Y2xOR2d5aWtmWEli?=
 =?utf-8?B?a041YS8vM3FyL1FMZU9yMWh1ek5yZjRTWUdFemIrQVZuWE05Zm5RUE5vY1J1?=
 =?utf-8?B?VTNVdHg3L09KdmwyYmMySUNHbitIRGhFY3NZeTBmdmQ5K2hNdnNLNnkxSzRh?=
 =?utf-8?B?OStkb0l5cW9oK09xWGlkTTNsbFZmVkFMeVZ1RkRLVFBzcnVZTm95OFV0cHlV?=
 =?utf-8?B?bVhWWG9ZOFpxdzdLTXNSeFpqZzBrYi8vVGU5enJpRm1nMzdURlBvOVVYOXVF?=
 =?utf-8?B?ajZJWDF0ZkJxUVV2eHVTOW8zNFhGYmI3QVNtU00rOUp5Qi8wcTdNbjFmaEtZ?=
 =?utf-8?B?aWRucHBLSWVmay9xdlk5OHI1UGg5VzIyRzFRd2ppTmMvY2NlZEdRc1ByTTU3?=
 =?utf-8?B?Mk5Nc2FUVzBFQjErNEVmZVlGTWNYa0lmenFKaUFOczhvMllhMS8zUjlWTXNS?=
 =?utf-8?B?OTlsVHZ0MW5PUHhVQnBVRWJGT2lZNFl6amIrYWYrSzdCMHFUTFFSUFkrVlhq?=
 =?utf-8?B?ak1FbEF6M1FYV29CQU9YRm5yYW5nM3I5L1FSVFdON2NIWG1zeERHMGZScnVN?=
 =?utf-8?B?RDRKWHhCMHd5WE5LYUl3a3dicXhqajIwVGVrZnBDVFo2RVRFb1ZWS1kvRDVs?=
 =?utf-8?B?c3VYdDJjNTg0UDJteTdaVVBDMVdJUWVUYXVpTmxOOHhjZGhPMElUMHljN2ww?=
 =?utf-8?B?MU5hNWpQR0VKb01qVzZaMC82NWtZUWE5UENXU3FRU2VkMlR5L09PWGxXeEtq?=
 =?utf-8?B?dmxDMGhpZVBiMFNLWkFyc0QzNzcrU1E2YThack9SV0l5MUovUmtoOFUxZjJn?=
 =?utf-8?B?anRVY2xkd3VmYkxLL3NiT2lGSi9QRmNFRzEvWlVKZkpaMFlTVVF2eXBjQlZJ?=
 =?utf-8?B?S1N6Zm9JbFFwZ1BOWmVSMFEzbjIwVENzWFQ1aGVJWjJLeHIxcm9lY005cmR0?=
 =?utf-8?B?YW4wS2thNGlubFdXck9ta0plRzVDWjVNWlVFOCtBaEswb1JTb1JYZGErbzFC?=
 =?utf-8?B?ZHY0SThqT1FxMDh3bTFIWHlaUzY3VWYySC9HaGFSZmlPQ0x1Wi9Mb3lWbnRk?=
 =?utf-8?B?ZzAxMVlJemROb1lQU2gzWUUvb1hjeXdiemRzWE52Yk1nZzNuZlVKOEpZT1Ex?=
 =?utf-8?B?YmMxMHlyZUJCOTJWNVh3QytzeU1HVHlBbTBoaXFTTDh4YVpFYWtTZzFlUjU1?=
 =?utf-8?B?MzY1eTY1blpvTkVYa0ZBV3IrWmloMkg0R0FsTnY2UXdnamhZSk8vR2MzUzAw?=
 =?utf-8?B?Z2tManVSdXVGZm42c1gwUlhSK3NKK0hzZEtMbDgxS1ptQUhPb201bUJZZlJN?=
 =?utf-8?B?VEVUUUo5VGxqbklMbzhFb0RFcW1mYU5yVXlNOTVqUEZyaWJvUkpvUnd4YVFT?=
 =?utf-8?Q?EU41Ew=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SEg1d1ZNeVRaWmJYVWFvcTl2clNnWjgyR1pOUVNRc0tsVE45UDMyVjRRbUJw?=
 =?utf-8?B?dWlwRDlEZXRjY0pxRmhFRFBOa05WaG9kL0dwUktWL3dqOE53WlZpZm1tOTY1?=
 =?utf-8?B?cUplQjhUTDZaNEdvZGVOazlmRW45NTFOeCtaek1aMEQvZVJsT2FuRTJQbVc0?=
 =?utf-8?B?VzdaeEQ3TXJESWhtZE5Rd3hZc0RQc1RFaTFoemFnbjZTRnR2RmlvRld0VU41?=
 =?utf-8?B?UzdUVStXNGdQMnVmSVNvTkQ5SEVCbFVNWkRwaXpyR0l5dCtUY1AxaktKRnRa?=
 =?utf-8?B?QzdNblFKTVVXdmplM1pTcmxvRTRNMHh1RVQyc0xYNmJ1Q29RSVJzQklPR1V4?=
 =?utf-8?B?V1dOajd4Zmh2YTA2N1k5VDBtVVlUckIxWkhLSWNPcWJqbUUxM04rcDJrN1Rr?=
 =?utf-8?B?UWgwaDVKYVFzTnlUSHdQSzJWTzlzY2Mzek1qMTQ3ZnZ5bEFLaTVVMTg3MnBC?=
 =?utf-8?B?RC96SFFMZHkzclNMS3YwTnh0Qm84SHd4MkkwbmwyN29hTWlma24wbncvRzZ1?=
 =?utf-8?B?VzZFbHdPTWZCRjkyTlNUVXpmbmJQWlBrYnFxMktMYVJoQUEvOTdwNHg3eWVF?=
 =?utf-8?B?ODN6Znp4RnZZdGZnTWR0d2FpOVFMWWRZYUxLOWIrSU1pVFNONmd3Uk5QYkZI?=
 =?utf-8?B?akhhMGRvS0NZdEZUY2ZHQ2VQVzY0YnJkajgvUUtCVmVtZTZZblZCS0w0MHp4?=
 =?utf-8?B?Y043YlNmc3p6VTUwbTdhV2tyU3UzeFUwKzFHb0NMNjhLWHVxUjcrNDg1aE95?=
 =?utf-8?B?SnpVOWZrYWFrSXFhL25xR0M2cCsvWTkvOHoxRFBiM3AvY0RIVVFyWVhkZzNj?=
 =?utf-8?B?ZVZaUjI4Q0puVXhWN1UrRG5qbjlsanpBaC9rNFM5QmN2RWNROG93bEJIQkx2?=
 =?utf-8?B?RWVYMUxPcGhXK1UzejJsL2V5WUg4MXBNZEIxMzErNkxIQk9weEhDTyswRnFw?=
 =?utf-8?B?N3RVQ3ZnUkE3YTN2L0hRcDJsaXloTmFjWVo2K2p5TnEvZ2pVWjVXakxFQ0FT?=
 =?utf-8?B?ZGlPTzYvN3pLTWNFalFoSGtkRE1XODFrSXlIejVxaTIxSzY3YklyZEJuVUY2?=
 =?utf-8?B?dEF3TlNyMmVoK1NuY01ydGxXRVN1eTYvSXBUZk45K3lnYkxuWjJjTTUrL05J?=
 =?utf-8?B?cTlPb3UxZTJydXBVM2lkSU9nd1BkQXdBSktIOEJNc3FiY0JER1VWWGpkVTkr?=
 =?utf-8?B?Y3lJbkNoNURDSUNhbFBlbE10K0NRKy8yb3VzbjQvSTRWY0EvNW1rZzZsTHBh?=
 =?utf-8?B?WFdFck5oRHZVSk1kUG4zaGFsRCsvU3BMZys0QURvb3ZBN0Q4UnpwSXFCaHo2?=
 =?utf-8?B?QURlVm4rS0lWNWlXT0pZYWMrR0VjZ0dWbWI3V1BlSU9mZS9ndm5tWUg4UGZv?=
 =?utf-8?B?Z0J5YjhPNi9iRkp6OTRoZTYwemppdWhYSzhkR3hGRmpNWEJyZHVNRUFUVlhk?=
 =?utf-8?B?SWtnY1FYM3djVms4ejltVG1ZTHVCZXRINEgrVmV2alo0R1pjYzhHTzNJOEZ0?=
 =?utf-8?B?UXZsU1pmOVFxem9VU3BTTUF1Vm1yQk5rSkNnZ3JZd3pRM2REcTZrVnNNSXV5?=
 =?utf-8?B?Nk5BUGtDd1hLcktsS1Z6bEtBR3FMNStpTmNqSGwyUk8xNFRxVTJ2aklwdjRV?=
 =?utf-8?B?K0IyVUtTYm9UM1RmOTVlMXhET2U4Y0Z5a24wQklnK21CN01WbDFIRzV6UUFp?=
 =?utf-8?B?b2NZVG1QL2pRanVGSlNKbUpFcjdCZWhHYzB2d3E2OHNldHk3NXhmY3lxMjhZ?=
 =?utf-8?B?c1ZNaWFzL2xxWW16RTJFNVV3Z0hmUXJ2TTZ0TCtDUUo0YTJoS2hTMVFMa2FM?=
 =?utf-8?Q?PXBhu9SrvAdI6zD1i1643y3WtmF/hmVn0G9ng=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a23d689e-38be-4372-2d0e-08de91a8e37f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 17:46:09.0039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR02MB10866
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9966-lists,linux-hyperv=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[weissschuh.net,outlook.com];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.958];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email,sashiko.dev:url,weissschuh.net:email,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 6B70F397222
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogVGhvbWFzIFdlacOfc2NodWggPGxpbnV4QHdlaXNzc2NodWgubmV0PiBTZW50OiBGcmlk
YXksIEFwcmlsIDMsIDIwMjYgOToxNiBBTQ0KPiANCj4gT24gMjAyNi0wNC0wMyAxNTo1Njo1NCsw
MDAwLCBNaWNoYWVsIEtlbGxleSB3cm90ZToNCj4gPiBGcm9tOiBUaG9tYXMgV2Vpw59zY2h1aCA8
bGludXhAd2Vpc3NzY2h1aC5uZXQ+IFNlbnQ6IEZyaWRheSwgQXByaWwgMywgMjAyNiAxOjI5IEFN
DQo+ID4gPg0KPiA+ID4gVGhlc2UgYXR0cmlidXRlcyBhcmUgbmV2ZXIgbW9kaWZpZWQsIG1hcmsg
dGhlbSBhcyBjb25zdC4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgV2Vpw59z
Y2h1aCA8bGludXhAd2Vpc3NzY2h1aC5uZXQ+DQo+ID4gPiBUZXN0ZWQtYnk6IE1pY2hhZWwgS2Vs
bGV5IDxtaGtsaW51eEBvdXRsb29rLmNvbT4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBNaWNoYWVs
IEtlbGxleSA8bWhrbGludXhAb3V0bG9vay5jb20+DQo+IA0KPiBUaGFua3MuDQo+IA0KPiA+IEJ1
dCB0YWtlIGEgbG9vayBhdCB0aGlzIGFuYWx5c2lzIGZyb20gU2FzaGlrbyBBSToNCj4gPiBodHRw
czovL3Nhc2hpa28uZGV2LyMvcGF0Y2hzZXQvMjAyNjA0MDMtc3lzZnMtY29uc3QtaHYtdjItMC04
OTMyYWI4ZDQxZGIlNDB3ZWlzc3NjaHVoLm5ldA0KPiA+DQo+ID4gVGhpcyBzZWVtcyB0byBiZSBh
IHZhbGlkIGNvbmNlcm4gd2l0aCB5b3VyIGVhcmxpZXIgY29tbWl0IDdkZDlmZGI0OTM5YjkNCj4g
PiAic3lzZnM6IGF0dHJpYnV0ZV9ncm91cDogZW5hYmxlIGNvbnN0IHZhcmlhbnRzIG9mIGlzX3Zp
c2libGUoKSIuDQo+IA0KPiBJbmRlZWQsIEkgbWlzc2VkIHRoaXMgdXNlciBvZiAtPmlzX3Zpc2li
bGUuDQo+IEknbGwgc2VuZCBhIGZpeCBmb3IgdGhhdCwgYnV0IGl0IHNob3VsZG4ndCBhZmZlY3Qg
dGhpcyBzZXJpZXMuDQo+IA0KDQpBZ3JlZWQuDQo=

