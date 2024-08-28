Return-Path: <linux-hyperv+bounces-2897-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5365F9628BF
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 15:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20BC1F2388D
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Aug 2024 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28783178399;
	Wed, 28 Aug 2024 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hKEiJ9ub"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE1816C864;
	Wed, 28 Aug 2024 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852102; cv=fail; b=npsnc9oU2Pce04aUqkPTaok7LJTuqkPE4bMbpIZ/FvkplKpgEf8QcLdmuSXUcPkDrTlQuU1Fvo0Gcn4ICXpmRcjsfG696x4xs+udOCCwe4PWMq9revcXVoZBzCOkD9me+QD2TtGMbi4LK5VPWivV5YxmdL/yAc5DmZgm0IWHOvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852102; c=relaxed/simple;
	bh=gmJwtoKCU7DC4egyTs2gSk83I4gdrdGO05pXUZA1KBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hgGmDawtf3q1HU6zgLOtsOMqOW8a+v314Ovy+H1qqE1r/ljD8rL7+q8SQ+dhdpKQFx4+porgy0z61CQfhX6xKplPoaI9WOVdEf2H7wmRxFLuYn8OPjF2VgMQbSm+pMiR61/iVAE1ZwMTJQsd+HMSL7E/xsJ3Py8t5SaWmAuEQc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hKEiJ9ub; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724852100; x=1756388100;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gmJwtoKCU7DC4egyTs2gSk83I4gdrdGO05pXUZA1KBs=;
  b=hKEiJ9ubYmr5NwHB3eQwa85E9iage0fZ9L5BsfMWGMRy7bHI+hIzKIbT
   2CfBqcgOh2lWARfxgJqSWNVw2qzqngvC4WRt1YtEkGXHc4oMjZb+kZLPa
   utbEw+griJU/4/QlXcMnBLaHNvdYxKjrXs7AdukaXYVnyDKY8wEWlQJRq
   dBJ7TB2xJV0GrrKW9Hvh5omloUpb14LJE6WVSLsNats/YBIDrXzcCnMKa
   czNw3dS/jrQuOOJOUoHKLhaQZ1glX7XXoLunCtQhhBL0QdaypKnhmxg+N
   grt6YWHAjxh71D4bMVboiJPcuK8J427vLAesbYhzjcmcVTZNcXTsQsuCv
   Q==;
