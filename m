Return-Path: <linux-hyperv+bounces-7421-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD3EC3A3A5
	for <lists+linux-hyperv@lfdr.de>; Thu, 06 Nov 2025 11:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CCF7188E5E6
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Nov 2025 10:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E13258ED5;
	Thu,  6 Nov 2025 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iR2limCr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F257D2309B9;
	Thu,  6 Nov 2025 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424335; cv=fail; b=bfWk90qcKTCYFvF89o9tQEkSxu/f/NMUFuRRoCrbnoYxAQ6K1+8ztvaKQ2NvUhkkfXinOhcIqdXkD7vyFM1r1m7aV4bHe5dGFfI1JlDpqHy8TxgJxQPs5vzsEDcWcqDaaESIAuXpis0nLs1XJ+U9i7Y5xjG983F6edw0Anl6HsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424335; c=relaxed/simple;
	bh=dNA5GK1LvCQmlw0CpeYWGZTYeBGJxteBIRQFiLoMtng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tiofAmmEyRc7ihiYtaS/WxMBuhvmw4mGr2vgJ1g8JCycr/3puZFXaSP1giEoT98PzmEeTyMPqk/zSlg7dWA4NrQLq4C+aMkbR16PZMaKkTmynj8aavrzhMYi1DWCiIXMH5Ica1pWZML1r1DJv/UKyU7+h4ynX2NMDVx0Jnx5q3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iR2limCr; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762424333; x=1793960333;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dNA5GK1LvCQmlw0CpeYWGZTYeBGJxteBIRQFiLoMtng=;
  b=iR2limCrkQqlHbbpIaGupskMNx4FBSEsURyoHbkNxmjIrtG/yujazHDa
   qT1irKmM6N6HwwZjGXC2QtQTGpHE0zRF/QhUDlu8v7TNnRf4jI7pSFymh
   4i4llFAs3JokkK/L641ThD4Ch41DxqRxOiY6TmtJM1sf4mhMXVovVBf10
   PN/j91U/tnKicXBb+ZfnrstZugDf9zYzCwfvVnxZ6QsVSLi3MAZkgnaLS
   9mHaABqB8F3W3SnTvYAUvIrYR/c0a8MMp3GtYzSXdnqYn+DRoMukXMn01
   zEP7ajBUHQzAnHQDWvnq8SWxKlEGpZ0qhm7+n/88zq6qPElegNuTfXt24
   A==;
