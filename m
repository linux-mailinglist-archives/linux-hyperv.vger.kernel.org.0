Return-Path: <linux-hyperv+bounces-1274-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8528880889A
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Dec 2023 13:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9BF281DEF
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Dec 2023 12:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8D83D0DA;
	Thu,  7 Dec 2023 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7TKtVN2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0764F10C9;
	Thu,  7 Dec 2023 04:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701953939; x=1733489939;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KiqXzZJC64gTsFx8KlW0pWYBPdCaOEqZWmXU0VWtzlc=;
  b=R7TKtVN2nAbTbCmDnVg7elKN72OkPb4HenfAy2XO+Z1EM9UbhOQkcRw2
   wJn1VKQEmqAu4VgOUlin3ygJOe67p6+Li+B3yG7uzgZSO4iUzYZ70kiNO
   HnPJBcstiOpY+L8Jo+3Zad+BurZQm0FtEL2s8eljdNVHwzOcQIIpTrr3Y
   jylXCASw1Z6QOooBDa28cfBvzGZ+pVevLIKU+bqJpt84J/KC9v9oNcEAy
   YGfsk9lgajIp/POPauxBqr9E8zOwg7M5zEAGJURh4wWE8G2CrhKGQe3GT
   dp5Mvi+S6LfbIvwnaGxllAa9ccoLpwOTYIhUNMkd0Casi33NWqUTqtKHH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="7534499"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="7534499"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 04:58:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="747955660"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="747955660"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 04:58:58 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 04:58:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 04:58:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 04:58:57 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 04:58:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lN3iIIK+EPWM5dOSiCF0Lip/Gkh3WAHvSi/Ao70R6goGje+nVSFjKbTQ1j1fKwA+Y7ggIiH/SW8q5cJHK/o0jmRjoY90PbKWJTlI4BbfHoqPC4eh8faClFby/W/j6L0kwv8gVgHA045plfINj4W4rto/6vCX6VRm2v9xBcKKRlVXNXCWcZv8vFH1rHBIoVjyRptjOcJetcgQyuRoN8v56HSd+LHnAD4N4ytC5FUMkK8+fGSeUZYLTt96Cqme48ofsVBVIt8Cud8MuH959rNsOLlpr7FTOW+9QoMiBM/dsqeH9X4T/qvTWIIP8YuE07TKm/nTrAitsppEr8WgvPi5VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiqXzZJC64gTsFx8KlW0pWYBPdCaOEqZWmXU0VWtzlc=;
 b=kkZh3j3rmls/xxPPHY2da/lj4oQFY4Oek+5UOHdk8SsaVLU+xurPMhL3vANEqkArGKZAfkDgidFIJnNc+MJvE9HbAgea/Mfp4XsCB94luswEb0VQvGiWiBJ6mP086uWr7O0hCnD5VhvQLXDmca+v5Sc+vuckPWf8H62nnsr1xiJObce3IcQWOslQEpYJnVcDFKWMne+FZzSYI6WAGqQ11z/MOie1uULcr5s1RlB56uVur4NibZP9fhQfVm315/UV5qvXOpDuWJt1agHj5YqsjCM1yYhJM6dEbTeVrcpcZFYodp3yG5lbtk5hRejwNmlaP/Czdkd62lHlb4fhlaKB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA1PR11MB6942.namprd11.prod.outlook.com (2603:10b6:806:2bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.38; Thu, 7 Dec
 2023 12:58:54 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::5d1:aa22:7c98:f3c6%7]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 12:58:53 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"mhkelley58@gmail.com" <mhkelley58@gmail.com>, "Cui, Dexuan"
	<decui@microsoft.com>, "jpiotrowski@linux.microsoft.com"
	<jpiotrowski@linux.microsoft.com>
CC: "cascardo@canonical.com" <cascardo@canonical.com>,
	"tim.gardner@canonical.com" <tim.gardner@canonical.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"roxana.nicolescu@canonical.com" <roxana.nicolescu@canonical.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "stefan.bader@canonical.com"
	<stefan.bader@canonical.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "sashal@kernel.org" <sashal@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Thread-Topic: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Thread-Index: AQHaHWWtv7u0f2izB0aVCuwkdix+ibCH744AgAFYfQCAAANSgIAABfUAgAApowCAAC5QgIAHFxKAgAPoeACABhmPAIAB7BUAgAEw/IA=