X-CSE-ConnectionGUID: KM+WcmkGS56FTOIMCqJUEg==
X-CSE-MsgGUID: wj2yMVHnQ4yvIVSvFaD73g==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34788803"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="34788803"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 06:34:59 -0700
X-CSE-ConnectionGUID: yE4i3+5UR32lr5hQbN2SlA==
X-CSE-MsgGUID: JeWreLOZRfCAqxuasXthFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="63063052"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 06:34:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 06:34:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 06:34:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 06:34:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LyZjvonSvwOHpJ12P20w5AEq0+tJvfUQLf3P9yQ+eN6SHs/fNF/NAgHx10f9cy9BbdM3ct6wOd2UfGVEvgmN7s/fmDBouOE8oG0xsyPYYDwCw71ExgkDi3Jav25pcdeEYDaPLv5yPaTtkDwmqSoCZ5bqSOlyUNUpL6zbPvn43vyn/7v6L1v4VU3oR89zFmgfVtXWIxY/xy7VQIelVEU8Abi25J1gWyjptpR3tN8y8mZ3iYR+crfWXfIpqYdHd9f8Q3WkZBZYR2KAK384oKYQ3a9jwzvO/13hDZ3z54QNp0M2Tl7agY/qPPT9BlEzSkcGvwA8mCYyDq9ZDB0CLa+I1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmJwtoKCU7DC4egyTs2gSk83I4gdrdGO05pXUZA1KBs=;
 b=ss3PMaASBRMFxqaYESPvRF499ZbdF4I/QqrVQqVuAZux/TK5VmYlBbECMOnkiCaeXNuoxBv9nfMeoleMCi+XQTgwuNwDMgqkP027fwXeCyKK8eLA3gpDXo26/QLy9n1+rq3KsiR5aONjt4/AhSCLDRY2blNJiaePByN9TuxsLjLjXxiAI9utSnoxmlCo3X5HF5PoE+Plz+TFJ27Q1v65PV2e6PoIqJQTDAHogv+QQDbnma1fxfRRAZSvPC185mp/lT+fgyk/fidO3gq1gwvJVEdV8aytEwxyqmB7nC56BR6V38TEVg+QGx6VdbEw1Oj1eNRoCJpvIHzER+vTXZcEtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA1PR11MB6989.namprd11.prod.outlook.com (2603:10b6:806:2be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 13:34:55 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 13:34:55 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"seanjc@google.com" <seanjc@google.com>
CC: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "Hansen, Dave"
	<dave.hansen@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "Cui, Dexuan" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/tdx: Enhance code generation for TDCALL and SEAMCALL
 wrappers
Thread-Topic: [PATCH] x86/tdx: Enhance code generation for TDCALL and SEAMCALL
 wrappers
Thread-Index: AQHa+U8Rr2etvu2hu0eAKDh79CDLuw==
Date: Wed, 28 Aug 2024 13:34:54 +0000
Message-ID: <8e3146250f31db92fa42a29a892858c9ec33aeab.camel@intel.com>
References: <20240602115444.1863364-1-kirill.shutemov@linux.intel.com>
	 <8992921e-7343-4279-9953-0c042d8baf90@intel.com>
	 <crv2ak76xudopm7xnbg6zp2ntw4t2gni3vlowm7otl7xyu72oz@rt2ncbmodsth>
	 <Zl9sXGj890yerBPJ@google.com>
In-Reply-To: <Zl9sXGj890yerBPJ@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA1PR11MB6989:EE_
x-ms-office365-filtering-correlation-id: 8987bfac-9e68-4ca1-6936-08dcc76633d7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TC9LVnZvWWx5TmZQZGo3U2Jxd1Zna0lPZXdHRUxxOVpTMWtvNU0rSkFpMjFq?=
 =?utf-8?B?cjlhOXRyN2N3b042Q3I3K2YzTms4elVzK2FHbGtiN2tRQi91R0hleXZ5bHJt?=
 =?utf-8?B?WHZka0VWMXYyNk0vdE45ZjNuQmh1Rm5EcEJRVm5vMTZ0djlNYzA0allFT0Q3?=
 =?utf-8?B?MVJKdVh0YzRkc0dLSEYrSkxjSzcvbERwNVljNG9jZU15L0dLb2xhRmZvNFY0?=
 =?utf-8?B?b1o2NXFuYXRJeDArNjMzaUh1Tm9wZnZkdHFFems5aStiSmhWNUhWVXR4LzRP?=
 =?utf-8?B?M1NlMDIrL3lTUER0bGRpa1BFQlNjWnBabHkzdTQ1anVEUVBIcG5XUmExK1k3?=
 =?utf-8?B?d0VwaE0zRjBidkNhT3ZEYlhyVXFWVnVOSmg4ZGhzcW5Zb0U4YmRoaFh3aURy?=
 =?utf-8?B?bUFuWDVJaEl1UTV5MnA4S1lXOUkxMTZkb1h4dTVJQ1hGZitVRTk4Yk8xSjMr?=
 =?utf-8?B?Z0JNT0pmZHhHTFlkellBNFpXTjVrK1JRRkUzdnE0OTBMdUxkOUI1dVNndENq?=
 =?utf-8?B?V3k0VGJSY1FFYWNURHNCRW5YRnFIajE3dmt1L3ExOGJONkVIeEdHb0ZtN3hr?=
 =?utf-8?B?UzcwbVhmWGE5UDMxN0U5ZTBBbVZGemROR0J3UXV4T29rdEU5VC95ckRQNnpK?=
 =?utf-8?B?UXhQS256QlpFd0NQdTBCNlJaYUk1bWtwWW96aDNlSUNrcVFqMTZTZmNPMFhr?=
 =?utf-8?B?SDNVeStlTnFERUk3cklkajBmMk42V0VTMUtxQWxtYlRzWE5xRDZCQXZkR2tz?=
 =?utf-8?B?MmRlRTJLV1JHVE5QU1JncnNoT1pOUStSM3dUUkFwN1JCSE4xTTF5UzNGQ1VC?=
 =?utf-8?B?bXN1aER4Y3hrZXVOMTc0UlpaYURxdUQvMGdEQitPaGJ5TDFUVndOTEdORmNi?=
 =?utf-8?B?Ky9JVit2aExFVUdGNzZ3SUxONm90d3k4clltVy9kV3F6TVZNQUNYSkZFTzBi?=
 =?utf-8?B?YVdYQitSak9SdCtOV3pXRUxGZ1hxMGRXZ1psVC93akUxRkRYT3N6UlpWQUti?=
 =?utf-8?B?eXc2ZDJwdUZ0MTJ1ZEV6dloxcEZkdmtLelkrbWZFbDRDNmpMaUZCSnhyVzdr?=
 =?utf-8?B?anYweUFZQVhGbGVtd244R0NNaW9vYlM4Q1dIalg4QU1Ba3BtdmFYZDlkQzRw?=
 =?utf-8?B?aXRNQmVWMnVDQ0tJeklOd1FCVGRWaDNLbFAxaWV6L1IzbDBscklOa2RsbG81?=
 =?utf-8?B?VlJPVUR5RnlGVE52blFlbjhJeTEvQXFtY0NqazBGL01ldEM4eVF0ajVJdWdW?=
 =?utf-8?B?RVN3Myt6QStSN283RmFGaG45bzAwWFVsd2ZmSjJKWFEva2dEM2NQcDdLelZ5?=
 =?utf-8?B?ZnBwTVhiMk5KVnNuTmZPSnlaL1Ntd1NuQVIrZmQ0RDNNSGZjTTE4Rkx1Qzl4?=
 =?utf-8?B?N0N4YmIreVBrZVZiRGkzbU0wTjg2VTlBMlFncm9tb1pseE5QM3pLa3NIR09a?=
 =?utf-8?B?ZGpFbGdGVXdDVS9acDR5VlZtcTh2SzZrelBGVXZRT29KRFM0TlRqSUlBV2FX?=
 =?utf-8?B?aEdLZm9rWXRDNGdjY3BLZUlPYXRURWRJaTU5eS9kRnNPVjFVZ3V3WWVhWk9I?=
 =?utf-8?B?ZkUrYmlzamhPMmVyODBhNUhmYUJnSGd6WWl4anJCYUFVS1dhMG1qWDcvSGVP?=
 =?utf-8?B?THVCcUpGb0xHcnVoVmZwZmtVWnV1cC8xaW5mMEVTVFkyVnFpeURZQW9vYUg0?=
 =?utf-8?B?Mi9hYVpDZ2M1dkZQL1czMUFSS1pPMzNYYTlDNzdMMVFpUlo1U01UNFp3YVJ0?=
 =?utf-8?B?c3MzSXJudjRSd1pvcmtOT0p4TDJkYzFPeW1TL2crT0VIeG9wRWw5dXBxRy9G?=
 =?utf-8?Q?mFPm1bTLBpZJbPJIJkQiCvlUmeMBupXl3mI7o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0lvcURHVmthZDBFUDQwWStwYTFYZTEwZVJOL0NQejFMSEhRNm5JS1hmRzZa?=
 =?utf-8?B?R1dnWm0rWHFhVFNMQVNOUlJiSFYxNisvNTBEQldSOHYvdmMzMWJMZEdFWnNk?=
 =?utf-8?B?MXN0ZDdjMlo3MGw4MHlYT1pPWVFmNnpUaUl4TERZTkxOQ1lveUY3Y1hZK1lX?=
 =?utf-8?B?NHdoOG10Z1Q5VXJPUUlVSk9YN3VZSGhvRHZpbVZ5bTdiVzhZaWVGbDAzKzNW?=
 =?utf-8?B?b2JNR0ZZNmo3ZDQwbEdON3R1UmJpVUQ5TXl0a0dkTnQvVGZkTVdqRmx5THBC?=
 =?utf-8?B?MGRHV3ZCSFJ3eElBM2swNEJLaDJMYzNPZUw1eG4vcjE5VTJRSTV5SlA4MXFV?=
 =?utf-8?B?ZTB4Ry9wcm9abmtsT3pDMnUyeHQyTUZVOEZ4U05jWGpEVDRaYkJxcFZBZGFF?=
 =?utf-8?B?ZXF5dnFLRE9aWkVCOTh3cktXZHZnWVZjcjhXSXNYaHpETU5Jam1Hb3ZTV1ZI?=
 =?utf-8?B?QWtjSXJJT1k0NFN2YmRHSGhaVWZxSlpMSXdoNVBKcDNISTFYcEQyQ1I4c1Nw?=
 =?utf-8?B?eEg2R3BPaDJ6eWlZNkpkMXQzc2QzYm5CcnB0cGRlUDJqak1XZTEzRXQ4YjRR?=
 =?utf-8?B?L25wMFpDdlgxcHBoRzc3SDJSazhJVnVFNTg5QlF2ZUxIc2dXNWpXeHFPR0dQ?=
 =?utf-8?B?TmlvU1l4bW1hZDF4OXl5a0lVeEJXbkwvb2JSS21WVi9ETGZOSWlqcThtNlJp?=
 =?utf-8?B?TUh4TUJUK2plR25mbkVFRnFJWDZwQ2hIMGxtWGsyWW9ySEdGNGtqYTYycmNS?=
 =?utf-8?B?L0hsVFh1MTltRHUrcUlBOVhrRjlTVXdyK2Q5Mnl4SHhZWmNTaXVvMlkrNmZ4?=
 =?utf-8?B?eUp3dTRGVEJnMTFJc1lsblV0RzBrTFVmcDFRdnJOeWR5T2JHL25OQk5MUG93?=
 =?utf-8?B?WHVuaXM3QkhkYlhWckk3T05rb0tBVVk2MFdlaDFOYjlmbzdxQlVocEdFdDBr?=
 =?utf-8?B?T3ZRanoyalNrV3dnR0ZaL0Q4VUcyNHVOeTUyaDdsY0NIZWVwV2R1Qzlualdz?=
 =?utf-8?B?N3NIS0ZESTBWMHVqVXBSSVF4NFdtV2o2d1JTVGNRV2Z5dG9nUHh2Njdld2E5?=
 =?utf-8?B?T3NseFlBMDROTVBFaXZxQ3VJZFN0SS9ZY1dCVnpZbmxxQUpwcFlmbUR3QVpX?=
 =?utf-8?B?SGhVKzdnZmRPcVgrYnpMbUp2VVZDR2ZwNk5ISm1JelNSUVlWRVVzU1FUZGk2?=
 =?utf-8?B?MzZjNmVwblB0QmsydEUyRXBRcjRGRno5bUQvK0tpNmlNNU1IZ0FNS3hIZFhs?=
 =?utf-8?B?TDdsUWg4SEIvK0RLWTVkTzZmZlpGdTBWcFBNc1JTYXQ1L3llQXZ2M3lQbXZm?=
 =?utf-8?B?YlZJSGRHbXg5dE13M3FuMUFZMnlySTc4dGVJcUlhSitKck12VVdXWWZpclY0?=
 =?utf-8?B?OUJ1YTJaT05XaXAvckN6MWNjK3E4aEFSZjgvKzg0d3NxYWV4eU01RUtqM3NK?=
 =?utf-8?B?dHZSNE1ITWppUlZ3am1EanFRcHU5RktWNEJ5N0RFUzRoWlN0OVQrZHdxb05C?=
 =?utf-8?B?WFJjamlWVitFZml1OFB5eE5Yc0kwOHVkU2N1bmJ6T0FsQis0SU5NUy9wcXAx?=
 =?utf-8?B?UUs5NUFQTXkxbkl5QUpyWDc1WVAwcFhYaEhiTjV1RjdJampBUmVwa1k4a1JL?=
 =?utf-8?B?VGxKY2NSVjl4RHVSd0hFRlFScWUyaFNzL29MK2x6Q1NhT0JDSVFWNDNZcUV6?=
 =?utf-8?B?NW52djE4UVNHWngxVXlIM0dURVZnRXMxNjZkb3M5V3l5TkZMOWRWTlFqaHlm?=
 =?utf-8?B?NnMxcVk4ZHZtemxSOWJyZkZMbXJlS1hTYlk3d3VLOThLR242dHpPZzA1T1cy?=
 =?utf-8?B?Z1JFT2VyM3pLQi8ybDYrU3Zhc0tFcVF1U3pBdmRpbEtjekZURklZTkhKbVB4?=
 =?utf-8?B?M1NWekQvYU53eUxkSnVwTjBmVmhmUnZSMU5LRktKNVJVRE5YM3ZVYlRacVZF?=
 =?utf-8?B?N3RRMFI0T3NFajJ4Z0k0K3NvUUhSanZ1WmlxQW1oS3NLU2NQRit1cm5yREVv?=
 =?utf-8?B?T3QrNG5PNllmdnNHNis3Y291QkY5NjhwSzJsWStTK1grOEZvUkxWZlZRMDUy?=
 =?utf-8?B?NUFvSjljMDFwVTlPaGNWSGsyTHlxSGZxVHN0b1k3WDIxYmZ5R1pjVEZ5ekhn?=
 =?utf-8?B?K3FpWWtub0l2S3VlU2VzTFNDWVRiTUhaYnNxNGV0cHBzWUIrSk5jM1EzbjVX?=
 =?utf-8?B?RWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <074DE95B9DBA7C4AB36013FE6E1289CE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8987bfac-9e68-4ca1-6936-08dcc76633d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 13:34:54.9659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RDPt96+fyO5S075ZPx0mlKYEJ5NV2BfqMsX9aZBxuSRID4VBtZt0Sbk8+L3VkfdOct7JvVsuMkmcOzFz4q48nZIiyfXWrueUABZzDJy7PzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6989
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA2LTA0IGF0IDEyOjM0IC0wNzAwLCBTZWFuIENocmlzdG9waGVyc29uIHdy
b3RlOg0KPiANCj4gSWYgd2UncmUgd2lsbGluZyB0byBzdWZmZXIgYSBmZXcgZ25hcmx5IG1hY3Jv
cywgSSB0aGluayB3ZSBnZXQgYSBzYXRpc2ZhY3RvcnkNCj4gbWl4DQo+IG9mIHN0YW5kYXJkaXpl
ZCBhcmd1bWVudHMgYW5kIGV4cGxpY2l0IG9wZXJhbmRzLCBhbmQgZ2VuZXJhdGUgdmFzdGx5IGJl
dHRlcg0KPiBjb2RlLg0KDQpIaSBTZWFuLA0KDQpXZSBhcmUga2luZCBvZiBzdHVjayBvbiBpbXBy
b3ZpbmcgdGhlIGNvZGUgZ2VuZXJhdGlvbiBmb3IgdGhlIGV4aXN0aW5nIGNhbGxzLg0KeDg2IG1h
aW50YWluZXJzIGRvbid0IHNlZW0gdG8gYmUgZW50aHVzaWFzdGljIGFib3V0IHRhY2tsaW5nIHRo
aXMgdXJnZW50bHkgYW5kDQp0aGVyZSBpcyBub3QgY29uc2Vuc3VzIG9uIGhvdyB0byB3ZWlnaCBz
b3VyY2UgY29kZSBjbGFyaXR5IHdpdGggY29kZSBnZW5lcmF0aW9uDQpzYW5pdHkgWzBdLiBJIHRo
aW5rIHdlIGFyZSBnb2luZyB0byB0YWJsZSBpdCBmb3IgdGhlIHRpbWUgYmVpbmcsIHVubGVzcyBp
dCdzIGENCnNob3dzdG9wcGVyIGZvciB5b3UuDQoNCkFuIG9wdGlvbiBpcyBzdGlsbCB0byBoYXZl
IGEgc2VwYXJhdGUgaGVscGVyIGluZnJhc3RydWN0dXJlIGZvciBLVk0ncyBjYWxscywgYnV0DQph
cyBkaXNjdXNzZWQgb3JpZ2luYWxseSB0aGlzIGR1cGxpY2F0ZXMgY29kZS4NCg0KUmljaw0KDQpb
MF0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzNhMjEwMjg2LTdkMGYtNDQwNC1hZDc5LWM4
ZWFiMTUxNDM4MUBpbnRlbC5jb20vDQoNCg==

