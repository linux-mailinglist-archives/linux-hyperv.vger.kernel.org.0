Return-Path: <linux-hyperv+bounces-1186-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE596802E5C
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Dec 2023 10:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9958E280DDB
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Dec 2023 09:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410CD125BE;
	Mon,  4 Dec 2023 09:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RuUqpk1Q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43472102;
	Mon,  4 Dec 2023 01:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701681461; x=1733217461;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I7+ytb3T1IkNoe8k03dKz+s91PjAuawKgL4J51bvfFA=;
  b=RuUqpk1QiD6PY2O6TFP2CcG9KLhy8EpC4JdRRSf8gSNz1o4XVbzY4ws9
   XUPTqkowvOyqrXpP2gSJgAVGcbMRAp+Ik/Cyo4+1uq4XHbHCOCj/Go1TI
   Nyh4psOoS22IUuKrSiYB07e55UdhIXtFcyztuGjUn5kbOi6awIQ//mTvo
   5+tNwc353GKejdEAKuT9Uj5rDizi8cwrk24qENmKaYQsEewo2N8BLY2J7
   uDGr5sn+GuSxPFfXFNfjJnYyT7/4fA8dawwDuxtYu1fgFjYWduKEO0j1/
   tQkYgp16v+Wp8SHUvO9+YUTaSiZDRZZ6DShdEMbQdsv1D4w/sonYTy/ke
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="12420847"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="12420847"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 01:17:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="1102024953"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="1102024953"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 01:17:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 01:17:38 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 4 Dec 2023 01:17:38 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 01:17:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZ93TFXRk5CazpGKqYJ/ZSgspfDw9Ea8XoX4fGB516tI+DmNBypkn+2ucpfB7E/hac0fEtdzNqgP1sRA7+ZDU+fhHTErBpLRdmCPoJCzV7Qmdi5J4ys7JpfEJMfmdSobssfDu2Vay2Cfr6voHG4EP7L5haXh9CfwAsiRU+IE9aaihaic5XuyB6g+QKgSonxcF4TOr0WoB1nhvQyd4G4ndy2ZS5UxVa+zAfOpjcrv/xALXwS61SNqFD/3LpTWgIPqQHkcN9N4P0IVWG7KWZw3hMlCFCLEAfmL4LSKfw9LswckO+yMemvWkap3w7n0fTxmZYDyegqz3Ax+isCq4CJ7HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7+ytb3T1IkNoe8k03dKz+s91PjAuawKgL4J51bvfFA=;
 b=EjJHpMrFHZ2qDg5vVBHgqwGKRmQdnzEMWA6+XhLY4Zuktfpq1YBx7+YFIIKK/H1GcDuJJJHTMQ/f3es8P4LLbat2BdUEONuw9IN9K01dYNnxgosyfZXjj4rPB7NjEl3u7LjsCHCDhLbRJG3BJRbOhiexgkD5GX67qscCdwXrB/YwWKQTcBUfg8XvAio8BYYQIM5JLm9yuuLywRWjuvboSfmhyMysWG6RYiX+9yW4YZ5mN/g+FFBxrwgU1iAmZ3yuRcrPBbrKIB92wgy+v+uSmwVcII/bHcr3TIOkAfFy+q1d4Ewtai6wae2iN389ns8bXw4EZajSuS81MT7fXR4txQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 09:17:29 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed%3]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 09:17:29 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Michael Kelley <mhkelley58@gmail.com>,
	Nikolay Borisov <nik.borisov@suse.com>, Peter Zijlstra
	<peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky
	<thomas.lendacky@amd.com>, "x86@kernel.org" <x86@kernel.org>, "Cui, Dexuan"
	<decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"stefan.bader@canonical.com" <stefan.bader@canonical.com>,
	"tim.gardner@canonical.com" <tim.gardner@canonical.com>,
	"roxana.nicolescu@canonical.com" <roxana.nicolescu@canonical.com>,
	"cascardo@canonical.com" <cascardo@canonical.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "sashal@kernel.org"
	<sashal@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Thread-Topic: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Thread-Index: AQHaHWWtJXruLfiu906BueKp3+5D87CY5kFg