Date: Thu, 7 Dec 2023 12:58:53 +0000
Message-ID: <59bdfee24a9c0f7656f7c83e65789d72ab203edc.camel@intel.com>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
	 <20231123135846.pakk44rqbbi7njmb@box.shutemov.name>
	 <9f550947-9d13-479c-90c4-2e3f7674afee@linux.microsoft.com>
	 <20231124104337.gjfyasjmo5pp666l@box.shutemov.name>
	 <58c82110-45b2-4e23-9a82-90e1f3fa43c2@linux.microsoft.com>
	 <20231124133358.sdhomfs25seki3lg@box.shutemov.name>
	 <6f27610f-afc4-4356-b297-13253bb0a232@linux.microsoft.com>
	 <ffcc8c550d5ba6122b201d8170b42ee581826d47.camel@intel.com>
	 <02e079e8-cc72-49d8-9191-8a753526eb18@linux.microsoft.com>
	 <7b725783f1f9102c176737667bfec12f75099961.camel@intel.com>
	 <fa86fbd1-998b-456b-971f-a5a94daeca28@linux.microsoft.com>
In-Reply-To: <fa86fbd1-998b-456b-971f-a5a94daeca28@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA1PR11MB6942:EE_
x-ms-office365-filtering-correlation-id: 2f2c85da-a873-42ea-8c48-08dbf72443fc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dmIjZ+kPoviyKopnUwl+pNdkGErK9H0Pd5YpfhWyZ6sEV9POS+nLY/AFLHT5tuCVDj1Ek2cD7Vsrj/AjYVVJGY/H/Eqf7XkEefsnLSnW+kbHfegPa9Sv5oS1gb0vXd836vJOSfla+NVnKhFCwRunYTiKKsMUzldXSdn2KeH8rT8uKurTW7qn7enW1kUP3fU5VCp5i4MvDbmt2ly07eE7QMF0OW++zduOGJ3wcx7uieMo9476mltmnDfIU3LPCMHargnZwpu/E41EES7bNQ7iwZ+c7tqSQXDHpVtPuuSGMaX5qBTkzK/xGW7PwJr0LFPEgDGXMpwYabpR6dV+YpUDVJqgAH/qUpWxT9ByuO+cLrheTrYM8RT/Ny4Qd/JAM86JXf72qewbJQC0hsRlze/GoVdX4Wq1V7ehu1xdaUx1w7q/Eoar/2zqqCq9J8r/lgEeifvsZ2bZcLkgC7DWjmPWw8sAlIDT47KoTKxkRbaTpkmSmfNMt46Gi92/cfAwqeCrFvc9p+o5/s6ZaOMoYQNqqlAtCw4XcUps7YC1M31w9GJ34MECXIl8OBUbuBYPSYfe3gFRkNarRNOHNlmzqFQsXRdaAXQaKQTHUm276p9APw4AbGXfMSn12G9KbcbD3ztu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(122000001)(71200400001)(6506007)(478600001)(82960400001)(38100700002)(6512007)(26005)(66899024)(83380400001)(2616005)(5660300002)(8936002)(2906002)(7416002)(8676002)(86362001)(4326008)(41300700001)(36756003)(66946007)(38070700009)(66476007)(66446008)(64756008)(54906003)(110136005)(91956017)(76116006)(316002)(66556008)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZndvS3lZMTI5VEhyWGkyZ3JnSTRUUVFrNnp1V3c1SmJDeEkySU41c3JrOE51?=
 =?utf-8?B?T2VCaC9Ed1NzeFc3a0tDU2ROZythcU4xckVEOUM3aklzR3BFYjVPcmdhdGk5?=
 =?utf-8?B?QXFNM091WVNrRVRrZm1FWS84NGJnbzYrQ08wTE05N3VzRUJlaFJ4Q3d0Vngw?=
 =?utf-8?B?K3NiSU9VWkk5TnFrTmFlR1hWS3IvcXVPcllvZERsbFh6UVh5aTc2Y01LU0s0?=
 =?utf-8?B?Vk91WHowdGFxYXIrV2NPNm1Ec0Z4MkI1VTZaNXFZKzFFdmgwWW5vUit1WkJK?=
 =?utf-8?B?Zk5kMGNCaElLS2JrZk9CSThaL21PUFZBSCtFV21FZGtmbDBMRUxBVkhTd0d5?=
 =?utf-8?B?d3ptNFJYZ2ZvcmtwTjcvcDh0V3hEMy9yM25ObUxVSTBuSU1wYzVpdXIrdmRN?=
 =?utf-8?B?VWplekdLUW1KZUN4YzRGYmlFMU0yVGhFcUcvTlpuUFdaWkFOWXpPNXpibWV4?=
 =?utf-8?B?RFdnMERWcm81dVhhY1RGZlpUNkNnKzFTbytRdEZ1ckh2VC9zcHhCbEJROTBU?=
 =?utf-8?B?Zm8xdkI0dFllRExuTlhnU1QrYTlRUDJPZE1Fb2VJZ3pGd1NlaWlUbEU0KzdF?=
 =?utf-8?B?T3RkaTlBRzZEcGphaGVZSUE4Z3NLd3lYRitzYlpML3JtM0x5ZjdFOXB2L1hJ?=
 =?utf-8?B?c1ZadklUTVVhb0ZndXFTQnFGNldOUVRUVHA1STNpQTl4KzJyNnA4SnFQZHVB?=
 =?utf-8?B?d0NOb1BkeDZvZkpScHo2d0hTQkdha3I3SGRBaVVPNTBNNFpQTjB2RTR4Mjg0?=
 =?utf-8?B?L1cyZzZucDYrRGY4NngyS0pVakhacVMzMGVOaGFyMEFGaHlUcjRLZ2RpdFBP?=
 =?utf-8?B?SVVaZUEyRlN3ZG02VWxjQWxNSXJ0NnFhdEY1T2dzSCtIUHRSQ2NQUUlHVUs4?=
 =?utf-8?B?QkFDcVJwWGM4Zm9Bd0pwVlV0QkJKTExYUzBBc1BSSVAvTTNSeVBzZ09Yc1VO?=
 =?utf-8?B?M1BFNmNKR3Vrc3Z4TmxyTHNtamdyTmk4dlN2cjJoQzR5SlFBRTd1Yis3c2NB?=
 =?utf-8?B?QzQyRFZSS0NUOXlpS1p4aHY4cEtHc3hHcW1ZRjZhTVpxRzZUdUwwSWRFYjY3?=
 =?utf-8?B?U2dvanhpVC8yU1k1ODl5ZGI2clRqdkhsYlpOZ2Ywa3ZCSVNaMmhKbGlwYloz?=
 =?utf-8?B?SEZZWEhwM0U5YkN3bTlEdzZVV1YvOU5hZnhNM1g0Z0FHUGZXUnpVdXRlbENr?=
 =?utf-8?B?ZFMwZFZWWncydXJ1bHMrNGxuN3liU3VKa3BEcUtxTUhDZXNwUUlVNGZmYW90?=
 =?utf-8?B?V0hGUUUyNmZhRC9ZdU8vbDNXbXFJWGJEenNrUGp4S1hwM1A4V01uNmhESFU2?=
 =?utf-8?B?Q2VWUExjOWFiUVZSRm5PSmt6M1hZSlJkbGx3Vk1tcHZwQ3NKZjJvUWM5LzhI?=
 =?utf-8?B?dXVmMisrZXgwQmNPMWdsZjgvWkFqRkhDdmNOYzBZNXlERmtiY3lnU2dUaDFz?=
 =?utf-8?B?eVFzTy9wNlNjSG92L05ia2pzYXhad0JUSTRhRHZHbThtMUlXN2cwdjF1OGdZ?=
 =?utf-8?B?UXZtK09KdHlDcloxYWIxTTFHNWUrRWRrMHNMbmY4K2NCdG83M0JEblRDaWxx?=
 =?utf-8?B?eS81SGJHVGtEUVdoYVNxUmxKRk1xT29wYnUyb2NUQUdORklaT04yR2VxaW0v?=
 =?utf-8?B?cmZLMUNwYTJMQnRlRy8vY09KdDV4Tm5OQ05nbm5FYmRSck5sSWlCc1kxaXhh?=
 =?utf-8?B?U2J0aCs4T2tYS0J3S2ZtOGEwRlRWOC85b29ybGc2WVRvVEUxUENoT2tPVU5k?=
 =?utf-8?B?aTc4OW1MMGJPUWxPSkd1SWpuMHRudG45WWhxcWZzY3BIRmZjUlc1dEY4dkNN?=
 =?utf-8?B?Z0lJSGE4bno4RE84Vjh1UVVQd25jdFo0SFFESS9hSG1sUy9PdDYzcUo5cTlQ?=
 =?utf-8?B?dWg1WEV5Rm9wdmVFWHpkdDFnemV0VUZoRkhLRUJJRllPOE43Zi8rUDFteWhy?=
 =?utf-8?B?cDhQNTVVcG0zQzFtdU5BSzQ1bTRSYVhRaFB6RmttSVM5Y2ozc0VlajVkMWMv?=
 =?utf-8?B?UzF0ekVFcU5FcEVieGFmNmZTcHhBRzNzUGd1akg1MWw5WnlnVmQxNXh6MXZ4?=
 =?utf-8?B?eSsxMXZGRUNqZ09iemlkdk1RTmd2Vk85Q2xmTms4UlVLRmpLM2hEQlJVY2Zo?=
 =?utf-8?B?d01CMThKcGpKTkliWEo5V2pmSFBWa09YZ3pZOVZ5aTJIT0NRU1pNeEY0bkpX?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92D811DD7F58394188FFECF1C89BBD6D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2c85da-a873-42ea-8c48-08dbf72443fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 12:58:53.4501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I5wZeOgbKhWup4cCetL4TvtZihZVtzcoznTi8SneCHFmYdh8OqNB0TgKX20DOaxzqNn0g3A4hjLax0re0vJKaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6942
