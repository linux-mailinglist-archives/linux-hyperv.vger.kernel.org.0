Return-Path: <linux-hyperv+bounces-5-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AC579334E
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Sep 2023 03:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF681C20959
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Sep 2023 01:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FC3634;
	Wed,  6 Sep 2023 01:19:57 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D13F62B
	for <linux-hyperv@vger.kernel.org>; Wed,  6 Sep 2023 01:19:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E593FCDE;
	Tue,  5 Sep 2023 18:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693963193; x=1725499193;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=an8uYinAWViIhyTJT/noOLC4foQ62WqXOmWr7NhPSCg=;
  b=G/76sDZPww+P5ERJP3/FZnaj9x/zJg/5KCRkxMDz+9NdUlULXR0wrbmE
   KaNI0B67en6bPUMzJJ0Zctv96I34Lqa3cndLqUfz4aJ5YpBqRghvvUtXi
   8MwtVcsfUFFc840U5RZDZGKlED5mG14qQ7nUi6RCNogV7I0VA1b6r69AW
   mcQAn+rxxGlmzucNfnoc/DNW2FaF6S1WxMeWoIgpciaKphsiBIJ2Fwbgp
   gvnbYnJIfM/Tge58chm73Eh4HfapqzhUFwcbLdC8am45WQg78AvA3UHQZ
   2879ZemfDSgx3+fXkUvtull/5DFCvFYEhDHe0PqNykfWbagsUyzJWrCQi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="443334751"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="443334751"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 18:19:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="776391061"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="776391061"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 18:19:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 18:19:50 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 18:19:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 18:19:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 18:19:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekVcXSI+A9ebMaQ1TgBLwKSc690wJLejZVenSiUJH4Hi+bbmTNuTxcsxWIGKc/JyBt15TAoSoSJTTIvyAgSJWqbx4NOa9qxFJummc1J7Manzasx0VsvT8VRPXWD+JAP6ZB571mUCKnoXTrPXd8yE7hgd0fw1xMuF3rAE7+GeVyIhoxSJURrYbXCimMy2sjUQc+uamYbsVsDL+77+Y57q6ENvBNv5wRtx7AYpBLjUjlKXCT28PRS2eys2MKsNgKfQ9tFyH4NGVdeW//jR43+hjbg+Jl5FgqY298kUZap/Mu75KtdIB4NoSG89w7pon09sCpgKL+0FrOE7abnCNYT6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=an8uYinAWViIhyTJT/noOLC4foQ62WqXOmWr7NhPSCg=;
 b=jyhquWSxri6yVQdc213KJRBy6PHRX9LuiDrUp8XiDUnY5GjOaWOSRdJstwf3yM3MkpMwBaBOjuSywko1e0EguxuwDo9b3ikdE5QErJCfBHkXrsBURJUhn9jT+9tDKmNQG3v3kDTRFJOpKqnRknle6ixHwIPNchA99PrpkqOhdz3keTmskxyY66riSAgltyolTqNiMSDVQpHzvnda7I5f9inyuEwrXmQkIfnvvyWXR1IkpVoymc/NyKEVg9R0jYRrAopvG8dDONEvfWxLeAC6rq6qZKNnOS9nq4O/qs/sXcRKVmkgV4mrCUGBEQafVwBEVEpT7evZXW0Xgex9iGkNGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW5PR11MB5860.namprd11.prod.outlook.com (2603:10b6:303:19f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 01:19:47 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 01:19:46 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Jason@zx2c4.com" <Jason@zx2c4.com>, "Lutomirski, Andy" <luto@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "Hansen, Dave"
	<dave.hansen@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "ak@linux.intel.com" <ak@linux.intel.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "kys@microsoft.com" <kys@microsoft.com>, "Cui, Dexuan"
	<decui@microsoft.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "mikelley@microsoft.com"
	<mikelley@microsoft.com>, "chu, jane" <jane.chu@oracle.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"Luck, Tony" <tony.luck@intel.com>, "Christopherson,, Sean"
	<seanjc@google.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "brijesh.singh@amd.com"
	<brijesh.singh@amd.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "mheslin@redhat.com" <mheslin@redhat.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "Tianyu.Lan@microsoft.com"
	<Tianyu.Lan@microsoft.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "andavis@redhat.com" <andavis@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH v10 1/2] x86/tdx: Retry partially-completed page
 conversion hypercalls
Thread-Topic: [PATCH v10 1/2] x86/tdx: Retry partially-completed page
 conversion hypercalls