Date: Mon, 4 Dec 2023 09:17:29 +0000
Message-ID: <DM8PR11MB575090573031AD9888D4738AE786A@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
In-Reply-To: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|MW4PR11MB5872:EE_
x-ms-office365-filtering-correlation-id: e3b5e092-a004-4c47-1bbc-08dbf4a9d6d1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yN9Z5pIwa+SQRK5BPlfmQErViHame+S7RJiFVF/ZZFIPqtHgsB3LfHwi/SXhj93jJ4DWoxmTCH1O70oSIToYAdXUalH8UxoDE5mrqdR69xvoWBZW6oQ5XVnmRSbGEPYw3TjwtUhKYXb0bQdRhUp5YJD6Lk7AlaW0XrIaJL716TavXROKJCEywGij00JWJsCP9rc9Y1FYS1gSfgZtoZnCx0RnWNVb7bDjUUZNfN4MWp8GZiJ+AQbSxMxQoP930dNIzAKUU0GAK5YAVO268CQxbLbooN+gWHcwsIiiC4bMNtuqPmSCYOjPld1v46VyIT7x9dHkcedKBrdPrpopy/jpRMacgoqFSc5zy6FPnqrxgNK6xarg3ib+/glWGlQEEBVhdK1tW4+96VZa66cXSJDxu2STpiPfmnY+0kKZ0487InjA/LEOJ5ZyPWTvg3pE4H2H8odO24hV2aPlJ5WHa1WhDSn+yCKLnQsOPQ2BXKekNg8wb7zX2vtNyJMvOs8lmmg8PVKZ+pehbptX/WwlG5nHC4Msmd6MzZUKdCyPkJs4mmy19hi5NEgr+HpogDaO88iNL0b7zgtN7yz3EZGIUIVrzMMnPH1V/PDbSGI8x/8gYXKL1dNiQaZ2vlZUB4eA4yJCz25nr2nAOxu8tnKykbMSpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(5660300002)(52536014)(7416002)(86362001)(4326008)(8676002)(8936002)(2906002)(921008)(38070700009)(41300700001)(33656002)(9686003)(6506007)(82960400001)(83380400001)(478600001)(26005)(7696005)(71200400001)(38100700002)(55016003)(122000001)(110136005)(316002)(54906003)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVdLMVVYZXc0R1c2MXY0WGN6NEJCdG9xZHJDVEUxZU5FVzJnSHdJa1BaQklC?=
 =?utf-8?B?Wks1UzFNdyt1L1RCTFREQXFXa2NnNnFEdTduZkx3NEdFZ0dRNEdwUDd4amRa?=
 =?utf-8?B?TWErSWtmU0l0OG83T1pqNUp1bjF5VGtxQTlxUW9UcWF3QlJhN0dFL1JXNmJy?=
 =?utf-8?B?VzlMZnplNCt5SkpZUHFYSjFsSmhRVk83a0FEbXVLV1MwVEJtb0JWaHBjb1RY?=
 =?utf-8?B?S0FZRU9MSStwMGtMbUpVZ2lpVngzOHp0VUpsTDkzeVBiQkROaVVxZzczWThY?=
 =?utf-8?B?U3FqcmlLeEJxQW8zaytRa1ZxY1BhdStGTnNRUlNYRHVYdVgvazZZNFFXWkVt?=
 =?utf-8?B?WFM5SFpHZml0NlVyNW96bEFpZmtLVEJKc3IxTFpGNnEzRnVadEovTkpSK3Np?=
 =?utf-8?B?UW8zOWc3TWJUMjk2NWNFWklCdUJSc3pvMS9NR0YyWXVVYmlGRThLSW5ISEdj?=
 =?utf-8?B?U1lpWVF6c1cvVnhtSmxJOUNEbjJZTldDeEZNNExTWmwwQ2ROWjc5Mm9wL013?=
 =?utf-8?B?TkdkZFZLNXM1dCs3U0dBWDhyWTdTZ082MUhtaTNtNVNiaWVCSWxsVEl1YWpm?=
 =?utf-8?B?dHQ2V2RyQjRZejZYc1d4QVlvRzZ5SUJlR2x4eVpwUmVvSHJyWVBOelVYLzBX?=
 =?utf-8?B?TVppb3FTWEkwbXN6bExXYkRMeXhtWjc4aVp0ZkpCOXFLak5xejhuRGd6VEgx?=
 =?utf-8?B?MlZDUEpvcXk4ZUVPTkorUncwdXk1SUlrKysxb0p3c1ZHTjFoTGdVb3RjK2NY?=
 =?utf-8?B?WTJQS3BXMkd0bDd5UWZMWVo2T3VsY0laY0FlV0dlbXl2NlFrMXRpdFREdytW?=
 =?utf-8?B?eWVsRnhoZUo5d3lNU1h2dVBQNTZva21iTmpaWVBPSk0xdWdqblZtQzJnL0xm?=
 =?utf-8?B?UHMxcTV4YzAyNE8rUGxPQ0MvbjFZRzF3TlJGckpEc09nYXZJcWx4K0pjQnRt?=
 =?utf-8?B?MXd1V09sbnF1WmJWOVk5dDZ6U3VOZWo4TUt3S2x2VWlnQmRiQlRlS3JZZFRM?=
 =?utf-8?B?UTBzK3VvdS8vMHdVRXZRY083TzdPcm54YnEyZ3BUZFZJdmhQRU1iUURVcjVx?=
 =?utf-8?B?TXhHYVQ0aDBqcUxFbTF6eFZNQzZFWXZlZjREbDVZdHU1bUMxSlUrdHhPdFpH?=
 =?utf-8?B?ek01QUkxUXdTbU5hcVZObEx1SmlaQU5yaXRhSVR1RWd4VkhCRlo4OE54bXNS?=
 =?utf-8?B?ejJjaEFpRkptSUwrVnFSaWJJSGZtNEhWbkE0cTlzaVR2eTRPcmw5bWN2bTUz?=
 =?utf-8?B?NWtWZk5rZmVtWWR4RGNCMWIrOWZWVXAwYmhDTjc0dkltZ2swWFpDdnBYNHMr?=
 =?utf-8?B?M0ZCekk1dzA0N1E3M0E2SWsrOTRvWHgvY0VCYlF2R1l6a2UyK0pBWmZJZnZQ?=
 =?utf-8?B?V2pqOEpCUSsrTytrb0o2K0FuLzViOWJvdzQxeFF3ekF4K1hMV0NnZWk2WFY3?=
 =?utf-8?B?TXdFVnkvZXVJZmxwdS9BN20rSitNZm9YZ3p4US9sa29TWlBCSXhaTFd0VnJI?=
 =?utf-8?B?RHNvVWdpTmN5bVRPQUZqdXMvOEtDZHhoWFJMc0c2RmlvaXc0UDBxVTlkOVlQ?=
 =?utf-8?B?bVd5UUw2MkhmbUlrN2dNZDVsdHc3YVN2OFhyWjVtRXlZc3NOWDcrd3RtbCs2?=
 =?utf-8?B?YWVWSWQxTlo1OU1QaTBiWnNmT3BhOFhML2lWaUVjd2JOZ0JRZjJYV1NURVBw?=
 =?utf-8?B?TUkzWGtGU0FuTHJOR0Jpa0lGV3pFampreFVwY1R4MUFvZFFBMENtS0txS0Iz?=
 =?utf-8?B?NStjaVlzaVdvVUt3Wm9VamtGMFRjRUFWWGl0TzhyTkV0YVlpNzJJdHZWcWVh?=
 =?utf-8?B?T1NCMjZORG1Bb2RFUWFHUDNPak0rTzgvNlY3V2ppS0lUVmxtUmh6TTFhSzVl?=
 =?utf-8?B?V1VtWCtpbjFRRi9WWURYTHpTSHd1MGtJOTRnejREUTM5dGNuMHp3K0NHQUo4?=
 =?utf-8?B?QjFKUHlJQlZCdExzNStRS0h3amNIaG02TW5CbzNuZzFxengyNmFQNnRuR0tS?=
 =?utf-8?B?L1kwbUxXbVRxWTh0bW8ySHFKaERIT3NndXdhWGZra0ZVZ01aUEhkNW5nNm94?=
 =?utf-8?B?R3hORkdpa2xySUFhY1BpWlhJWUkxNEt0bUpWUWdGb29JUjNab2dMMXRKYjVC?=
 =?utf-8?Q?upsHnLNa2tPDSgNXBRWHGkWq9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b5e092-a004-4c47-1bbc-08dbf4a9d6d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 09:17:29.3286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /n6oaFUleRqhzGyX667DZzgzOP9UNKN7B3nb6f2QmYzo0ubV7LdZp04mTcVb+q3i6s6HRFZNL+q0HcNp4W0Vb6YSsQqcE9aKatwLVlLYi7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5872
