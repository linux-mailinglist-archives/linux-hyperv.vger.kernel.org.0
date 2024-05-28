Return-Path: <linux-hyperv+bounces-2245-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C738D192B
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 13:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764491C21DD0
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 11:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4A516C451;
	Tue, 28 May 2024 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yt5MqegL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA35843AA4;
	Tue, 28 May 2024 11:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716894757; cv=fail; b=U/eNSR1zLt6Xi6KE682vsPitxhMR/JTyjO/189o0u1xd8VfA73zjbw9GZf2KfukLgdgAK7ng/rEJfcHj/B9o6xuAcjHh9czxl2yEUwYDlM8ri1L2O/69PaOAlON4Bx+w4KhEnd3d3QRxDPUGI6RYL4K42kyv3bw4ChATZ3EiPe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716894757; c=relaxed/simple;
	bh=knkkC2uX3zp6PJzLSeotWlsZPnw4KywbqHeSe7eDdKY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ExXmnsnCA6ZypEwyKm3BagJATfJMVrXsECGUonI2DTqp3EFC9M3SaKYbae+crdfI9vdTg2XJw/LGSfadQZZ+NBdecnNcmOewEt+/LYbKjQ+z1RLELSwRZQSDAyveCB7/1r04z1TqAch4k9VbFVDSr2DluTyXrQUcGKQr7TGGpIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yt5MqegL; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716894755; x=1748430755;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=knkkC2uX3zp6PJzLSeotWlsZPnw4KywbqHeSe7eDdKY=;
  b=Yt5MqegL8bnNNgn81K7droNuU5Xs+2cyvVTr+XLq4cV25jrL5/H2HVOa
   Ec9GACImR+lim8dMOR/FcuXLztLd9Pxqz10rsqyly0ZKYTYXslffExvhU
   SKLEUF+v5Xx3u4Rk9LE6O6GmPYckoEwHz/d4FJ2OzyhGzb3hmVq0ZnRWO
   jTM1UZpi1f5voePlUPAH/DTlu00sG2XQeB9RJVNbSdi3Ftbyg5t/ZAEcz
   L2hlG8LiTPyss/5q+WJ/eAEOQxf4Maks+sCnM7ahLno0VYYJZcy7cqCaN
   lMjiNDuvBXJ5PZz1AcJh+r59NG1SqgYx86o5xEd+vTU+n6Fe32+GEQ+00
   Q==;
X-CSE-ConnectionGUID: Bd8h+1m5T8GDsRCaDvlcIQ==
X-CSE-MsgGUID: 5V9mcZ3+TiG1gnsSH+25JQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13079539"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13079539"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 04:12:35 -0700
X-CSE-ConnectionGUID: NZuO/9MfRWKhRtHIqLsnzA==
X-CSE-MsgGUID: g0gIDN6uTuGyT1rEUGBuTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35653114"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 04:12:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 04:12:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 04:12:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 04:12:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUxEB+DoBxODEHFLpuFhCwiiCRcMHKX1FLNNybQPvrEtCXUyri3IA6vbIIfhViezmGFvLcnXNsvNuHecEeNJzJ4+qHdQ1+LKAKYi/tmd9ZADj09LUy7Aw5SjsUDb8fc/DvkTMMgRxYtB0y6zdL6R1VqfkcUnjifCkOh1gYeKs0Pw/pTzEwxbsg+FIdT72yFzVf5phIh+d+1aSQGoROL7GPRq1sG2TcLE/flKcMDrbdJtOr8rph40J4vAE4nGKNY1GP/zpH8J/tCCkHL9epYTZBLztIwWdUcNL39X/ZJQ2JAV1Z3gv5629MZ/tPFIbcWHCNERij0VcpQpoCH4gzlXSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knkkC2uX3zp6PJzLSeotWlsZPnw4KywbqHeSe7eDdKY=;
 b=k0LwRwsDvE999aI60fejmdc3YRB77goVSQx+6MCb2o2uw4+mWSyKEDGGCQbrwibOojvhqMffF3tKsNeiALAJqmuHiYtgkwoHBfPYhtWHkyWNaR3VV75RRJXQ3FhU1WrDBx+nHrRLmpHgw2esXPlsYzov3OSvw6IY78hzm2VlDhJW2faVyY5wPzL64mIs3CSiIk/Sui0MAWMRxdJ9aNxKQFfLACG4JhpKvItvR0a7IHGKgaRhJquCXDf0d92zKvEbHCQ+j+/O9eFviE9//QL+4jKbPLujf7oWbZbca2rZElrSQaxCbx47T0aeZvX3+Z4RUax466pg8LtsB6xoZQevpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MN0PR11MB6111.namprd11.prod.outlook.com (2603:10b6:208:3cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 11:12:26 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 11:12:26 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "ardb@kernel.org"
	<ardb@kernel.org>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "seanjc@google.com"
	<seanjc@google.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"bhe@redhat.com" <bhe@redhat.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCHv11 06/19] x86/kexec: Keep CR4.MCE set during kexec for TDX
 guest