X-CSE-ConnectionGUID: 9QI0apr9Shm0PyOzUjrsyw==
X-CSE-MsgGUID: FL9jG9r8Qj6sM/dBJqz73g==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64438955"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64438955"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 02:18:53 -0800
X-CSE-ConnectionGUID: xK4nw8syRYSK5JhT9nfqYg==
X-CSE-MsgGUID: zqUP0EpJS0S1QTdh0dNeYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187386104"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 02:18:53 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 02:18:52 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 02:18:52 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.3) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 02:18:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUcF9WVN1LdHlPXzrZH0FooUpsrVhr5vFpGnfeBkY3qckCjacsJT53ujMHlWrdCKLnkrJVjCW5UgtSzKVpXd/agDK1UxVmTb491JH/LjLTPkuR/6cNOkmJC4tP1FTvWOHzTBE0W7siYtxsVzsDQuJzSCmoEkRuxiMXGqRxI4P+OgKEWSesS1r2cFREFsgvKDy5N7y7SlMlmIohkwJihSt6o3LsmJPlxYpcBb0VZThFbSQxMHCtPPMEfWhYApbguVXuj9Bbcj/FNuKdE6TNAtvUJHFlBvE1YAaZRNmZSkIrwIFakt/4OQTJL+BFUUfF9KAuVZy0Gsufv1Vrbk2rPaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNA5GK1LvCQmlw0CpeYWGZTYeBGJxteBIRQFiLoMtng=;
 b=aEwb4HGcm4JW+3yhxYa01xkm2AnHVfjt6yq+wdj+N6aWq+h2jfcExzGsKwVILAgp7YkZhZIRGC91DwPEfAx1+sqmgNvBUyjB2qpFXJHWjwPIQpkZasiuhrxlwVIQX9A3NTciMTGWOpDj8ufjmr7NWeZKuJ+jfaRdnHz1Htswe89YKOhHUO9bRrOs+qBX+dj4/8K5QB1FcufccKc/AuPubqYW2YomGVFhSkzGXwsPgXa18mMnGuvhGHBhtfuDRd7OyFy6SkPxMmJ1U/JMvv6IbQpX2DNPpOcLzrF8QijPh2ErECpPKQJyzb44PpAqtBj4Ffw6aX/YFbQ3Bbvun2Kf3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::31) by SJ0PR11MB6815.namprd11.prod.outlook.com
 (2603:10b6:a03:484::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 10:18:49 +0000
Received: from DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::67f8:8630:9f17:7876]) by DS4PPF7551E6552.namprd11.prod.outlook.com
 ([fe80::67f8:8630:9f17:7876%6]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 10:18:49 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Ally Heev <allyheev@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "Wei
 Liu" <wei.liu@kernel.org>, "Cui, Dexuan" <decui@microsoft.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>
Subject: RE: [Intel-wired-lan] [PATCH v2] net: ethernet: fix uninitialized
 pointers with free attr
Thread-Topic: [Intel-wired-lan] [PATCH v2] net: ethernet: fix uninitialized
 pointers with free attr
Thread-Index: AQHcTwVowUj78sgoa0WKEd5/mLbPcbTlbd8w
Date: Thu, 6 Nov 2025 10:18:49 +0000
Message-ID: <DS4PPF7551E6552E6053CC02144D0987191E5C2A@DS4PPF7551E6552.namprd11.prod.outlook.com>
References: <20251106-aheev-uninitialized-free-attr-net-ethernet-v2-1-048da0c5d6b6@gmail.com>
In-Reply-To: <20251106-aheev-uninitialized-free-attr-net-ethernet-v2-1-048da0c5d6b6@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF7551E6552:EE_|SJ0PR11MB6815:EE_
x-ms-office365-filtering-correlation-id: 2efc4278-e939-4dba-bdd0-08de1d1de0ab
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?RCs3RCtLT1dLcXBJZTM5S3QvdzVnaTN6MUpvSHU0Q05jREQ2MmkzSmpPR3kw?=
 =?utf-8?B?SFJONGtKdG85L1NNTU5wVlNUb3VqeExNWEFFU3VVR1A3UTZhQmZzYWQvS1Z3?=
 =?utf-8?B?TmJxcHFSZTBodnNHU1pOR2o0QUZIM1JVS0NnRWpYWGRGaXVqdGlQSG50Y0ZF?=
 =?utf-8?B?LzFOME1kZWxMcTRVR0xlLzhtSDlNaWlRSGF0OTY4QXd3b1MzWVUzY0lYdEpw?=
 =?utf-8?B?MDBkWFNzWjNtOUFqaEphSlBwL01wTTY3dzQzNGlPT2ZjUkcwOGZ3cjFrY05x?=
 =?utf-8?B?TjNGaG1yeHJkM1FJT1EvNmg4TWNHdlNBZ1hSUHZMVS9ud1FwSEtNQWVCTk9a?=
 =?utf-8?B?dUdBRGhTcWJ2MFMvM0lIMjYvanRpWE9TRWlacEttcVJqemUxT1ZUdWFlNmhH?=
 =?utf-8?B?dG5CMlhEaExVRHFxQWhKTXNOOXBtMGxiTmxkcTdHTVVIRlY5RFJtMlhZcEd4?=
 =?utf-8?B?cGhBZG83RG5wYWVOMFVPWTRydGJYMEYyUHFaRmhxUEt4Q3pvRmVaRTNmYnBt?=
 =?utf-8?B?bm5neFF1eXZjWFJOY3YxREZMRG9uZDBwQlI5REZNQ2ZGbTBLcmtwVEdKMGUv?=
 =?utf-8?B?bDJsa2JSaVpWdGNpbWdtMFJYcnUxNGIwSGhZSUIwbHI1OENHdmVPaUV4ZzhK?=
 =?utf-8?B?WFh4YjFUQUNGb3Vsb3ZBeXJwR0R3eGpoWndrejZicHhPMkdiWUlmVDdyRXhC?=
 =?utf-8?B?SDJNYmsxazZTTEtQQWh5VCs5OU1DQkM2YnNQeGE4VEV1RFA4a0srTFdScXR5?=
 =?utf-8?B?Qk0zTmoxd1NGUVNNRk9WK3RPYkRpRUpLWnVKR1JzT09OOXpZdlNraWw1c0RI?=
 =?utf-8?B?bmlwdUdNRzFhbktWV2hQdVgvYzBuYmhIUFNOUUh5TmF2WXBoc0RaR1pxaDJM?=
 =?utf-8?B?R2Z3WmxUdFJLa0JrVnRKcnU1emZoRE9YWURzMi9uTTdwV0dWdmFQdDh6MDV4?=
 =?utf-8?B?Q0s4Z2tIOVY0QnlrbEJwUXhsbUhHRTFRcnViWTgvNGcyakZyWUxQUEhoT2xv?=
 =?utf-8?B?UmNrUGdLZGhCZmUzNkxWVmlOaWRZa0RtcmZOVDFIQ3diU09zRjZpdlRIVGI1?=
 =?utf-8?B?c0FIQVAwbFJuYm9ieFdqQ284N3o2YVBEcWM5Z3JYR3FVMVFBLzBGZmY1bllL?=
 =?utf-8?B?Wmw5MjR2OWNJOWJmVU1RNnJjVlZKUnlFNGZKSVpnK2psT0YvdEhXVkFMb0Rp?=
 =?utf-8?B?SVpEYUMvbVhvYmlPUUw2bGtqOFhHS3RwSWxKNHYvNjEzUXdiZG9LeWtDdkhT?=
 =?utf-8?B?WFJEbDRTWHhpZ0RmUjhPYzQzWEtuSzM5Nm1ya2RMNEovR3Yvb1JyRmZDU2JL?=
 =?utf-8?B?eFlUOFQwbUxZdUdzM0lBVzRBSjRoNEVCSHcwRDR1cHdxUmhxcDhaWGJXZm1u?=
 =?utf-8?B?NkdGdXl3bUcvbVRSbUJQa1lEVUxJa0ZVcW1vcXc3WnRPSHJrTUVIR01GWU9I?=
 =?utf-8?B?ZEdIRkRGV0MvbXV3a01wNm9RMkU0RFk5d3hWTGgxVTJ4YjVDekVFR3h4eFBy?=
 =?utf-8?B?aElab2N6b1dFeWhndUlwK2tIL0kzV2Z6KzdNTTNBY1lGdUE5TGFWQWtCY0pG?=
 =?utf-8?B?OFZYVXdrck5FRFcwZWJ3VGE5dmhYbnRzSlNpYkpPd3E5ODBFRmN2a3pQTWQ0?=
 =?utf-8?B?L3JWbnlKMmZiejlKM2E3c3hkV2lUbnlVVlZTK2RyU0UzUUxOMXVnODBsSDJ2?=
 =?utf-8?B?dkNOeXdKOVJ5c3ZsOGNHb2lVaFR2WXluZFNWanR1TXZBcVZrZDFBYjFiRllr?=
 =?utf-8?B?OEhGOGtZNUlqSWsyOFpYbEU2bWFTSzk1c09aTDZSY1BWckZqRExvS3N0U0Ju?=
 =?utf-8?B?RExtUGtnZjZCZnV5cE5aL0NtY0RnRXh2OXdXS051dUl6aXlWZXQ4bk5kMWZ4?=
 =?utf-8?B?T1FOUDN4aTZLdjBHaGR5QTFVRkp0dkxteGx5ZW9MT2duNWdIWkVlSzhuanBn?=
 =?utf-8?B?dFl0dHFiUWtoRldYY0RUNi9jMlM1Vy9xSkNCdGpZc1paYkpvdGdPSHl4TEJ3?=
 =?utf-8?B?OXRwbUFBZTY3dEdRSHpOL01HUzBGemc1NmVVanRHYUtpancxVUhIVFByQWNr?=
 =?utf-8?B?R3lnRi9DbmJ3RHpOK0IycUNZa0k2ZE1WTmNiazVnanE2Q2s3c2FqckIzbk1y?=
 =?utf-8?Q?L+WM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF7551E6552.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1VwcmxTNll5aGdmQkM5WEF4UTYyOWFVVjJlK1B6aVEvZlZBQWttZXh2YUlF?=
 =?utf-8?B?U3o3THh6OWhqNmNZUzJ4ei83amVUMjBWOFB6TXVyYUpPakx1N05HUXRMVnl3?=
 =?utf-8?B?LzMzV242OHZtRE9rSW1aMHhhNHdUejc1MSt4U1BXTklldzU0QW1sa2QvK0pv?=
 =?utf-8?B?aUlPZks0VkRhODNmUUNLakR5RVNYU3Y0bW12S2ovcmhkL0J5MnVqV1RjZFQ4?=
 =?utf-8?B?Z09qbzRueTM2SGVWMHg2a2lWYTJQSTk1SENZYkhlL05na3FNMGhha1pGUzg1?=
 =?utf-8?B?WkhxbXRiUHBmVlZDUWdCcTdBVVAwMy9QclhMSmtjNkJhVlZ0UHg0YXFMVHFN?=
 =?utf-8?B?SkRvckR0Tmw1REJJcmg1MEdLNXJQSDEwbnBvMUVrWTBhNmxTMys5MVFMVDlh?=
 =?utf-8?B?NUFDb09EQjVFNG5NZ2JsMEFtc21lYjEwWDdWemY3SU1Eb0NxdTAyREdNU2g3?=
 =?utf-8?B?MVQ2VUY1Y3lZZFRJSXpGWEZvV3NqWGhRNWVJRGlaT0JaU1d2eW91T3lTc3ZW?=
 =?utf-8?B?N2J2VDBhRkF4RFhIMURBU2VKL1lPS1FFRUk1OG56UUpFMG5zZTJSWXNZQzZ6?=
 =?utf-8?B?T1AzNEtGZEowUzlhZU9OK2RiNW1Wbkt5L3FST20vK2tReEMvTkxtMXg3MUF1?=
 =?utf-8?B?aDZTSzUyaGROTFV0aWptTnhNMVJoS3hDNmI2THYvOHZyVWNvVXFKNWh4YkFQ?=
 =?utf-8?B?a2t1WjVqNGw2MW55aW51M3gwdC90WmRodWxZN2NRRURuVm50WVB5WTdBUVRH?=
 =?utf-8?B?Q2s4Mzg1bFVwRWh6WFlLYlZSbGlpenI5Vkh1elpzSWlFSVdHYU85ME4yMFFT?=
 =?utf-8?B?VEJhME5QSVp2dUROTFF5eUJnQ2lDTGVtQ1E4VklaOEg5RjVsWVpRSnpnSDZ1?=
 =?utf-8?B?NFFvN3l5MHVJdWk2bVRkZjRwQVJOWG92bzJzb3pwS0lIMUtCY1hEbmYydGox?=
 =?utf-8?B?VGxBNVNlZnlyVXhUTXIvdG14cE8vMS8wd0dUM0J1RjJUVFE2RTlnV1VhWUR5?=
 =?utf-8?B?amZyODYwVDdFeDRhRTd2bzZxUlBRQWhyaitLLzVPbUROQndsNGh3LzVJRHU0?=
 =?utf-8?B?c0lTZ2o1ZVAxb1FGdURWN1VsM0JPRzlRZElkT0UrVTRUWkpnTUtxVXBOdTBQ?=
 =?utf-8?B?R2V4dytYR3FwZ2k1MWNYK3NWVU1wYUZDMkZuWVYyVWx2eDhyQWdFK0d1UlhG?=
 =?utf-8?B?MktDVzU4N0NabUZnVXBTOEZBMmlucHp2dkVtSm9KVHMwakdyeklnNGZvdm5a?=
 =?utf-8?B?MEJpa20vQkNrNnM1NG1kZmRjTkxqbm5uV29QY0lWMGhPVkxWdklnVVE5NVhX?=
 =?utf-8?B?cUg4aEtoeTV2REpXSWorOC9TbU43R3FXNFh0S1J5MXg0R2gzL1ZZbjFkc3ht?=
 =?utf-8?B?QlRmUnowVjRYWDd3VTU4aDVmeXc0K2tqT1M4WndKNmZHNy9sUzdDN0lJdkoz?=
 =?utf-8?B?aExFbkVWZVZBS3VYZitZUWI3YnN6OTF4eWF1Wm1qUEVqalJkc0R0a0c0U3RZ?=
 =?utf-8?B?Ujl0S3Z5a1Vvd0JNNVJMSFFnQ1dTTXAxTFdsblVVVkN6ZHVpUXBjMkZpQzQ5?=
 =?utf-8?B?dUZlcnFyTm92RjBYMnp4S1U3eHh1bHNTVmRqbWNKek0xcVcyS1RvTzNQRlJz?=
 =?utf-8?B?VlF4WHVmK2Vkdk5vbFJrQkxVYWJSZEdQclAxMi8rMWdpRzhTQkJQWEVjdjNa?=
 =?utf-8?B?ZWpkMmp3bmQrUFRpWGJOaktCNE1LcjdwdW0wWTlKRWZ6MHRTc2psZEJDVlMw?=
 =?utf-8?B?dmdhWEg4bVh5SzYwZHY1RnBRWVkxM09rZWVPRmpOK1dvUkdyMVlEUWZrTk9P?=
 =?utf-8?B?S2JBOEdacnRac0NHMnc3di81bWdVeThMQmNEdjhwTlJSYk4ydUhqM0Z4ZDZ3?=
 =?utf-8?B?RzZ5dmxoY0FYbkNMWXpRNnJ6RjBFb3F6K1NyTC9hUE9QT1ZNWUoxQ0llOFY2?=
 =?utf-8?B?OUI5bkxiTHlPSFM3ZzF6NXBCYzMzdjlET25IaXptN2llbThzTVlDU3JnMStP?=
 =?utf-8?B?UmRrRTJVQk5ERmNFZW50T0hXeHB3aXpDK2lhVUx4c05JUkZsbkV4WFNDMTlv?=
 =?utf-8?B?VUMrTnI5NXRtRkRsVzhMVWxZVE5xb01QVmovZDRCa0haWlNjTUhIY2l1TDEx?=
 =?utf-8?B?d2NsNmFxVFJaZXFWdnZQejdTY3NXVjhPYXNPUGhuaW55VUZFdEJFTnVHL0NF?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF7551E6552.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efc4278-e939-4dba-bdd0-08de1d1de0ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 10:18:49.3177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PYSIlYVhZjYGj0rWFNWI0xdkk8o3tpu2XuCH3FY4S33CRb7eNMO1xpfq3VZ1yvdH9OYwDrfbbC3tboqVHMejNdXT0/V4SjhvWiZGxakFxh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6815
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgQWxs
eSBIZWV2DQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciA2LCAyMDI1IDExOjA5IEFNDQo+IFRv
OiBOZ3V5ZW4sIEFudGhvbnkgTCA8YW50aG9ueS5sLm5ndXllbkBpbnRlbC5jb20+OyBLaXRzemVs
LA0KPiBQcnplbXlzbGF3IDxwcnplbXlzbGF3LmtpdHN6ZWxAaW50ZWwuY29tPjsgQW5kcmV3IEx1
bm4NCj4gPGFuZHJldytuZXRkZXZAbHVubi5jaD47IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2
ZW1sb2Z0Lm5ldD47IEVyaWMNCj4gRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3Vi
IEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbw0KPiBBYmVuaSA8cGFiZW5pQHJlZGhh
dC5jb20+OyBLLiBZLiBTcmluaXZhc2FuIDxreXNAbWljcm9zb2Z0LmNvbT47DQo+IEhhaXlhbmcg
WmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+OyBXZWkgTGl1IDx3ZWkubGl1QGtlcm5lbC5v
cmc+Ow0KPiBDdWksIERleHVhbiA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4NCj4gQ2M6IGludGVsLXdp
cmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0N
Cj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtaHlwZXJ2QHZnZXIua2VybmVsLm9yZzsg
RGFuIENhcnBlbnRlcg0KPiA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPjsgQWxseSBIZWV2IDxh
bGx5aGVldkBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtJbnRlbC13aXJlZC1sYW5dIFtQQVRDSCB2
Ml0gbmV0OiBldGhlcm5ldDogZml4IHVuaW5pdGlhbGl6ZWQNCj4gcG9pbnRlcnMgd2l0aCBmcmVl
IGF0dHINCj4gDQo+IFVuaW5pdGlhbGl6ZWQgcG9pbnRlcnMgd2l0aCBgX19mcmVlYCBhdHRyaWJ1
dGUgY2FuIGNhdXNlIHVuZGVmaW5lZA0KPiBiZWhhdmlvdXIgYXMgdGhlIG1lbW9yeSBhc3NpZ25l
ZChyYW5kb21seSkgdG8gdGhlIHBvaW50ZXIgaXMgZnJlZWQNCj4gYXV0b21hdGljYWxseSB3aGVu
IHRoZSBwb2ludGVyIGdvZXMgb3V0IG9mIHNjb3BlDQo+IA0KPiBuZXQvZXRoZXJuZXQgZG9lc24n
dCBoYXZlIGFueSBidWdzIHJlbGF0ZWQgdG8gdGhpcyBhcyBvZiBub3csIGJ1dCBpdA0KPiBpcyBi
ZXR0ZXIgdG8gaW5pdGlhbGl6ZSBhbmQgYXNzaWduIHBvaW50ZXJzIHdpdGggYF9fZnJlZWAgYXR0
ciBpbiBvbmUNCj4gc3RhdGVtZW50IHRvIGVuc3VyZSBwcm9wZXIgc2NvcGUtYmFzZWQgY2xlYW51
cA0KPiANCj4gUmVwb3J0ZWQtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJv
Lm9yZz4NCj4gQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvYVBpR19GNUVCUVVq
WnFzbEBzdGFubGV5Lm1vdW50YWluLw0KPiBTaWduZWQtb2ZmLWJ5OiBBbGx5IEhlZXYgPGFsbHlo
ZWV2QGdtYWlsLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gZml4ZWQgbm9uIHBv
aW50ZXIgaW5pdGlhbGl6YXRpb24gdG8gTlVMTA0KPiAtIE5PVEU6IGRyb3AgdjENCj4gLSBMaW5r
IHRvIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUxMTA1LWFoZWV2LXVuaW5pdGlh
bGl6ZWQtDQo+IGZyZWUtYXR0ci1uZXQtZXRoZXJuZXQtdjEtMS1mNmVhODRiYmQ3NTBAZ21haWwu
Y29tDQo+IC0tLQ0KLi4uDQoNCj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBBbGx5IEhlZXYgPGFs
bHloZWV2QGdtYWlsLmNvbT4NCg0KR29vZCBkYXksIEFsbHkNCg0KVGhhbmtzIGZvciBhZGRyZXNz
aW5nIHRoZSBjbGVhbnVwIGF0dHJpYnV0ZSBpbml0aWFsaXphdGlvbi4NCkEgZmV3IHVwc3RyZWFt
4oCRc3R5bGUgbml0cyBiZWZvcmUgdGhpcyBjYW4gZ28gaW46DQoNCkNvbW1pdCBtZXNzYWdlOg0K
ICBVc2UgVVMgc3BlbGxpbmc6IGJlaGF2aW9yIGluc3RlYWQgb2YgYmVoYXZpb3VyLg0KICBFeHBh
bmQgYWJicmV2aWF0aW9uczogcmVwbGFjZSBhdHRyIHdpdGggYXR0cmlidXRlLg0KICBEcm9wIHNw
ZWN1bGF0aXZlIHNlbnRlbmNlOiDigJxuZXQvZXRoZXJuZXQgZG9lc24ndCBoYXZlIGFueSBidWdz
IOKApuKAnSDigJMgbm90IG5lZWRlZCBmb3IgYSBmaXggY29tbWl0Lg0KICBNaW5vciBncmFtbWFy
OiBhZGQgYSBwZXJpb2QgYmVmb3JlIOKAnG5ldC9ldGhlcm5ldOKAnTsgcmVtb3ZlIHBhcmVudGhl
c2VzIGluIGFzc2lnbmVkKHJhbmRvbWx5KS4NCg0KQ2hhbmdlbG9nOg0KICBIeXBoZW5hdGUg4oCc
bm9u4oCRcG9pbnRlcuKAnSBpbiDigJxmaXhlZCBub24gcG9pbnRlciBpbml0aWFsaXphdGlvbiB0
byBOVUxM4oCdLg0KDQpTdWJqZWN0IGxpbmU6DQpuZXQ6IGV0aGVybmV0OiBmaXggdW5pbml0aWFs
aXplZCBwb2ludGVycyB3aXRoIF9fZnJlZSBhdHRyaWJ1dGUgKHNwZWxsIG91dCDigJxhdHRyaWJ1
dGXigJ0pLg0KDQoNCkNvZGUgc3R5bGU6DQpUaGUgbmV3IGRlY2xhcmF0aW9uICsgaW5pdGlhbGl6
ZXIgaXMgZ29vZCwgYnV0IHBsZWFzZSBlbnN1cmUgYm90aCBodW5rcyBzdGF5IHdpdGhpbiB+ODAg
Y29sdW1ucyBpbiBkcml2ZXJzL25ldC8qLg0KV3JhcHBpbmcgbGlrZSB0aGlzIGlzIGZpbmU6DQoN
CnN0cnVjdCBpY2VfZmxvd19wcm9mX3BhcmFtcyAqcGFyYW1zIF9fZnJlZShrZnJlZSkgPQ0KICAg
ICAgICBremFsbG9jKHNpemVvZigqcGFyYW1zKSwgR0ZQX0tFUk5FTCk7DQoNCk5vIGZ1bmN0aW9u
YWwgaXNzdWVzIGZvdW5kOyBqdXN0IHRoZXNlIHN0eWxlIGFuZCBjb21taXQgbWVzc2FnZSBjbGVh
bnVwcy4NCg0KVGhhbmtzLA0KQWxleA0K