X-OriginatorOrg: intel.com

DQo+IA0KPiA+IEkgdGhpbmsgd2UgYXJlIGxhY2tpbmcgYmFja2dyb3VuZCBvZiB0aGlzIHVzYWdl
IG1vZGVsIGFuZCBob3cgaXQgd29ya3MuICBGb3INCj4gPiBpbnN0YW5jZSwgdHlwaWNhbGx5IEwy
IGlzIGNyZWF0ZWQgYnkgTDEsIGFuZCBMMSBpcyByZXNwb25zaWJsZSBmb3IgTDIncyBkZXZpY2UN
Cj4gPiBJL08gZW11bGF0aW9uLiAgSSBkb24ndCBxdWl0ZSB1bmRlcnN0YW5kIGhvdyBjb3VsZCBM
MCBlbXVsYXRlIEwyJ3MgZGV2aWNlIEkvTz8NCj4gPiANCj4gPiBDYW4geW91IHByb3ZpZGUgbW9y
ZSBpbmZvcm1hdGlvbj8NCj4gDQo+IExldCdzIGRpZmZlcmVudGlhdGUgYmV0d2VlbiBmYXN0IGFu
ZCBzbG93IEkvTy4gVGhlIHdob2xlIHBvaW50IG9mIHRoZSBwYXJhdmlzb3IgaW4NCj4gTDEgaXMg
dG8gcHJvdmlkZSBkZXZpY2UgZW11bGF0aW9uIGZvciBzbG93IEkvTzogVFBNLCBSVEMsIE5WUkFN
LCBJTy1BUElDLCBzZXJpYWwgcG9ydHMuDQo+IA0KPiBCdXQgZmFzdCBJL08gaXMgZGVzaWduZWQg
dG8gYnlwYXNzIGl0IGFuZCBnbyBzdHJhaWdodCB0byBMMC4gSHlwZXItViB1c2VzIHBhcmF2aXJ0
dWFsDQo+IHZtYnVzIGRldmljZXMgZm9yIGZhc3QgSS9PIChuZXQvYmxvY2spLiBUaGUgdm1idXMg
cHJvdG9jb2wgaGFzIGF3YXJlbmVzcyBvZiBwYWdlIHZpc2liaWxpdHkNCj4gYnVpbHQtaW4gYW5k
IHVzZXMgbmF0aXZlIChHSENJIG9uIFREWCwgR0hDQiBvbiBTTlApIG1lY2hhbmlzbXMgZm9yIG5v
dGlmaWNhdGlvbnMuIFNvIG9uY2UNCj4gZXZlcnl0aGluZyBpcyBzZXQgdXAgKHJpbmdzL2J1ZmZl
cnMgaW4gc3dpb3RsYiksIHRoZSBJL08gZm9yIGZhc3QgZGV2aWNlcyBkb2VzIG5vdA0KPiBpbnZv
bHZlIEwxLiBUaGlzIGlzIG9ubHkgcG9zc2libGUgd2hlbiB0aGUgVk0gbWFuYWdlcyBDLWJpdCBp
dHNlbGYuDQoNClllYWggdGhhdCBtYWtlcyBzZW5zZS4gIFRoYW5rcyBmb3IgdGhlIGluZm8uDQoN
Cj4gDQo+IEkgdGhpbmsgdGhlIHNhbWUgdGhpbmcgY291bGQgd29yayBmb3IgdmlydGlvIGlmIHNv
bWVvbmUgd291bGQgImVubGlnaHRlbiIgdnJpbmcNCj4gbm90aWZpY2F0aW9uIGNhbGxzIChpbnN0
ZWFkIG9mIEkvTyBvciBNTUlPIGluc3RydWN0aW9ucykuDQo+IA0KPiA+IA0KPiA+ID4gDQo+ID4g
PiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFdoYXRzIG1pc3NpbmcgaXMgdGhlIHRkeF9ndWVz
dCBmbGFnIGlzIG5vdCBleHBvc2VkIHRvIHVzZXJzcGFjZSBpbiAvcHJvYy9jcHVpbmZvLA0KPiA+
ID4gPiA+IGFuZCBhcyBhIHJlc3VsdCBkbWVzZyBkb2VzIG5vdCBjdXJyZW50bHkgZGlzcGxheToN
Cj4gPiA+ID4gPiAiTWVtb3J5IEVuY3J5cHRpb24gRmVhdHVyZXMgYWN0aXZlOiBJbnRlbCBURFgi
Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoYXQncyB3aGF0IEkgc2V0IG91dCB0byBjb3JyZWN0
Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gU28gZmFyIEkgc2VlIHRoYXQgeW91IHRyeSB0byBn
ZXQga2VybmVsIHRoaW5rIHRoYXQgaXQgcnVucyBhcyBURFggZ3Vlc3QsDQo+ID4gPiA+ID4gPiBi
dXQgbm90IHJlYWxseS4gVGhpcyBpcyBub3QgdmVyeSBjb252aW5jaW5nIG1vZGVsLg0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gTm8gdGhhdCdzIG5vdCBhY2N1cmF0ZSBhdCBh
bGwuIFRoZSBrZXJuZWwgaXMgcnVubmluZyBhcyBhIFREWCBndWVzdCBzbyBJDQo+ID4gPiA+ID4g
d2FudCB0aGUga2VybmVsIHRvIGtub3cgdGhhdC7CoA0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4g
PiA+ID4gQnV0IGl0IGlzbid0LiAgSXQgcnVucyBvbiBhIGh5cGVydmlzb3Igd2hpY2ggaXMgYSBU
RFggZ3Vlc3QsIGJ1dCB0aGlzIGRvZXNuJ3QNCj4gPiA+ID4gbWFrZSBpdHNlbGYgYSBURFggZ3Vl
c3QuPiANCj4gPiA+IA0KPiA+ID4gVGhhdCBkZXBlbmRzIG9uIHlvdXIgZGVmaW5pdGlvbiBvZiAi
VERYIGd1ZXN0Ii4gVGhlIFREWCAxLjUgVEQgcGFydGl0aW9uaW5nIHNwZWMNCj4gPiA+IHRhbGtz
IG9mIFREWC1lbmxpZ2h0ZW5lZCBMMSBWTU0sIChvcHRpb25hbGx5KSBURFgtZW5saWdodGVuZWQg
TDIgVk0gYW5kIFVubW9kaWZpZWQNCj4gPiA+IExlZ2FjeSBMMiBWTS4gSGVyZSB3ZSdyZSBkZWFs
aW5nIHdpdGggYSBURFgtZW5saWdodGVuZWQgTDIgVk0uDQo+ID4gPiANCj4gPiA+IElmIGEgZ3Vl
c3QgcnVucyBpbnNpZGUgYW4gSW50ZWwgVERYIHByb3RlY3RlZCBURCwgaXMgYXdhcmUgb2YgbWVt
b3J5IGVuY3J5cHRpb24gYW5kDQo+ID4gPiBpc3N1ZXMgVERWTUNBTExzIC0gdG8gbWUgdGhhdCBt
YWtlcyBpdCBhIFREWCBndWVzdC4NCj4gPiANCj4gPiBUaGUgdGhpbmcgSSBkb24ndCBxdWl0ZSB1
bmRlcnN0YW5kIGlzIHdoYXQgZW5saWdodGVubWVudChzKSByZXF1aXJlcyBMMiB0byBpc3N1ZQ0K
PiA+IFREVk1DQUxMIGFuZCBrbm93ICJlbmNyeXB0aW9uIGJpdCIuDQo+ID4gDQo+ID4gVGhlIHJl
YXNvbiB0aGF0IEkgY2FuIHRoaW5rIG9mIGlzOg0KPiA+IA0KPiA+IElmIGRldmljZSBJL08gZW11
bGF0aW9uIG9mIEwyIGlzIGRvbmUgYnkgTDAgdGhlbiBJIGd1ZXNzIGl0J3MgcmVhc29uYWJsZSB0
byBtYWtlDQo+ID4gTDIgYXdhcmUgb2YgdGhlICJlbmNyeXB0aW9uIGJpdCIgYmVjYXVzZSBMMCBj
YW4gb25seSB3cml0ZSBlbXVsYXRlZCBkYXRhIHRvDQo+ID4gc2hhcmVkIGJ1ZmZlci4gIFRoZSBz
aGFyZWQgYnVmZmVyIG11c3QgYmUgaW5pdGlhbGx5IGNvbnZlcnRlZCBieSB0aGUgTDIgYnkgdXNp
bmcNCj4gPiBNQVBfR1BBIFREVk1DQUxMIHRvIEwwICh0byB6YXAgcHJpdmF0ZSBwYWdlcyBpbiBT
LUVQVCBldGMpLCBhbmQgTDIgbmVlZHMgdG8ga25vdw0KPiA+IHRoZSAiZW5jcnlwdGlvbiBiaXQi
IHRvIHNldCB1cCBpdHMgcGFnZSB0YWJsZSBwcm9wZXJseS4gIEwxIG11c3QgYmUgYXdhcmUgb2YN
Cj4gPiBzdWNoIHByaXZhdGUgPC0+IHNoYXJlZCBjb252ZXJzaW9uIHRvbyB0byBzZXR1cCBwYWdl
IHRhYmxlIHByb3Blcmx5IHNvIEwxIG11c3QNCj4gPiBhbHNvIGJlIG5vdGlmaWVkLg0KPiANCj4g
WW91ciBkZXNjcmlwdGlvbiBpcyBjb3JyZWN0LCBleGNlcHQgdGhhdCBMMiB1c2VzIGEgaHlwZXJj
YWxsIChodl9tYXJrX2dwYV92aXNpYmlsaXR5KCkpDQo+IHRvIG5vdGlmeSBMMSBhbmQgTDEgaXNz
dWVzIHRoZSBNQVBfR1BBIFREVk1DQUxMIHRvIEwwLg0KDQpJbiBURFggcGFydGl0aW9uaW5nIElJ
VUMgTDEgYW5kIEwyIHVzZSBkaWZmZXJlbnQgc2VjdXJlLUVQVCBwYWdlIHRhYmxlIHdoZW4NCm1h
cHBpbmcgR1BBIG9mIEwxIGFuZCBMMi4gIFRoZXJlZm9yZSBJSVVDIGVudHJpZXMgb2YgYm90aCBz
ZWN1cmUtRVBUIHRhYmxlIHdoaWNoDQptYXAgdG8gdGhlICJ0byBiZSBjb252ZXJ0ZWQgcGFnZSIg
bmVlZCB0byBiZSB6YXBwZWQuIMKgDQoNCkkgYW0gbm90IGVudGlyZWx5IHN1cmUgd2hldGhlciB1
c2luZyBodl9tYXJrX2dwYV92aXNpYmlsaXR5KCkgaXMgc3VmZmljZT8gIEFzIGlmDQp0aGUgTUFQ
X0dQQSB3YXMgZnJvbSBMMSB0aGVuIEkgYW0gbm90IHN1cmUgTDAgaXMgZWFzeSB0byB6YXAgc2Vj
dXJlLUVQVCBlbnRyeQ0KZm9yIEwyLg0KDQpCdXQgYW55d2F5IHRoZXNlIGFyZSBkZXRhaWxzIHBy
b2JhYmx5IHdlIGRvbid0IG5lZWQgdG8gY29uc2lkZXIuDQoNCj4gDQo+IEMtYml0IGF3YXJlbmVz
cyBpcyBuZWNlc3NhcnkgdG8gc2V0dXAgdGhlIHdob2xlIHN3aW90bGIgcG9vbCB0byBiZSBob3N0
IHZpc2libGUgZm9yDQo+IERNQS4NCg0KQWdyZWVkLg0KDQo+IA0KPiA+IA0KPiA+IFRoZSBjb25j
ZXJuIEkgYW0gaGF2aW5nIGlzIHdoZXRoZXIgdGhlcmUncyBvdGhlciB1c2FnZSBtb2RlbChzKSB0
aGF0IHdlIG5lZWQgdG8NCj4gPiBjb25zaWRlci4gIEZvciBpbnN0YW5jZSwgcnVubmluZyBib3Ro
IHVubW9kaWZpZWQgTDIgYW5kIGVubGlnaHRlbmVkIEwyLiAgT3Igc29tZQ0KPiA+IEwyIG9ubHkg
bmVlZHMgVERWTUNBTEwgZW5saWdodGVubWVudCBidXQgbm8gImVuY3J5cHRpb24gYml0Ii4NCj4g
PiANCj4gDQo+IFByZXN1bWFibHkgdW5tb2RpZmllZCBMMiBhbmQgZW5saWdodGVuZWQgTDIgYXJl
IGFscmVhZHkgY292ZXJlZCBieSBjdXJyZW50IGNvZGUgYnV0DQo+IHJlcXVpcmUgZXhjZXNzaXZl
IHRyYXBwaW5nIHRvIEwxLg0KPiANCj4gSSBjYW4ndCBzZWUgYSB1c2VjYXNlIGZvciBURFZNQ0FM
THMgYnV0IG5vICJlbmNyeXB0aW9uIGJpdCIuIA0KPiANCj4gPiBJbiBvdGhlciB3b3JkcywgdGhh
dCBzZWVtcyBwcmV0dHkgbXVjaCBMMSBoeXBlcnZpc29yL3BhcmF2aXNvciBpbXBsZW1lbnRhdGlv
bg0KPiA+IHNwZWNpZmljLiAgSSBhbSB3b25kZXJpbmcgd2hldGhlciB3ZSBjYW4gY29tcGxldGVs
eSBoaWRlIHRoZSBlbmxpZ2h0ZW5tZW50KHMpDQo+ID4gbG9naWMgdG8gaHlwZXJ2aXNvci9wYXJh
dmlzb3Igc3BlY2lmaWMgY29kZSBidXQgbm90IGdlbmVyaWNhbGx5IG1hcmsgTDIgYXMgVERYDQo+
ID4gZ3Vlc3QgYnV0IHN0aWxsIG5lZWQgdG8gZGlzYWJsZSBURENBTEwgc29ydCBvZiB0aGluZ3Mu
DQo+IA0KPiBUaGF0J3MgaG93IGl0IGN1cnJlbnRseSB3b3JrcyAtIGFsbCB0aGUgZW5saWdodGVu
bWVudHMgYXJlIGluIGh5cGVydmlzb3IvcGFyYXZpc29yDQo+IHNwZWNpZmljIGNvZGUgaW4gYXJj
aC94ODYvaHlwZXJ2IGFuZCBkcml2ZXJzL2h2IGFuZCB0aGUgdm0gaXMgbm90IG1hcmtlZCB3aXRo
DQo+IFg4Nl9GRUFUVVJFX1REWF9HVUVTVC4NCg0KQW5kIEkgYmVsaWV2ZSB0aGVyZSdzIGEgcmVh
c29uIHRoYXQgdGhlIFZNIGlzIG5vdCBtYXJrZWQgYXMgVERYIGd1ZXN0Lg0KDQo+IA0KPiBCdXQg
d2l0aG91dCBYODZfRkVBVFVSRV9URFhfR1VFU1QgdXNlcnNwYWNlIGhhcyBubyB1bmlmaWVkIHdh
eSB0byBkaXNjb3ZlciB0aGF0IGFuDQo+IGVudmlyb25tZW50IGlzIHByb3RlY3RlZCBieSBURFgg
YW5kIGFsc28gdGhlIFZNIGdldHMgY2xhc3NpZmllZCBhcyAiQU1EIFNFViIgaW4gZG1lc2cuDQo+
IFRoaXMgaXMgZHVlIHRvIENDX0FUVFJfR1VFU1RfTUVNX0VOQ1JZUFQgYmVpbmcgc2V0IGJ1dCBY
ODZfRkVBVFVSRV9URFhfR1VFU1Qgbm90Lg0KDQpDYW4geW91IHByb3ZpZGUgbW9yZSBpbmZvcm1h
dGlvbiBhYm91dCB3aGF0IGRvZXMgX3VzZXJzcGFjZV8gZG8gaGVyZT8NCg0KV2hhdCdzIHRoZSBk
aWZmZXJlbmNlIGlmIGl0IHNlZXMgYSBURFggZ3Vlc3Qgb3IgYSBub3JtYWwgbm9uLWNvY28gZ3Vl
c3QgaW4NCi9wcm9jL2NwdWluZm8/DQoNCkxvb2tzIHRoZSB3aG9sZSBwdXJwb3NlIG9mIHRoaXMg
c2VyaWVzIGlzIHRvIG1ha2UgdXNlcnNwYWNlIGhhcHB5IGJ5IGFkdmVydGlzaW5nDQpURFggZ3Vl
c3QgdG8gL3Byb2MvY3B1aW5mby4gIEJ1dCBpZiB3ZSBkbyB0aGF0IHdlIHdpbGwgaGF2ZSBiYWQg
c2lkZS1lZmZlY3QgaW4NCnRoZSBrZXJuZWwgc28gdGhhdCB3ZSBuZWVkIHRvIGRvIHRoaW5ncyBp
biB5b3VyIHBhdGNoIDIvMy4NCg0KVGhhdCBkb2Vzbid0IHNlZW0gdmVyeSBjb252aW5jaW5nLiAg
SXMgdGhlcmUgYW55IG90aGVyIHdheSB0aGF0IHVzZXJzcGFjZSBjYW4NCnV0aWxpemUsIGUuZy4s
IGFueSBIViBoeXBlcnZpc29yL3BhcmF2aXNvciBzcGVjaWZpYyBhdHRyaWJ1dGVzIHRoYXQgYXJl
IGV4cG9zZWQNCnRvIHVzZXJzcGFjZT8NCg0K

