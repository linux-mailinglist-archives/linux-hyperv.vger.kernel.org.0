Return-Path: <linux-hyperv+bounces-1071-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8540D7FAD5F
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Nov 2023 23:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F72281605
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Nov 2023 22:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D8448CCE;
	Mon, 27 Nov 2023 22:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jKDhSwsA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB943860;
	Mon, 27 Nov 2023 14:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701123681; x=1732659681;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=PvFFZMUMWpS1cUbEOizQIapxmpPioPkKtXRMahC5Tns=;
  b=jKDhSwsAISG7bQC+qQDpqNRJwQjA8Uv8gH1AfxyMXwMjps6DJTanVp83
   AalvODLE9Szsc4ZZ0COeCHyTYQvyplA2ojddQ5jevXxhIkpaUQ3V2/pRw
   Csyl94tjcCGouFkjPgH4HfNQJMOgpNW6w0m8/d3i76SJwG9w2Mx47ZPFZ
   IxHtHMedb5iMq2aiN+XrSwT6m5ri+JYfhLKAnEPCu0ASxbmtGvvMKC0I1
   BTz0FGEVllti3RNQ0ZiVtn6qCZMV2Y8ympAwJfndDoKFSTFcClwJuYMU/
   e1TSItQEeSOulJACKwxixob3EwDXTVjNE8vraJi+TTuWktnkjg46nQUta
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="423951310"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="423951310"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 14:21:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="797372632"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="797372632"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 14:21:20 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 14:21:20 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 14:21:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 14:21:19 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 14:21:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYIjEi3/Ekcre16kMXqdxeWRA8MRT4qYkG3vNb4BjZkqJehC6zGOjGajc3MFDGLcqaA4sUdEmIup2TRa34oUkaaANkm5hCdWq+EC7g544wKAX26gjhcpADQtHmVSQkBB1qRg+ymWCutEDbtsSYZs+YggC4tZb5Kq2oZU+o+/dFPkcuFGg4fwSHNWWqN9w7Ybq23o4F5fUOF6KAOYgU/5me6XE9dE9U7716kTIJD9KhqS0nIAedrbxZsIcG+zAn+wAmRpx9elaA+Gobh3aqvNdY2hOXsD64g/n8DTwCKFSnf0Ksp6csdScJ1MqmlX5SZKxVWQXXJssODDbva9Y7dc3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvFFZMUMWpS1cUbEOizQIapxmpPioPkKtXRMahC5Tns=;
 b=fxv7Fd8Gzo81iQghhmTybQTI7kAjIiyOpBgQ2n1rkHP4UFjgqxTF52n0Z84ru0/aYYPJuM/pCv6Y6TRIq9VGdxLEBc9T39em7A6hXFt+WJsO0I7dgtRkDPv7D7YaQn7WefooXBr2QeMFv+NQjgWKZmc+nNacO5+qixHCHvyHmbO1XAyjFvXa26ZhnaBZ/3Nfru9L82I81knb2T/xUFmfcSiiZ9vVKD/yelhzO+V3eMIgfrKAMNm9i8BntG8SqHpDZ5g2uKAY0CBzrDvTDLSG6Z73hmw+rNgYNcIl8J4xABZTbbuAb8Jq8yhSW/BM5G+lSLgObEucoEA7SW9l5S+YVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA0PR11MB7401.namprd11.prod.outlook.com (2603:10b6:208:433::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 22:21:08 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9%6]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 22:21:08 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"ardb@kernel.org" <ardb@kernel.org>, "hch@infradead.org" <hch@infradead.org>,
	"Lutomirski, Andy" <luto@kernel.org>, "mhklinux@outlook.com"
	<mhklinux@outlook.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"Cui, Dexuan" <decui@microsoft.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"urezki@gmail.com" <urezki@gmail.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "Rodel, Jorg"
	<jroedel@suse.de>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "lstoakes@gmail.com"
	<lstoakes@gmail.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 2/8] x86/mm: Don't do a TLB flush if changing a PTE
 that isn't marked present