Thread-Index: AQHZzJ3AAFJQ5AOcC026wSOVTlBOabANJzWA
Date: Wed, 6 Sep 2023 01:19:46 +0000
Message-ID: <cb3de236547eefd48f5ea098dfa72a45373257ab.camel@intel.com>
References: <20230811214826.9609-1-decui@microsoft.com>
	 <20230811214826.9609-2-decui@microsoft.com>
In-Reply-To: <20230811214826.9609-2-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MW5PR11MB5860:EE_
x-ms-office365-filtering-correlation-id: 8d0ce26c-fb12-4561-ff07-08dbae775be9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pdl7C1eNLsUtJ6uvdtsDdFDNBCD8bs8MakeEFtzg/ya0GaZH1R04B0JEQW+foPuADHEEZBRUckjbx1k4GlkERi0E6zq3xZ86yYSxjWJrdLdi85IpUUKIHqMYgWh+TlVUJjKt8ktSnBzc0DepLMrHboTy845Ix4KZKOB0FCADdCC4BbWI/Z3svS1KOer/E/aRgBtsryEM47qZJnASKisE4FNWV7TM1UxwaVjQ6hpuODW4caYh6Zed2d94TStppxGNBmBnw6ouk9NwrvtGICK5o9YXhgFN0eZ1y9PGpJTM+/LEAyMFHbWYAMk6uNbE6sQAif59hOrKv1Ivu7rsX354DMX6rRu0A+aNtzPTMNis+F2PkwVv4Ae/1GPEGqXC9NeK8wOjWiyC0ZiJpmefrXfYb+aVNY+8backCajm+zOZW0fs9IPlXRpPbkQqI5zPo3HbbJ0w+W+hqyRHBOkq3QM0LH0AHUGzQG6P7snr5haCaHTL2JAoGF0d7BgutvHksoDzucCKsNwaDohCx7CPHAzgHTFSDgzYuwsle6YIwOI8UTekNWR8pejzC6UjqciTipRL8PT2B99syM6ZGrQTD5HyQbZznnL5ygK14AdAkMZ430WeS6OpkGQ364izDSrWjkGqueHrgPDO1OsGABzUT97l1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199024)(186009)(1800799009)(41300700001)(36756003)(8676002)(4326008)(8936002)(86362001)(38100700002)(38070700005)(110136005)(122000001)(91956017)(66446008)(54906003)(64756008)(66946007)(76116006)(66476007)(66556008)(316002)(7416002)(921005)(5660300002)(82960400001)(478600001)(71200400001)(2906002)(6512007)(6506007)(6486002)(66899024)(2616005)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2VtVGR0d3RQZkdXQSs0TWtNSkxLekFldjgxczM2M1Vib3RyanAzUHZjRnBE?=
 =?utf-8?B?U3VDaGFFcllzZExjM3dJUnZCdmJwd3NBdmVxaWJMditjb3BvNWd1c2JHaGIr?=
 =?utf-8?B?aGYwWHl4NEF4TTlnaWRPR1N1SDRBV3RBVzBQb0l6ZU12ZGd1WTBxWFdyR280?=
 =?utf-8?B?cUpVNXBtWE9ibGtJRlE2d0F3Z0dtMWU0RDZjM1EvR2MxYXI1WjlSV0huaXdR?=
 =?utf-8?B?dGpHL294VjFzTW1TYlNISU45dHhqZkVpMUkxdnd4cWhXVTBubi8wQ0ZIaGVm?=
 =?utf-8?B?S0N1UmthSlVVTlhwNEZJSCtvSjNva2tneUNEaGVySjdNU1ZMZDZ3RTZOZjBI?=
 =?utf-8?B?ZlJ1WnhmdHcrZ3p6ZEhId0phSVZsOVJ0dVRRVEpSQjUxUlRXbEpUYmFuUFJS?=
 =?utf-8?B?ZUljYU9nSFNjc081T1VNUElLMExabEV3M21lWGV2NEgyaTdOaCtiSWxJb2NX?=
 =?utf-8?B?WUU5eWpIcVRxTDB2N1ZVN2ZiWVBRN2lUdjB1WG9UbWxJYzJKRDJmRnd6NEZL?=
 =?utf-8?B?ZU5RSTJGOFBaRTd3bGxyeFNDS2NGVUxMVmcweDk0dGpUVllCcU1JOUgxQ3BZ?=
 =?utf-8?B?SnltcUtONXZkMHJ3UlB4V1AzVytFWk5VSzg5L0RQNXYwNW5MTVV4dFB1U0lp?=
 =?utf-8?B?K21FS1ZsY3d6QTZwbHIvamJSd2E1Mk81b1ErcG9lZldvSHhqMXVEM2VRUXpp?=
 =?utf-8?B?aDNZbnpZeksyNWVULzJlNWFpSE1FOSt4VEVlZUVjSzBVdmlvKytBK2pPTkVr?=
 =?utf-8?B?cFR6bHNnallTZUFMYnhFN2NTbkVCbitZOGtoZTZmcC9VSU5weWszN0paRUlp?=
 =?utf-8?B?cUVhaVFNV3J0WkFmRlVjam9mcVZSUFFEU2ltL3FhSS94N0RKMkdxc0tzbzVY?=
 =?utf-8?B?QWp2OWtIL3pxaUtPZDJjSi9FVEFPb0FST1RZdGY5VlYvY0NVWE5yZTcraXNI?=
 =?utf-8?B?YW9OUFZPMTdFc0srTFY5WGo4TnNBTGpDQWV2TnRQcU1KMXJVYUdXTGtBNXk1?=
 =?utf-8?B?SDd5NHVVbFgyVzd0K1A3L1ZzVzB1V0hjd3NiOWN5ME41KzY1Y0Fob21CNEw3?=
 =?utf-8?B?elJpdVo0QVFJandFOHhvNTBnRkY1ZjZFOUxYVTdpOXRKTEVjT2pmMll0ZWZE?=
 =?utf-8?B?QXVBMFhtN3BYT1VXYXhjZDBWUkl6UUEyMGp0ZDJqUlpUb2JwTmdZb1N2QnFS?=
 =?utf-8?B?NkI2TTgvcDVpajlRcG5sYkdmelByS254SGdJZ1dNNEFTQ2FCNnZzUklvNHZZ?=
 =?utf-8?B?T0orWjVHNno1YldDQm9TeS9seGFac0hyU040N2lCdjg4Tnc5SkR1eGhkaWg5?=
 =?utf-8?B?eUd5K2FvQVlTTTNJKzNhejlobmo2VzJaUjVsSnFrbGZzd0JnYzFjb0hXRkMv?=
 =?utf-8?B?dEMyY3lMMFIxZFRKU0tGYk9pR2FTUDlaMDgyczR0Z1laQlpHN25ua2dKbS8x?=
 =?utf-8?B?bExveHB6OXM1c3ROYWljU2xTTEExdW56VExBdXBjWEhkWDNnZWVJS2pMUlZL?=
 =?utf-8?B?b3JTT3B6aVVnSXFtK1VlYjk3Ykh6MjhRZ2NranRjb1ZYZHhMejBycXYyb3Q0?=
 =?utf-8?B?TW1qVDVnQUptZGY0clFLQ3B3RXIwUU9uKzJqSUJHVWlBbGZ3S2xRZGI0YjFX?=
 =?utf-8?B?K0tXQkFyRmU2bytzMnVjZmRwUDl0eWlGNWFkNWNCZU4xUGNmdHRTMVhMekJV?=
 =?utf-8?B?K0F2T0wzOUFISFZ3eGJFcmRBU2E4QmRZU1F5ZGMvU1ZzMjc0RFBRQVEwTjIz?=
 =?utf-8?B?Y0t6UFJCb1NIcTdtYTE2WTJTcytrVm12TUc4L1I3UVFleHFhQndYZlNXN2Er?=
 =?utf-8?B?K1N1b29OVkhYbGNwQTRjSVFzLzNZNWhYSEdabzliQkloUVhUb3dtbkdJY3Iw?=
 =?utf-8?B?S2thbmNPNDA4V0lxL0hkMlZvLzNJUG55Q0lPS043dWFQTXpHMEtzSjNDM3lM?=
 =?utf-8?B?ZCtEejJyNnBnendBNnVMU1R5SVNmK0R6UXREQ2lsejZMSnE3Ti9tU1VSOGRr?=
 =?utf-8?B?KzJqTDV5eVpqYlZhdFhJVFVOZnliTTVuSEp6L1lOY2RIajMwRDJYbW1PNHFT?=
 =?utf-8?B?THgwaVZZN0FTcVdMWXFsZEprdytZSURXNHAvRzZDSlUxSmdEZjlYM2NXdDhI?=
 =?utf-8?Q?US3TGWvamu6yuliIlCw56cT7r?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C67D1A2A8A3784C998C3A1E63F6873A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0ce26c-fb12-4561-ff07-08dbae775be9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 01:19:46.9195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ck3rz4RWcKjOIvYU/L12Gm4qJptDlfbZgXJy/R05AxJKlOclQoV4xnzLOJge5brTgrOMQJI1qzm2RJQK7wlKfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5860
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gRnJpLCAyMDIzLTA4LTExIGF0IDE0OjQ4IC0wNzAwLCBEZXh1YW4gQ3VpIHdyb3RlOg0KPiBU
RFggZ3Vlc3QgbWVtb3J5IGlzIHByaXZhdGUgYnkgZGVmYXVsdCBhbmQgdGhlIFZNTSBtYXkgbm90
IGFjY2VzcyBpdC4NCj4gSG93ZXZlciwgaW4gY2FzZXMgd2hlcmUgdGhlIGd1ZXN0IG5lZWRzIHRv
IHNoYXJlIGRhdGEgd2l0aCB0aGUgVk1NLA0KPiB0aGUgZ3Vlc3QgYW5kIHRoZSBWTU0gY2FuIGNv
b3JkaW5hdGUgdG8gbWFrZSBtZW1vcnkgc2hhcmVkIGJldHdlZW4NCj4gdGhlbS4NCj4gDQo+IFRo
ZSBndWVzdCBzaWRlIG9mIHRoaXMgcHJvdG9jb2wgaW5jbHVkZXMgdGhlICJNYXBHUEEiIGh5cGVy
Y2FsbC4gIFRoaXMNCj4gY2FsbCB0YWtlcyBhIGd1ZXN0IHBoeXNpY2FsIGFkZHJlc3MgcmFuZ2Uu
ICBUaGUgaHlwZXJjYWxsIHNwZWMgKGFrYS4NCj4gdGhlIEdIQ0kpIHNheXMgdGhhdCB0aGUgTWFw
R1BBIGNhbGwgaXMgYWxsb3dlZCB0byByZXR1cm4gcGFydGlhbA0KPiBwcm9ncmVzcyBpbiBtYXBw
aW5nIHRoaXMgcmFuZ2UgYW5kIGluZGljYXRlIHRoYXQgZmFjdCB3aXRoIGEgc3BlY2lhbA0KPiBl
cnJvciBjb2RlLiAgQSBndWVzdCB0aGF0IHNlZXMgc3VjaCBwYXJ0aWFsIHByb2dyZXNzIGlzIGV4
cGVjdGVkIHRvDQo+IHJldHJ5IHRoZSBvcGVyYXRpb24gZm9yIHRoZSBwb3J0aW9uIG9mIHRoZSBh
ZGRyZXNzIHJhbmdlIHRoYXQgd2FzIG5vdA0KPiBjb21wbGV0ZWQuDQo+IA0KPiBIeXBlci1WIGRv
ZXMgdGhpcyBwYXJ0aWFsIGNvbXBsZXRpb24gZGFuY2Ugd2hlbiBzZXRfbWVtb3J5X2RlY3J5cHRl
ZCgpDQo+IGlzIGNhbGxlZCB0byAiZGVjcnlwdCIgc3dpb3RsYiBib3VuY2UgYnVmZmVycyB0aGF0
IGNhbiBiZSB1cCB0byAxR0INCj4gaW4gc2l6ZS4gIEl0IGlzIGV2aWRlbnRseSB0aGUgb25seSBW
TU0gdGhhdCBkb2VzIHRoaXMsIHdoaWNoIGlzIHdoeQ0KPiBub2JvZHkgbm90aWNlZCB0aGlzIHVu
dGlsIG5vdy4NCg0KU29ycnkgZm9yIGxhdGUgY29tbWVudGluZy4NCg0KTml0Og0KDQpJTUhPIHRo
aXMgcGF0Y2ggaXMgZG9pbmcgdHdvIHNlcGFyYXRlIHRoaW5ncyB0b2dldGhlcjoNCg0KMSkgY29u
dmVydCB0ZHhfZW5jX3N0YXR1c19jaGFuZ2VkKCkgdG8gdGR4X21hcF9ncGEoKSB0byB0YWtlIHBo
eXNpY2FsIGFkZHJlc3MuDQoyKSBIYW5kbGUgTWFwR1BBKCkgcmV0cnkNCg0KVGhlIHJlYXNvbiBv
ZiBkb2luZyAxKSwgSUlVQywgaXMgaGlkZGVuIGluIHRoZSBzZWNvbmQgcGF0Y2gsIHRoYXQgaHlw
ZXJ2IGd1ZXN0DQpjb2RlIGlzIHVzaW5nIHZ6YWxsb2MoKS4gIEkuZS4sIGhhbmRsZSBNYXBHUEEo
KSByZXRyeSBkb2Vzbid0IHN0cmljdGx5IHJlcXVpcmUNCnRvIGNoYW5nZSBBUEkgdG8gdGFrZSBQ
QSByYXRoZXIgdGhhbiBWQS4NCg0KU28gdG8gbWUgaXQncyBiZXR0ZXIgdG8gc3BsaXQgdGhpcyBp
bnRvIHR3byBwYXRjaGVzIGFuZCBnaXZlIHByb3Blcmx5DQpqdXN0aWZpY2F0aW9uIHRvIGVhY2gg
b2YgdGhlbS4NCg0KQWxzbywgc2VlIGJlbG93IGZvciB0aGUgcmV0cnkgLi4uDQoNCj4gDQo+IEFj
a2VkLWJ5OiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5j
b20+DQo+IFJldmlld2VkLWJ5OiBNaWNoYWVsIEtlbGxleSA8bWlrZWxsZXlAbWljcm9zb2Z0LmNv
bT4NCj4gUmV2aWV3ZWQtYnk6IEt1cHB1c3dhbXkgU2F0aHlhbmFyYXlhbmFuIDxzYXRoeWFuYXJh
eWFuYW4ua3VwcHVzd2FteUBsaW51eC5pbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IERleHVh
biBDdWkgPGRlY3VpQG1pY3Jvc29mdC5jb20+DQo+IC0tLQ0KPiAgYXJjaC94ODYvY29jby90ZHgv
dGR4LmMgICAgICAgICAgIHwgNjQgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiAg
YXJjaC94ODYvaW5jbHVkZS9hc20vc2hhcmVkL3RkeC5oIHwgIDIgKw0KPiAgMiBmaWxlcyBjaGFu
Z2VkLCA1NCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gDQo+IENoYW5nZXMgaW4g
djEwOg0KPiAgICAgRGF2ZSBraW5kbHkgcmUtd3JvdGUgdGhlIGNoYW5nZWxvZy4gTm8gb3RoZXIg
Y2hhbmdlcy4NCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9jb2NvL3RkeC90ZHguYyBiL2Fy
Y2gveDg2L2NvY28vdGR4L3RkeC5jDQo+IGluZGV4IDFkNmI4NjNjNDJiMDAuLjc0NjA3NWQyMGNk
MmQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2NvY28vdGR4L3RkeC5jDQo+ICsrKyBiL2FyY2gv
eDg2L2NvY28vdGR4L3RkeC5jDQo+IEBAIC03MDMsMTQgKzcwMywxNSBAQCBzdGF0aWMgYm9vbCB0
ZHhfY2FjaGVfZmx1c2hfcmVxdWlyZWQodm9pZCkNCj4gIH0NCj4gIA0KPiAgLyoNCj4gLSAqIElu
Zm9ybSB0aGUgVk1NIG9mIHRoZSBndWVzdCdzIGludGVudCBmb3IgdGhpcyBwaHlzaWNhbCBwYWdl
OiBzaGFyZWQgd2l0aA0KPiAtICogdGhlIFZNTSBvciBwcml2YXRlIHRvIHRoZSBndWVzdC4gIFRo
ZSBWTU0gaXMgZXhwZWN0ZWQgdG8gY2hhbmdlIGl0cyBtYXBwaW5nDQo+IC0gKiBvZiB0aGUgcGFn
ZSBpbiByZXNwb25zZS4NCj4gKyAqIE5vdGlmeSB0aGUgVk1NIGFib3V0IHBhZ2UgbWFwcGluZyBj
b252ZXJzaW9uLiBNb3JlIGluZm8gYWJvdXQgQUJJDQo+ICsgKiBjYW4gYmUgZm91bmQgaW4gVERY
IEd1ZXN0LUhvc3QtQ29tbXVuaWNhdGlvbiBJbnRlcmZhY2UgKEdIQ0kpLA0KPiArICogc2VjdGlv
biAiVERHLlZQLlZNQ0FMTDxNYXBHUEE+Ii4NCj4gICAqLw0KPiAtc3RhdGljIGJvb2wgdGR4X2Vu
Y19zdGF0dXNfY2hhbmdlZCh1bnNpZ25lZCBsb25nIHZhZGRyLCBpbnQgbnVtcGFnZXMsIGJvb2wg
ZW5jKQ0KPiArc3RhdGljIGJvb2wgdGR4X21hcF9ncGEocGh5c19hZGRyX3Qgc3RhcnQsIHBoeXNf
YWRkcl90IGVuZCwgYm9vbCBlbmMpDQo+ICB7DQo+IC0JcGh5c19hZGRyX3Qgc3RhcnQgPSBfX3Bh
KHZhZGRyKTsNCj4gLQlwaHlzX2FkZHJfdCBlbmQgICA9IF9fcGEodmFkZHIgKyBudW1wYWdlcyAq
IFBBR0VfU0laRSk7DQo+ICsJLyogUmV0cnlpbmcgdGhlIGh5cGVyY2FsbCBhIHNlY29uZCB0aW1l
IHNob3VsZCBzdWNjZWVkOyB1c2UgMyBqdXN0IGluIGNhc2UgKi8NCj4gKwljb25zdCBpbnQgbWF4
X3JldHJpZXNfcGVyX3BhZ2UgPSAzOw0KPiArCWludCByZXRyeV9jb3VudCA9IDA7DQoNCi4uLiBJ
IHRyaWVkIHRvIGRpZyB0aGUgZnVsbCBoaXN0b3J5LCBidXQgc29ycnkgaWYgSSBhbSBzdGlsbCBt
aXNzaW5nIHNvbWV0aGluZy4NCg0KVXNpbmcgMyBpcyBmaW5lIGlmICJSZXRyeWluZyB0aGUgaHlw
ZXJjYWxsIGEgc2Vjb25kIHRpbWUgc2hvdWxkIHN1Y2NlZWQiIGlzDQphbHdheXMgdHJ1ZS4gIEkg
YXNzdW1lIHRoaXMgaXMgYmVjYXVzZSBoeXBlclYgaXMgYWJsZSB0byBoYW5kbGUgbGFyZ2UgYW1v
dW50IG9mDQpwYWdlcyBpbiBvbmUgY2FsbD8NCg0KVGhhdCBiZWluZyBzYWlkLCB0aGlzIGlzIHB1
cmVseSBoeXBlcnZpc29yIGltcGxlbWVudGF0aW9uIHNwZWNpZmljLiAgSGVyZSBJSVVDDQpMaW51
eCBpcyB0cnlpbmcgdG8gZGVmaW5lIGEgbm9uLXNwZWMtYmFzZWQgdmFsdWUgdG8gcmV0cnksIHdo
aWNoIGNhbiBoYXBwZW4gdG8NCndvcmsgZm9yIGh5cGVydiAqY3VycmVudCogaW1wbGVtZW50YXRp
b24uICBJIGFtIG5vdCBzdXJlIHdoZXRoZXIgaXQncyBhIGdvb2QNCmlkZWE/ICBGb3IgaW5zdGFu
Y2UsIHdoYXQgaGFwcGVucyBpZiBoeXBlcnYgaXMgY2hhbmdlZCBpbiB0aGUgZnV0dXJlIHRvIHJl
ZHVjZQ0KdGhlIG51bWJlciBvZiBwYWdlcyBpdCBjYW4gaGFuZGxlIGluIG9uZSBjYWxsPw0KDQpJ
cyB0aGVyZSBhbnkgaHlwZXJ2IHNwZWNpZmljYXRpb24gdG8gZGVmaW5lIGhvdyBtYW55IHBhZ2Vz
IGl0IGNhbiBoYW5kbGUgaW4gb25lDQpjYWxsPw0KDQpXaGF0J3MgbW9yZSwgZ2l2ZW4gdGhpcyBm
dW5jdGlvbiBvbmx5IHRha2VzIGEgcmFuZG9tIHJhbmdlIG9mIHBhZ2VzLCBpdCBtYWtlcw0KZXZl
biBtb3JlIHN0cmFuZ2UgdG8gdXNlIGhhcmQtY29kZWQgcmV0cnkgaGVyZS4gIExvb2tzIGEgbW9y
ZSByZWFzb25hYmxlIHdheSBpcw0KdG8gbGV0IHRoZSBjYWxsZXIgd2hvIGtub3dzIGhvdyBtYW55
IHBhZ2VzIGFyZSBnb2luZyB0byBiZSBjb252ZXJ0ZWQsIGFuZA0KKmlkZWFsbHkqLCBhbHNvIGtu
b3dzIHRoZSB3aGljaCBoeXBlcnZpc29yIGlzIHJ1bm5pbmcgdW5kZXJuZWF0aCwgdG8gZGV0ZXJt
aW5lDQpob3cgbWFueSBwYWdlcyB0byBiZSBjb252ZXJ0ZWQgaW4gb25lIGNhbGwuICANCg0KRm9y
IGluc3RhbmNlLCBhbnkgaHlwZXJ2IHNwZWNpZmljIGd1ZXN0IGNvZGUgY2FuIHNhZmVseSBhc3N1
bWUgaHlwZXJ2IGlzIGFibGUgdG8NCmhhbmRsZSBob3cgbWFueSBwYWdlcyB0aHVzIGNhbiBkZXRl
cm1pbmUgaG93IG1hbnkgcGFnZXMgdG8gdHJ5IGluIG9uZSBjYWxsLg0KDQpKdXN0IG15IDJjZW50
cy4gIEFuZCBmZWVsIGZyZWUgdG8gaWdub3JlIGlmIGFsbCBvdGhlcnMgYXJlIGZpbmUgd2l0aCB0
aGUgY3VycmVudA0Kc29sdXRpb24gaW4gdGhpcyBwYXRjaC4NCg0KPiAgDQo+ICAJaWYgKCFlbmMp
IHsNCj4gIAkJLyogU2V0IHRoZSBzaGFyZWQgKGRlY3J5cHRlZCkgYml0czogKi8NCj4gQEAgLTcx
OCwxMiArNzE5LDUxIEBAIHN0YXRpYyBib29sIHRkeF9lbmNfc3RhdHVzX2NoYW5nZWQodW5zaWdu
ZWQgbG9uZyB2YWRkciwgaW50IG51bXBhZ2VzLCBib29sIGVuYykNCj4gIAkJZW5kICAgfD0gY2Nf
bWtkZWMoMCk7DQo+ICAJfQ0KPiAgDQo+IC0JLyoNCj4gLQkgKiBOb3RpZnkgdGhlIFZNTSBhYm91
dCBwYWdlIG1hcHBpbmcgY29udmVyc2lvbi4gTW9yZSBpbmZvIGFib3V0IEFCSQ0KPiAtCSAqIGNh
biBiZSBmb3VuZCBpbiBURFggR3Vlc3QtSG9zdC1Db21tdW5pY2F0aW9uIEludGVyZmFjZSAoR0hD
SSksDQo+IC0JICogc2VjdGlvbiAiVERHLlZQLlZNQ0FMTDxNYXBHUEE+Ig0KPiAtCSAqLw0KPiAt
CWlmIChfdGR4X2h5cGVyY2FsbChURFZNQ0FMTF9NQVBfR1BBLCBzdGFydCwgZW5kIC0gc3RhcnQs
IDAsIDApKQ0KPiArCXdoaWxlIChyZXRyeV9jb3VudCA8IG1heF9yZXRyaWVzX3Blcl9wYWdlKSB7
DQo+ICsJCXN0cnVjdCB0ZHhfaHlwZXJjYWxsX2FyZ3MgYXJncyA9IHsNCj4gKwkJCS5yMTAgPSBU
RFhfSFlQRVJDQUxMX1NUQU5EQVJELA0KPiArCQkJLnIxMSA9IFREVk1DQUxMX01BUF9HUEEsDQo+
ICsJCQkucjEyID0gc3RhcnQsDQo+ICsJCQkucjEzID0gZW5kIC0gc3RhcnQgfTsNCg0KTml0Og0K
DQpJcyBpdCBhIGJldHRlciBzdHlsZSB0byBtb3ZlICd9JyB0byBhIG5ldyBsaW5lPw0KDQo+ICsN
Cj4gKwkJdTY0IG1hcF9mYWlsX3BhZGRyOw0KPiArCQl1NjQgcmV0ID0gX190ZHhfaHlwZXJjYWxs
X3JldCgmYXJncyk7DQoNCk5pdDoNCg0KTG9va3MgcGVvcGxlIHByZWZlcnMgcmV2ZXJzZS1jaHJp
c3RtYXMtdHJlZSBzdHlsZS4gIFBlcmhhcHMgc2VwYXJhdGUgdGhlICdyZXQnIA0KZGVjbGFyYXRp
b24gb3V0Lg0KDQo+ICsNCj4gKwkJaWYgKHJldCAhPSBURFZNQ0FMTF9TVEFUVVNfUkVUUlkpDQo+
ICsJCQlyZXR1cm4gIXJldDsNCj4gKwkJLyoNCj4gKwkJICogVGhlIGd1ZXN0IG11c3QgcmV0cnkg
dGhlIG9wZXJhdGlvbiBmb3IgdGhlIHBhZ2VzIGluIHRoZQ0KPiArCQkgKiByZWdpb24gc3RhcnRp
bmcgYXQgdGhlIEdQQSBzcGVjaWZpZWQgaW4gUjExLiBSMTEgY29tZXMNCj4gKwkJICogZnJvbSB0
aGUgdW50cnVzdGVkIFZNTS4gU2FuaXR5IGNoZWNrIGl0Lg0KPiArCQkgKi8NCj4gKwkJbWFwX2Zh
aWxfcGFkZHIgPSBhcmdzLnIxMTsNCj4gKwkJaWYgKG1hcF9mYWlsX3BhZGRyIDwgc3RhcnQgfHwg
bWFwX2ZhaWxfcGFkZHIgPj0gZW5kKQ0KPiArCQkJcmV0dXJuIGZhbHNlOw0KPiArDQo+ICsJCS8q
ICJDb25zdW1lIiBhIHJldHJ5IHdpdGhvdXQgZm9yd2FyZCBwcm9ncmVzcyAqLw0KPiArCQlpZiAo
bWFwX2ZhaWxfcGFkZHIgPT0gc3RhcnQpIHsNCj4gKwkJCXJldHJ5X2NvdW50Kys7DQo+ICsJCQlj
b250aW51ZTsNCj4gKwkJfQ0KPiArDQo+ICsJCXN0YXJ0ID0gbWFwX2ZhaWxfcGFkZHI7DQo+ICsJ
CXJldHJ5X2NvdW50ID0gMDsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gZmFsc2U7DQo+ICt9DQo+
ICsNCj4gKy8qDQo+ICsgKiBJbmZvcm0gdGhlIFZNTSBvZiB0aGUgZ3Vlc3QncyBpbnRlbnQgZm9y
IHRoaXMgcGh5c2ljYWwgcGFnZTogc2hhcmVkIHdpdGgNCj4gKyAqIHRoZSBWTU0gb3IgcHJpdmF0
ZSB0byB0aGUgZ3Vlc3QuICBUaGUgVk1NIGlzIGV4cGVjdGVkIHRvIGNoYW5nZSBpdHMgbWFwcGlu
Zw0KPiArICogb2YgdGhlIHBhZ2UgaW4gcmVzcG9uc2UuDQo+ICsgKi8NCj4gK3N0YXRpYyBib29s
IHRkeF9lbmNfc3RhdHVzX2NoYW5nZWQodW5zaWduZWQgbG9uZyB2YWRkciwgaW50IG51bXBhZ2Vz
LCBib29sIGVuYykNCj4gK3sNCj4gKwlwaHlzX2FkZHJfdCBzdGFydCA9IF9fcGEodmFkZHIpOw0K
PiArCXBoeXNfYWRkcl90IGVuZCAgID0gX19wYSh2YWRkciArIG51bXBhZ2VzICogUEFHRV9TSVpF
KTsNCj4gKw0KPiArCWlmICghdGR4X21hcF9ncGEoc3RhcnQsIGVuZCwgZW5jKSkNCj4gIAkJcmV0
dXJuIGZhbHNlOw0KPiAgDQo+ICAJLyogc2hhcmVkLT5wcml2YXRlIGNvbnZlcnNpb24gcmVxdWly
ZXMgbWVtb3J5IHRvIGJlIGFjY2VwdGVkIGJlZm9yZSB1c2UgKi8NCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL3NoYXJlZC90ZHguaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3No
YXJlZC90ZHguaA0KPiBpbmRleCA3NTEzYjNiYjY5YjdlLi4yMmVlMjNhM2YyNGE2IDEwMDY0NA0K
PiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zaGFyZWQvdGR4LmgNCj4gKysrIGIvYXJjaC94
ODYvaW5jbHVkZS9hc20vc2hhcmVkL3RkeC5oDQo+IEBAIC0yNCw2ICsyNCw4IEBADQo+ICAjZGVm
aW5lIFREVk1DQUxMX01BUF9HUEEJCTB4MTAwMDENCj4gICNkZWZpbmUgVERWTUNBTExfUkVQT1JU
X0ZBVEFMX0VSUk9SCTB4MTAwMDMNCj4gIA0KPiArI2RlZmluZSBURFZNQ0FMTF9TVEFUVVNfUkVU
UlkJCTENCj4gKw0KPiAgI2lmbmRlZiBfX0FTU0VNQkxZX18NCj4gIA0KPiAgLyoNCg0K