X-OriginatorOrg: intel.com

PiBDaGVjayBmb3IgYWRkaXRpb25hbCBDUFVJRCBiaXRzIHRvIGlkZW50aWZ5IFREWCBndWVzdHMg
cnVubmluZyB3aXRoIFRydXN0DQo+IERvbWFpbiAoVEQpIHBhcnRpdGlvbmluZyBlbmFibGVkLiBU
RCBwYXJ0aXRpb25pbmcgaXMgbGlrZSBuZXN0ZWQgdmlydHVhbGl6YXRpb24NCj4gaW5zaWRlIHRo
ZSBUcnVzdCBEb21haW4gc28gdGhlcmUgaXMgYSBMMSBURCBWTShNKSBhbmQgdGhlcmUgY2FuIGJl
IEwyIFREIFZNKHMpLg0KPiANCj4gSW4gdGhpcyBhcnJhbmdlbWVudCB3ZSBhcmUgbm90IGd1YXJh
bnRlZWQgdGhhdCB0aGUgVERYX0NQVUlEX0xFQUZfSUQgaXMNCj4gdmlzaWJsZQ0KPiB0byBMaW51
eCBydW5uaW5nIGFzIGFuIEwyIFREIFZNLiBUaGlzIGlzIGJlY2F1c2UgYSBtYWpvcml0eSBvZiBU
RFggZmFjaWxpdGllcw0KPiBhcmUgY29udHJvbGxlZCBieSB0aGUgTDEgVk1NIGFuZCB0aGUgTDIg
VERYIGd1ZXN0IG5lZWRzIHRvIHVzZSBURCBwYXJ0aXRpb25pbmcNCj4gYXdhcmUgbWVjaGFuaXNt
cyBmb3Igd2hhdCdzIGxlZnQuIFNvIGN1cnJlbnRseSBzdWNoIGd1ZXN0cyBkbyBub3QgaGF2ZQ0K
PiBYODZfRkVBVFVSRV9URFhfR1VFU1Qgc2V0Lg0KDQpCYWNrIHRvIHRoaXMgY29uY3JldGUgcGF0
Y2guIFdoeSBjYW5ub3QgTDEgVk1NIGVtdWxhdGUgdGhlIGNvcnJlY3QgdmFsdWUgb2YNCnRoZSBU
RFhfQ1BVSURfTEVBRl9JRCB0byBMMiBWTT8gSXQgY2FuIGRvIHRoaXMgcGVyIFREWCBwYXJ0aXRp
b25pbmcgYXJjaC4NCkhvdyBkbyB5b3UgaGFuZGxlIHRoaXMgYW5kIG90aGVyIENQVUlEIGNhbGxz
IGNhbGwgY3VycmVudGx5IGluIEwxPyBQZXIgc3BlYywNCmFsbCBDUFVJRHMgY2FsbHMgZnJvbSBM
MiB3aWxsIGNhdXNlIEwyIC0tPiBMMSBleGl0LCBzbyB3aGF0IGRvIHlvdSBkbyBpbiBMMT8gDQoN
CkdpdmVuIHRoYXQgeW91IGRvIHRoYXQgc2ltcGxlIGVtdWxhdGlvbiwgeW91IGFscmVhZHkgZW5k
IHVwIHdpdGggVERYIGd1ZXN0DQpjb2RlIGJlaW5nIGFjdGl2YXRlZC4gTmV4dCB5b3UgY2FuIGNo
ZWNrIHdoYXQgZmVhdHVyZXMgeW91IHdvbnQgYmUgYWJsZSB0bw0KcHJvdmlkZSBpbiBMMSBhbmQg
Y3JlYXRlIHNpbXBsZSBlbXVsYXRpb24gY2FsbHMgZm9yIHRoZSBUREcgY2FsbHMgdGhhdCBtdXN0
IGJlDQpzdXBwb3J0ZWQgYW5kIGNhbm5vdCByZXR1cm4gZXJyb3IuIFRoZSBiaWdnZXN0IFRERyBj
YWxsIChURFZNQ0FMTCkgaXMgYWxyZWFkeQ0KZGlyZWN0IGNhbGwgaW50byBMMCBWTU0sIHNvIHRo
aXMgcGFydCBkb2VzbuKAmXQgcmVxdWlyZSBMMSBWTU0gc3VwcG9ydC4gDQoNClVudGlsIHdlIHJl
YWxseSBzZWUgd2hhdCBicmVha3Mgd2l0aCB0aGlzIGFwcHJvYWNoLCBJIGRvbuKAmXQgdGhpbmsg
aXQgaXMgd29ydGggdG8NCnRha2UgaW4gdGhlIGNvbXBsZXhpdHkgdG8gc3VwcG9ydCBkaWZmZXJl
bnQgTDEgaHlwZXJ2aXNvcnMgdmlldyBvbiBwYXJ0aXRpb25pbmcuDQoNCkJlc3QgUmVnYXJkcywN
CkVsZW5hLg0KDQoNCg==