Thread-Topic: [PATCH v2 2/8] x86/mm: Don't do a TLB flush if changing a PTE
 that isn't marked present
Thread-Index: AQHaHMCWNBbWuenhyU67ZYpiAy4Q97COxoUA
Date: Mon, 27 Nov 2023 22:21:07 +0000
Message-ID: <4a64d05c80c9c490d291af881a86c3d853160060.camel@intel.com>
References: <20231121212016.1154303-1-mhklinux@outlook.com>
	 <20231121212016.1154303-3-mhklinux@outlook.com>
In-Reply-To: <20231121212016.1154303-3-mhklinux@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA0PR11MB7401:EE_
x-ms-office365-filtering-correlation-id: 7e0ff278-0d3a-4ffe-4334-08dbef97274f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jjHB0EwiA1jCNqQqAvblrwv7+6NjY27bHvDBdGfG5XIndEvjl0JCXuTf7F11aHTFtOqijP5/lSyyqPFrZl+oxU79O+Z/iPwfbzadWexN5OLD/Bpe18/8EV6aRKUCop0ZG7yFSQYWkq97A39vuwsaJBy6SGH5TI6lLde5vT2DhRoe7FzbiL8l97UwyXde7Nv1qpHtM6WVE8o4zUK0dWfVUrkPehvb/dTBwKH940+idazgNbfGYMCmVtDYsYIk3QdZJFkA/C6+J5GAt1QdHJ+N2Me/kG5eeUqRtLTBQsPv5w2kIOdocEX2pCbaErsfj0YyqwE+tiZASm8fCH7/Z+fQTa1IooUrflcv3jo94pn2u3OSs01KkZ8DS0UcNzXrIu4CpM1tHkjsZsh8SBCHeYVXyvdxdXr+urqOwrCQoeC95JcaSaWD9m/GvBO5qx5lBvlD0HM8l2udbSnU0P63AU9skBCaG/XjutY6hp6IBCtc1dOBB6zRbO5bq4rmh97jplzhnknQFoh5ES2UxHSTWNu9cvD3H02wUyg6zIlcNXraDrm9bifaZBw8ZXLe9J9UdTSKq19sRx6uUuvfvUqkBH0H0OcTpgwdCCUzHqfCFa+yK3nhJ3IgkeWQPVvuYlFLIeH1vfA0BN038q4HSHyABGVIdAwk144ZKSn4iGDc0cqOtm4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(2616005)(478600001)(71200400001)(6512007)(6506007)(122000001)(38100700002)(38070700009)(82960400001)(921008)(86362001)(36756003)(2906002)(7416002)(4001150100001)(41300700001)(5660300002)(110136005)(76116006)(316002)(6486002)(91956017)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(8936002)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qlk1YnI4NTllUmVvQzgxOVZ5dFROVGs3ZHFKWmZsZHVHQ3V3Wm4yY3ozUlI0?=
 =?utf-8?B?MFludkdKczdYcXFqc0VyZGgwRkRKU280NTV6a3VPQWhWY1hrOUZzS1Bjb2lN?=
 =?utf-8?B?MlEwbXB1UXIxQWVFdjFZT1dRTUgrMlV2cm1abFU3bnplNnhEVkl3bVAvaXRK?=
 =?utf-8?B?YWdNbThWRThGSW8remFBZDVabUJjUDhMOFQ1eElFbWtPQTlFejVleHk1aC8w?=
 =?utf-8?B?bEtSbnVLMFppYjlIU1ltVlI5Z0NlLzFRd3gwalFicG9JL1p6b3g4cUxuNndh?=
 =?utf-8?B?UVhEazduU1hXb0F3cjV1MzNrSTkwVTBXWlh0Tkl6K2hwRXlsbkZpSXpOTUVV?=
 =?utf-8?B?MThrT0ttNTBRQUhJa2Focm9CbWVUekZETHdoL1BERlQycFZlNmk1TEVkV2lt?=
 =?utf-8?B?c0s2MkFDV2I4NUxJNnFmcjdpYXZ6WFJueVFJSmJpaW13SWxucmhJNDBRN0Iw?=
 =?utf-8?B?RzNFN3dwL05TbHdoRDdSWmpBN2dLUXpaei9ucVJrUWk0RHkyZTFscWdZakZt?=
 =?utf-8?B?dWRzeEFOczFGRzJKY1BWNC9yeTR3SW1XNzd6b0hCdllpNTFQY0RlMVF2TWs1?=
 =?utf-8?B?N2kxbHpzcm5TRXVxdndOZWl6V0lncTZDbXVub2tXVXJuZERXRGZwaDZEbnE3?=
 =?utf-8?B?V3RxdS9PeTZiRTJrckZNTzRqcXVJN2FLYlJtTUJQWkl1ZklIeDBUWjRDRzV3?=
 =?utf-8?B?WFBGejJuRFBqOVVIaWhBaERkR3pYQ0MwRXF5Y2U2TUpaWlNEMkphU3RYMHZY?=
 =?utf-8?B?Q0Z6MFg2YmVOOWtDUzhiVWgyNXNhSmo5MFkzK2NwRHVnQUJnbmFxZnE0M1M5?=
 =?utf-8?B?YWRCei9GUXAvbFE3allLTTl1b0RNTE5UZGxUQ1NCc29INHczMm8xR2ZmZTRm?=
 =?utf-8?B?MXBuN0U2RTRRU0ZCOUdLeVIvVnZzcDRkM3A3ZGdZQ1hhMHNaZUtRZ1ZiZE53?=
 =?utf-8?B?ZzhXNkg5WUtYTkcrRzgyRitUMlBJbVdGaWRaRjZaZHJMSFJaWXpuZVd3TUJN?=
 =?utf-8?B?Q0RrSWdEcGs4aStMcUFJQzhvOHpjVkpqN1RkUGk5MGN6YXNyVEt1d29TMGZ6?=
 =?utf-8?B?REIwRVpScVdETXZsWXRITENyNFM5andocW5yVHd5cmVjS0xqVkYwWXdFUFpE?=
 =?utf-8?B?NVU0d2laSG9PWFBLYlNUUDZSMnBoTGdyemNpU3JKdG5lQ0Z1SGdLM1FZUHo2?=
 =?utf-8?B?aUF3djFuUUFqdWYzYXB5MDhGdm8zU1JPQ0J2eUZUcGhaeXB6NkxHcmZ0azcr?=
 =?utf-8?B?cGUwRzU2SU95SzgyRUhTWUhOMm5OcjZOSU1nUmhjdk9EZFVBNUQ4S3hVVGVz?=
 =?utf-8?B?dW1wY0ZMNU5RMEZwR1k1cnVmdU1MRmNrcHc5ejMxOE9tQVFNZ0xRQStKNUJh?=
 =?utf-8?B?TnN1YitIeW1jWHpzbTVUaHd3QnNxakJiaUQ0R3U4OXNRWkVuSFpCa2Zzb0Rw?=
 =?utf-8?B?QUZHcEVBR3hLMGswY3N1anRkVm5Nbnlra0dQWk94b3VGMUhjYVI4NnBXNXZp?=
 =?utf-8?B?RVB3bnNYaVhuRFJnaTNhMElFMnExNEszMEwwZ0JudW1KZ2VQNHNCY1IvLzdo?=
 =?utf-8?B?OUFqVTNhWmhrUzZRTTk3UnpPcTA2bzYycTlCN3ppSjZnZ0RtNkh0aE4zVDJr?=
 =?utf-8?B?b3RLWk5XR0Y2YmRnMjA0U3hLY1hFdEYzRnpNQWFWOWRFQm9XVWh3MTBrSnVN?=
 =?utf-8?B?TVpSQVRPQnJ6WkFnTkU4d2Q3N2wxYXBSQnlBbFNpbnltWmVrdzk1Yld5TGxn?=
 =?utf-8?B?RkNYL1A2WmtPQjU3Z2JvRmw3ajdJeWRLenBXaTRMbnpnOGRqUkFlSTRIaGhh?=
 =?utf-8?B?MlU0aGJhYmtDVnkrTmg5QkN6endUYndlMzU4MkFMaTFRTzdSZGRjNlFBL2d4?=
 =?utf-8?B?MCt6RmdyMkR3SEJxQmxVZVlaUEVUcTIzdW1iZWZsYzB4Nnp4RWh1NEE4dlJJ?=
 =?utf-8?B?OEFpeVI0ZEdBeFVhUWhQbDhoNjI1SWozbTNYUGZGRldNMFpacG12RG5icmpZ?=
 =?utf-8?B?TlpnZGdrNC9nbGQ5WGc4YzZ5YVMxcmpDYmtEenVQSDI0UWh3N0lHa0U4NkdG?=
 =?utf-8?B?SzI5emdEMytwWCtvV2dxSEpxdzNKU1I5ZytYRU5wMjlETmFJTDhwQ0NqVEhu?=
 =?utf-8?B?eFJPd2dPeGU4RzNpODQvWUhhTnByaXpaaGk1RVhtaFVHRStsNXlya0JiUmdr?=
 =?utf-8?B?V0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A3297CDD6C2BD4396116C00EBDAF786@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0ff278-0d3a-4ffe-4334-08dbef97274f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 22:21:07.9914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rx4cnIO5j2y9K6EAiiqDKaNqXDI94WvuySkGnFTqbJbKXjQvxo1GHzS+vszEIqOBq0DeQAQnfu1X4i9tilYms3NB0TQGX8tUARR1NRSXyOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7401
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDIzLTExLTIxIGF0IDEzOjIwIC0wODAwLCBtaGtlbGxleTU4QGdtYWlsLmNvbSB3
cm90ZToKPiAtLS0gYS9hcmNoL3g4Ni9tbS9wYXQvc2V0X21lbW9yeS5jCj4gKysrIGIvYXJjaC94
ODYvbW0vcGF0L3NldF9tZW1vcnkuYwo+IEBAIC0xNjM2LDcgKzE2MzYsMTAgQEAgc3RhdGljIGlu
dCBfX2NoYW5nZV9wYWdlX2F0dHIoc3RydWN0IGNwYV9kYXRhCj4gKmNwYSwgaW50IHByaW1hcnkp
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGlmIChwdGVfdmFsKG9sZF9wdGUpICE9IHB0ZV92YWwobmV3X3B0ZSkp
IHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzZXRf
cHRlX2F0b21pYyhrcHRlLCBuZXdfcHRlKTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGNwYS0+ZmxhZ3MgfD0gQ1BBX0ZMVVNIVExCOwo+ICsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIElmIG9sZF9wdGUg
aXNuJ3QgcHJlc2VudCwgaXQncyBub3QgaW4gdGhlCj4gVExCICovCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocHRlX3ByZXNlbnQob2xkX3B0ZSkp
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgY3BhLT5mbGFncyB8PSBDUEFfRkxVU0hUTEI7Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB9Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjcGEtPm51
bXBhZ2VzID0gMTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+
IAoKTWFrZXMgc2Vuc2UgdG8gbWUuIFRoZSBQTUQgY2FzZSBjYW4gYmUgaGFuZGxlZCBzaW1pbGFy
bHkgaW4KX19zaG91bGRfc3BsaXRfbGFyZ2VfcGFnZSgpLgoKSSBhbHNvIHRoaW5rIGl0IHNob3Vs
ZCBiZSBtb3JlIHJvYnVzdCBpbiByZWdhcmRzIHRvIHRoZSBjYWNoZSBmbHVzaGluZwpjaGFuZ2Vz
LgoKSWYgY2FsbGVycyBkaWQ6CnNldF9tZW1vcnlfbnAoKQpzZXRfbWVtb3J5X3VjKCkKc2V0X21l
bW9yeV9wKCkKClRoZW4gdGhlIGNhY2hlIGZsdXNoIHdvdWxkIGJlIG1pc3NlZC4gSSBkb24ndCB0
aGluayBhbnlvbmUgaXMsIGJ1dCB3ZQpzaG91bGRuJ3QgaW50cm9kdWNlIGhpZGRlbiB0aGluZ3Mg
bGlrZSB0aGF0LiBNYXliZSBmaXggaXQgbGlrZSB0aGlzOgoKZGlmZiAtLWdpdCBhL2FyY2gveDg2
L21tL3BhdC9zZXRfbWVtb3J5LmMKYi9hcmNoL3g4Ni9tbS9wYXQvc2V0X21lbW9yeS5jCmluZGV4
IGY1MTllNWNhNTQzYi4uMjhmZjUzYTQ0NDdhIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9tbS9wYXQv
c2V0X21lbW9yeS5jCisrKyBiL2FyY2gveDg2L21tL3BhdC9zZXRfbWVtb3J5LmMKQEAgLTE4NTYs
MTEgKzE4NTYsNiBAQCBzdGF0aWMgaW50IGNoYW5nZV9wYWdlX2F0dHJfc2V0X2Nscih1bnNpZ25l
ZApsb25nICphZGRyLCBpbnQgbnVtcGFnZXMsCiAKICAgICAgICByZXQgPSBfX2NoYW5nZV9wYWdl
X2F0dHJfc2V0X2NscigmY3BhLCAxKTsKIAotICAgICAgIC8qCi0gICAgICAgICogQ2hlY2sgd2hl
dGhlciB3ZSByZWFsbHkgY2hhbmdlZCBzb21ldGhpbmc6Ci0gICAgICAgICovCi0gICAgICAgaWYg
KCEoY3BhLmZsYWdzICYgQ1BBX0ZMVVNIVExCKSkKLSAgICAgICAgICAgICAgIGdvdG8gb3V0Owog
CiAgICAgICAgLyoKICAgICAgICAgKiBObyBuZWVkIHRvIGZsdXNoLCB3aGVuIHdlIGRpZCBub3Qg
c2V0IGFueSBvZiB0aGUgY2FjaGluZwpAQCAtMTg2OCw2ICsxODYzLDEyIEBAIHN0YXRpYyBpbnQg
Y2hhbmdlX3BhZ2VfYXR0cl9zZXRfY2xyKHVuc2lnbmVkCmxvbmcgKmFkZHIsIGludCBudW1wYWdl
cywKICAgICAgICAgKi8KICAgICAgICBjYWNoZSA9ICEhcGdwcm90MmNhY2hlbW9kZShtYXNrX3Nl
dCk7CiAKKyAgICAgICAvKgorICAgICAgICAqIENoZWNrIHdoZXRoZXIgd2UgcmVhbGx5IGNoYW5n
ZWQgc29tZXRoaW5nOgorICAgICAgICAqLworICAgICAgIGlmICghKGNwYS5mbGFncyAmIENQQV9G
TFVTSFRMQikgJiYgIWNhY2hlKQorICAgICAgICAgICAgICAgZ290byBvdXQ7CisKICAgICAgICAv
KgogICAgICAgICAqIE9uIGVycm9yOyBmbHVzaCBldmVyeXRoaW5nIHRvIGJlIHN1cmUuCiAgICAg
ICAgICovCgpIbW0sIG1pZ2h0IHdhbnQgdG8gbWFpbnRhaW4gdGhlICJPbiBlcnJvcjsgZmx1c2gg
ZXZlcnl0aGluZyB0byBiZSBzdXJlIgpsb2dpYyBpbiB0aGUgTlAtPlAgY2FzZSBhcyB3ZWxsLgo=