Thread-Topic: [PATCHv11 06/19] x86/kexec: Keep CR4.MCE set during kexec for
 TDX guest
Thread-Index: AQHasOU84tfcfZdkmEyRmpURY8DGibGsfgmA
Date: Tue, 28 May 2024 11:12:26 +0000
Message-ID: <8bb73d1a7b79d8c7bb8dd6673cf864c265ec6899.camel@intel.com>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
	 <20240528095522.509667-7-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240528095522.509667-7-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MN0PR11MB6111:EE_
x-ms-office365-filtering-correlation-id: 9bec7725-82fa-47c3-61f4-08dc7f070e97
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?R3RNL3h2UWJleXlWb1lvNVVqakRXQUdKOG81NUhBR09adzNFWWloZlkwZzJt?=
 =?utf-8?B?Y2dQOWVrdUxhS0UyV3R5R3p5OElBVHg5WE9Pc0NTWDUxZW9ndmNtcnlXWXJV?=
 =?utf-8?B?Q1R3RTFnUDAyNEhURDFmVHI5Uk5JY2ROUHF6RlcyZzV3K2tqSTByQ3hJVzV2?=
 =?utf-8?B?M2dzdm9XV1ZvVmN5cFhhQUpEcHpVK1Q4Y1FzVG1DSWl0RThXQ0xUTFJlTmtX?=
 =?utf-8?B?Vm5UZE1FaWhNcVVidzNISXFsTUNMYWRpbTBkbWVDY2lHbWFBSCtXalNwcERa?=
 =?utf-8?B?ckg0N05wekxDN1FCd01wRmNId2ovY0ZWWDdtSXY0Y2QzUTR6N2w3cFl5WmNM?=
 =?utf-8?B?Q3hzSytxbGRwZDVqRWpReGxyNXBBSkpVdkVlSVBwNEZrc0s2M01xQkNnTzhV?=
 =?utf-8?B?MDJSc1M3VCtDWWFWWDhObmQzR0cya3duQzRQWFoxRno4RXVNbTVhSVJDdDlS?=
 =?utf-8?B?MEVPOHdzdGoxL21zVndDRytlVnhqVkEySWtUYjF3cEQ2SEJWZVZqVWZ3U3A3?=
 =?utf-8?B?cWlOcGM0YmhNdlZEYXFFR1pyNldldXZDSThFdjhMV3hyMzNqSnowTHFsWkdI?=
 =?utf-8?B?MmVSdHFGRDBVeW1pTzFlTW4rZHBFY2hGZXd3RlNlQjBNNHZmcFBJQkd5WUFa?=
 =?utf-8?B?MUZqakxnclkxMWFEZy96RXVLdTBlSWUxelpLY3ZyQlkvKzMwZVN3TWoxeTh6?=
 =?utf-8?B?Y2RMdDJZNHIxOTh4aW1ESi8zZWNNYTMvL0dpSlVtSkdqcWRySUJITlBTQXM4?=
 =?utf-8?B?Q0RwY3BPb21Wb3VhWDdLQ3ptc3J3cEdMN1E4OFQvV2NudTNBT0N4b2dJMVJq?=
 =?utf-8?B?a0g4Vmp0VnYzNGlZQU9SVWI2cDZ1N1lLMitpckJxQnF6aTAxUW1XNU5BS3Bp?=
 =?utf-8?B?Ly9IT2pQWFF4cGhqbkdTNUpRVit5UW1xb2p4eVNkazlJU05ydktkbWtlVUxS?=
 =?utf-8?B?QUdzNlQ1RVhXdUtUclRyZ1Z2bFJRbnNJbmtCcGcvS3ZiTFFUc3F0a3FvUDBE?=
 =?utf-8?B?ckt3elZHbmdUMEZBOUFMSlN0N1NxbWRKRFdPclRqektWckhtL0FHVWVsdzZ1?=
 =?utf-8?B?SGVrZnFEQWdnbXM3cHNzYWlnWGpwOEJTczhzdWYwMjBSaVdlZ2ZIWjF1Q1pM?=
 =?utf-8?B?MzdGWFMyK0FxY1JadEpaUVcrby9PS0NTeW5qSWNCMzNDR0FleXBYWkRXUTRF?=
 =?utf-8?B?Wm9jRDB3MTJTWHZ3cVVYRXZhUWRzMnVRYTdBV3J6aldyUEVvNWptdUVSSzJP?=
 =?utf-8?B?MXdOdGx1OXZuOXp3WnVWZE1IcW93WGNyb0wrSVVaUkExdTY0eVdFM1E5WHZE?=
 =?utf-8?B?NnFBMkc5R2YwTTUzOS9hMGNFaHZOZ2dvZnJaYkxGMFpNVGJpSGdaNXEzL1Q4?=
 =?utf-8?B?M0RkbEVVUDV0VnViTkxIZUpJc1dCYUp4elpTVnFtUzg1YTNkc1k1b2lMQy9C?=
 =?utf-8?B?OWJlMkZmWmpFeXVma1JGc1NwVU5PYXlNNHBtOWo2eWYrMGpoUC9BY1JGMGlM?=
 =?utf-8?B?SUgyZWQwNzhveUJKMVViTkwzZVpGRzRnMEV0WTdQREhXOEQ5dUVVWVNYTHJG?=
 =?utf-8?B?ZnpBOVUvZHpqd3NjK3pSdzNoT1BVQ2pscjRqQlZtbWNNVW5ZZ0V1dmJFMkNF?=
 =?utf-8?B?Ujdic0loSDVyRlNWSVhzdkVNRlFZOTUwV0dXSjhhMnRwakRmSWhmZEdDNktN?=
 =?utf-8?B?dnVKK1dBSm52ZE1kVWFDRWNXa0c1NHhxQ2tOZlhnU0ZZcklxMFRveVJVR0Fp?=
 =?utf-8?B?MldlbUw1aWFWVWdzSzZlc2VMb01lTjhvRmhObTBQU3lRckxsTFNUYXdlMlRD?=
 =?utf-8?B?L0RCcVZHQ3NrVEVON3VZZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2lEMHNBYnhqUk5WNS9jOUQ0eVhZRlhjd0N4dlNBWTJmd2Q4UHVTMXkwSWZD?=
 =?utf-8?B?V01FWVNBRkF2TmJZTVlpZnNBUTZZT1I4dzNNQlJKczRhRGh1MStHUkp4MXhs?=
 =?utf-8?B?ZWhBcjdGcWlMRmErRDhmZGVFTjdjOHdWclBObnN2b3d1SFVEOGxFOXJwaVk4?=
 =?utf-8?B?ZXdRTUZsSEw2M1BuM2lFSWRzSy9pdVk3NDV1Y1E5MlJ4aTVNOG1RZzBYckdE?=
 =?utf-8?B?Q3VQZVlKRWUxS2pNM3ErQTl2STRYUW1BNit5L2RYMG9OQ1BUZHp6b1lvTlNK?=
 =?utf-8?B?OGgzbTg3YkduUzQvRkIrMzFMNnRMa3EwZXFyRzdTRFRJZm5pUWNOZmQwTW1i?=
 =?utf-8?B?ZExPY1hWUExWZ3hXL1lXV0dzUzVoM01BVGxpT3pXaEZFNW5xbUc3S3hoSHpS?=
 =?utf-8?B?a2lzeFF2NGpaYUU3SllWR2FtbkZDVFVwTDNjYkhyVnIxYUZkQTFBV0ZFSmZt?=
 =?utf-8?B?dXdPem42V21RenAwSXVmMFJ0cm80bVgrMjI5T3M0OEFUM0J3TXJOY3Q5MDJl?=
 =?utf-8?B?WFJrc0taYWthQmFZcUNscVM5dElIUUszbVlPQUMwMm0yajE3VDVZaVIxbS9l?=
 =?utf-8?B?L09wdnl0MlB4bWtKV3N1eHNrL0NNY0l0M2FpQVNCb25QZTNkN3JwK1FQcVlv?=
 =?utf-8?B?bG1MNVp2WUtocUlwWjdubEkwaVRTNEJYZmdYNk1zVmlMRE9QYU1NVm0zYUFq?=
 =?utf-8?B?MktkK2t0Q2haa2ZoWXNKenZoMDFEZE1uK1NRclhSQzJVUjg0Wklxd2llSnN2?=
 =?utf-8?B?WGlNbjRkMEYxdHk0RXpRdHB1L240WkkwUFh1am9UVjZvTDlPQ2gyelhZbmd6?=
 =?utf-8?B?RHVnRjJTZFpyeFZVSjllUkhJN0VUL1VLNnpwQ1hZU0t4WjV0aWlkMGI1WGxD?=
 =?utf-8?B?elI0UTJFWTM4dXo0WEZyRHVkQVkvNVlTRVIrNTFsZW5qVytBditleC9wbnZX?=
 =?utf-8?B?bHhqeGhsSE5PclBHbkNzSmhCcFZrZU9ibUZwbE1naURMQlFQRXhrUVNxZm5k?=
 =?utf-8?B?Sm5KSkZBQk1KZEl1dmhBUEk0a25JYmxwck02U2JVb2JIYmhGYVFjREo5TTZy?=
 =?utf-8?B?TEZ0SU5FWVRyUUEvZVF6R2NNUENWWU9QcGZhYzduUE9SMzNTN0FxUkFwaFRC?=
 =?utf-8?B?dEhNckh2SncvbUIyckRSS2JldCsvVDE2SnBweCtLRjhYOUwySkV3ZUdpM2x1?=
 =?utf-8?B?VDRiQmlvWThMRmpOWnNaeGpNRzNlQjNVNnNrYTNCZXppNGNLc2dzblVrQmFH?=
 =?utf-8?B?WThkcXdZSmhmK3hsZW0xcnFqZVZ4SUlSVWVwMFQwcWZjN0RkV0ovNkFaTVZL?=
 =?utf-8?B?Vlhpenl4SXY2Yis0NkpxN2dCN1k5N0c5ajFhZm9CbDVrQ2J3akNKajl0VlhJ?=
 =?utf-8?B?RXJVWDdJYXRoS1JiNUNRSEFiSk1leW9wQ3lQd2czNWtDUEdVSXRybXhqa1hk?=
 =?utf-8?B?KzlvNGkzRi91SDVSaGhSbWxEOWpzSzFreTBUa0ZwSy84bm84OVVKS0xmQUYx?=
 =?utf-8?B?TWRJQmlzbENnVCtEUW9mMWUrTUpHb09ZQVZYamRqSjN1VU1MdGxhMTRYRDVW?=
 =?utf-8?B?c3oxNHRZbTFlRGM5SlVLWjE2WkUrU2h2SWJlRGxsajcxV3plcGpQaVY3b0RK?=
 =?utf-8?B?TDFINUMrcUt4QU0xR0xCYmxXelVnVlVrWDZiNVY0VFZvZWp6T0NqYThqeUkx?=
 =?utf-8?B?S2NkaWQvK0grZHo2KzYyK2hSa0dlZEFSbDE4THpHcTNiQjN6YXVhQUtCdU41?=
 =?utf-8?B?aGErOWVHSW4waVNBdnJnM0VKZnhnS2d1Z1VHMDM5MkJjY0doU1hMNHp5RU80?=
 =?utf-8?B?cW1lbDJ0TTBXRWZLbGx1VmlOTGxBYUtHcjNlUGpDRm1kbUtVd1g0ZHkwR2tT?=
 =?utf-8?B?a1hmMCt5ejZ4YkpVa1NCS3pvUVovRklpbEhEWi9RN3pwTXZsYkxkeXBiU0kr?=
 =?utf-8?B?OEo5SVVTZlk0dmVkQ2owZENTTnlrQTh2a1pMOTRYU0pqRSs2QUJ6anBEd01F?=
 =?utf-8?B?QzFlbzRtU1AyM0ZtMThxMERzbmdjb3lkMktiM2I4Z0EwM0sxM2luaUVZU1Fw?=
 =?utf-8?B?RlpZaUR3QWc2REd2bWtWTFJqVmRYQXI4bVBmRDN5b0sxSll0YU9KakRBd3F2?=
 =?utf-8?Q?vOT1xDXOni4GITW3EudRsPxlJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D35AAAF440CB84AAA7EBA4CB1209C44@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bec7725-82fa-47c3-61f4-08dc7f070e97
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 11:12:26.5765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HldMyMkhC3ITkB72My0R+oobw9A7eP3X6ReE5E8gzPcWRHsAP36I4w2XlTonI3GggfuUxyFTobBXyOan3x8dEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6111
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA1LTI4IGF0IDEyOjU1ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IFREWCBndWVzdHMgcnVuIHdpdGggTUNBIGVuYWJsZWQgKENSNC5NQ0U9MWIpIGZyb20g
dGhlIHZlcnkgc3RhcnQuIElmDQo+IHRoYXQgYml0IGlzIGNsZWFyZWQgZHVyaW5nIENSNCByZWdp
c3RlciByZXByb2dyYW1taW5nIGR1cmluZyBib290IG9yDQo+IGtleGVjIGZsb3dzLCBhICNWRSBl
eGNlcHRpb24gd2lsbCBiZSByYWlzZWQgd2hpY2ggdGhlIGd1ZXN0IGtlcm5lbA0KPiBjYW5ub3Qg
aGFuZGxlIGl0Lg0KDQpOaXQ6IHRoZSBlbmRpbmcgIml0IiBpc24ndCBuZWVkZWQuDQoNCj4gDQo+
IFRoZXJlZm9yZSwgbWFrZSBzdXJlIHRoZSBDUjQuTUNFIHNldHRpbmcgaXMgcHJlc2VydmVkIG92
ZXIga2V4ZWMgdG9vIGFuZA0KPiBhdm9pZCByYWlzaW5nIGFueSAjVkVzLg0KPiANCj4gVGhlIGNo
YW5nZSBkb2Vzbid0IGFmZmVjdCBub24tVERYLWd1ZXN0IGVudmlyb25tZW50cy4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxpbnV4Lmlu
dGVsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEthaSBIdWFuZyA8a2FpLmh1YW5nQGludGVsLmNvbT4N
Cg0KPiAtLS0NCj4gIGFyY2gveDg2L2tlcm5lbC9yZWxvY2F0ZV9rZXJuZWxfNjQuUyB8IDE2ICsr
KysrKysrKystLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA2IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9yZWxvY2F0ZV9r
ZXJuZWxfNjQuUyBiL2FyY2gveDg2L2tlcm5lbC9yZWxvY2F0ZV9rZXJuZWxfNjQuUw0KPiBpbmRl
eCAwODVlZWY1YzM5MDQuLmI2NjhhNmJlNGY2ZiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2Vy
bmVsL3JlbG9jYXRlX2tlcm5lbF82NC5TDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9yZWxvY2F0
ZV9rZXJuZWxfNjQuUw0KPiBAQCAtNSw2ICs1LDggQEANCj4gICAqLw0KPiAgDQo+ICAjaW5jbHVk
ZSA8bGludXgvbGlua2FnZS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3N0cmluZ2lmeS5oPg0KPiAr
I2luY2x1ZGUgPGFzbS9hbHRlcm5hdGl2ZS5oPg0KPiAgI2luY2x1ZGUgPGFzbS9wYWdlX3R5cGVz
Lmg+DQo+ICAjaW5jbHVkZSA8YXNtL2tleGVjLmg+DQo+ICAjaW5jbHVkZSA8YXNtL3Byb2Nlc3Nv
ci1mbGFncy5oPg0KPiBAQCAtMTQzLDE1ICsxNDUsMTcgQEAgU1lNX0NPREVfU1RBUlRfTE9DQUxf
Tk9BTElHTihpZGVudGl0eV9tYXBwZWQpDQo+ICANCj4gIAkvKg0KPiAgCSAqIFNldCBjcjQgdG8g
YSBrbm93biBzdGF0ZToNCj4gLQkgKiAgLSBwaHlzaWNhbCBhZGRyZXNzIGV4dGVuc2lvbiBlbmFi
bGVkDQo+ICAJICogIC0gNS1sZXZlbCBwYWdpbmcsIGlmIGl0IHdhcyBlbmFibGVkIGJlZm9yZQ0K
PiArCSAqICAtIE1hY2hpbmUgY2hlY2sgZXhjZXB0aW9uIG9uIFREWCBndWVzdCwgaWYgaXQgd2Fz
IGVuYWJsZWQgYmVmb3JlLg0KPiArCSAqICAgIENsZWFyaW5nIE1DRSBtaWdodCBub3QgYmUgYWxs
b3dlZCBpbiBURFggZ3Vlc3RzLCBkZXBlbmRpbmcgb24gc2V0dXAuDQo+ICsJICogIC0gcGh5c2lj
YWwgYWRkcmVzcyBleHRlbnNpb24gZW5hYmxlZA0KPiAgCSAqLw0KPiAtCW1vdmwJJFg4Nl9DUjRf
UEFFLCAlZWF4DQo+IC0JdGVzdHEJJFg4Nl9DUjRfTEE1NywgJXIxMw0KPiAtCWp6CS5Mbm9fbGE1
Nw0KPiAtCW9ybAkkWDg2X0NSNF9MQTU3LCAlZWF4DQo+IC0uTG5vX2xhNTc6DQo+ICsJbW92bAkk
WDg2X0NSNF9MQTU3LCAlZWF4DQo+ICsJQUxURVJOQVRJVkUgIiIsIF9fc3RyaW5naWZ5KG9ybCAk
WDg2X0NSNF9NQ0UsICVlYXgpLCBYODZfRkVBVFVSRV9URFhfR1VFU1QNCj4gIA0KPiArCS8qIFIx
MyBjb250YWlucyB0aGUgb3JpZ2luYWwgQ1I0IHZhbHVlLCByZWFkIGluIHJlbG9jYXRlX2tlcm5l
bCgpICovDQo+ICsJYW5kbAklcjEzZCwgJWVheA0KPiArCW9ybAkkWDg2X0NSNF9QQUUsICVlYXgN
Cj4gIAltb3ZxCSVyYXgsICVjcjQNCj4gIA0KPiAgCWptcCAxZg0KDQo=

