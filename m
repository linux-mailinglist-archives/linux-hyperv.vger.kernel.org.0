Return-Path: <linux-hyperv+bounces-1442-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DFF82F0E8
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jan 2024 15:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451C51C23526
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jan 2024 14:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD0E1BDEC;
	Tue, 16 Jan 2024 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDdH0v6K"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41A31BF2C;
	Tue, 16 Jan 2024 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705417146; x=1736953146;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
  b=dDdH0v6KV7oJCv83eVx4kGfKpif+/lFGeC6XHdc4NmEAvvdt0LIivWXr
   ms0p2cDnNRuZLQcFoFdyRc8vf0wa9YvMG7QtXj9GI1uO3/pyiNQZrRNO5
   jKiQdn236fHShsUMvyHzc8cutfapaPb2QaaaJqekApfs47GdiAenoJe50
   pUAipeV/PnDn8y/S+LgzC6urLyNA9xdiN3J7xKLg8r2hfCjgzeeY/bSq8
   1Fl7fZTcBT3/UlzHb5NuEZfss9csgqUltayCEuG3+3sKI+fce11IgFUYe
   60CpoY5LAjIEMvLyx3ovdb5vGDmdUJMnGC6CSrxuZ2jokx8PK5UqWHw+c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="464173146"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="464173146"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 06:59:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="25828300"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2024 06:59:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 06:59:03 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jan 2024 06:59:03 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Jan 2024 06:59:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhISl3FG6bpgwmwB64R0CrWwAaN9obdMc5Unp2JxgSWqQw9iOnUixZH61p6TwgGZDPw1vW9bRJdJNHniNC6PhA5+TPLAlXXYHGmGFY2v1NDyA5YuGNd1OMPMySdrh91MYP8VBzlLW7kZJdrKDHrwcss3sOloxphMOqYQgpLw8xLMONaexgLbOfY+gSl0i5k96ySMIalV6ocCQxBwRgnJZ2rn53wI9R0PIj62DgiRMrqe0wpV7wmiOXcoD7kkw765GnMek9nXc342ldNK7TAj2OuhykMFV2cB0qfikeX4I9rNNjF8HIHxgJnpu25ggF77u6tJS1aT0zbtZN1SIdnarQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=TEppIGxEHleMJL6ZmRfNGR2zmKDTqii0diqmO9WSKMEe/Ye6q7q/J/hQdssC02rb6gM8PoOn+iyVHwQyAKPq+dB3O1tYFwBFeIQNp6jp2zPtHPeQE+UFZ/E1SGGCvN5cTzpbCOTwbie3LypkRfCElDxY13YJUwqkFHzigTagKhXF72+kj814FmKWozXFK8JgBSrezaiyVD6iDnmnQ3zTypKys/mAu4j9jViaZ03Pu4I0tp8vK6ElCHS6iY9DBzdut9lpvKcYtFu28MDfQ3d3JGyXRKGCMovZHPdN/9Ojfi/2tbZFHbdZbzr7Ovpg05ZrlFkGDTPiaDMW5qsmiWxIwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by LV2PR11MB6048.namprd11.prod.outlook.com (2603:10b6:408:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 14:59:00 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93%4]) with mapi id 15.20.7181.022; Tue, 16 Jan 2024
 14:59:00 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"ardb@kernel.org" <ardb@kernel.org>, "hch@infradead.org" <hch@infradead.org>,
	"luto@kernel.org" <luto@kernel.org>, "mhklinux@outlook.com"
	<mhklinux@outlook.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "seanjc@google.com"
	<seanjc@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"Cui, Dexuan" <decui@microsoft.com>, "urezki@gmail.com" <urezki@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "Rodel, Jorg"
	<jroedel@suse.de>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "lstoakes@gmail.com"
	<lstoakes@gmail.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 1/3] x86/hyperv: Use slow_virt_to_phys() in page
 transition hypervisor callback
Thread-Topic: [PATCH v4 1/3] x86/hyperv: Use slow_virt_to_phys() in page
 transition hypervisor callback
Thread-Index: AQHaSCKqfz5E/QZ6Ske+YiV7HiXHvLDciMqA
Date: Tue, 16 Jan 2024 14:58:59 +0000
Message-ID: <b2a622dca406c5de2fb884b971372d925d61bf44.camel@intel.com>
References: <20240116022008.1023398-1-mhklinux@outlook.com>
	 <20240116022008.1023398-2-mhklinux@outlook.com>
In-Reply-To: <20240116022008.1023398-2-mhklinux@outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|LV2PR11MB6048:EE_
x-ms-office365-filtering-correlation-id: 0885245f-3a5d-40ec-fabb-08dc16a3abc5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FXzmGDGT0vuHl/LDU4gaxmJkqMqCKnwXYG4CuwheVEOEBXViIw0+h22Pg5CGmmUj8cDyyLV7tskCJUrh5qQLYIUAcuv6r8io4uW1jr9eGaC0w8Fzpj734IDaMwIQfCPB00zNonEtvp+M4SlZdeJPnef7mv8fOU+QOIU1S19VVNus0nEFEhV8PKohO/LLCATqXMUXsNmkDyI7rxYrtcLdJ3nRZwv3N875lt94txFPOcAxTtd/C/aBLCt5ha5Y9d640KP/z57ATlVaEFjEK1z5pay+VQTrXuG++ELLpO4Q0au6E/IAQdl4HQ3oAVu55dJazpfbCHgzEII56HehgeylOgfVcPuVm0/5eyg2c/DaG3+Pn4MWeZr4x9eRkBJvkwni
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(376002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(36756003)(6506007)(6512007)(86362001)(38100700002)(38070700009)(82960400001)(7416002)(621065003)(73894004)(41300700001)(71200400001)(2616005)(122000001)(4270600006)(110136005)(921011)(66556008)(76116006)(66946007)(66476007)(66446008)(64756008)(316002)(91956017)(2906002)(8936002)(8676002)(478600001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?M7ds3tynbK1VJSqru3KbawV5QAJdlR86nhr+nCuc63npYMAuG7UWDkuKxb?=
 =?iso-8859-1?Q?6RBUdW4CEi82/7qEG6qPRo1tIP0UbwhWR/FC1cULS4rE7EAHT83wKMJWGv?=
 =?iso-8859-1?Q?9QviyexCRFhVaOIZvmQWEqDvgcbEq5Cy4bfyUdYA+5lhxw7tr7IlXANXgn?=
 =?iso-8859-1?Q?EFuvjACvQbBK73LdmCzpi0GGu2M3D/0e+Mzkjf9lF4NPDBhfSQvpBS3mBu?=
 =?iso-8859-1?Q?Zh23JbvUGxHog4K86rZiPlhz0PVyrbEWbKy9eXpHJLY8zllMcHID+tj91h?=
 =?iso-8859-1?Q?Ry5Gpa1cXoDSTRPmWGkGXZXGOu37iTKWXoj4y906cWMg0NjrJfpyLs7pai?=
 =?iso-8859-1?Q?9K44yfhnWXzfdOTMK7ANLk9yJH2hSuWLQOweKJkR0WYtG/JfJPyIf6qt2z?=
 =?iso-8859-1?Q?LyZgUlxuXtzKHtUtPk7kpk1MzGzcvupvTKhPpeaHBXoi9+fLcuZSYjtTIN?=
 =?iso-8859-1?Q?t/dsK0t7qpTXCE5vt8QGwf17D2keAOB7k13GgAC57p0UMyupv2lxRwmXhD?=
 =?iso-8859-1?Q?etbbqrxQPUPRo9KAhorcaWLX6GzZklFgsaffStC+TFG80CemLYVB/Logdf?=
 =?iso-8859-1?Q?rKTWLFHAff092Y1RE59qCxTrNSfcfgFWcx471+xNGGy1ZuweM0JtTzDNOX?=
 =?iso-8859-1?Q?yl3h+ywNYMFkWdOanDLpyYVscTI4K/bpFAlywS+bMMUqMjPnoFYmeJNwlI?=
 =?iso-8859-1?Q?/CHG1xQQ+MxSz52EqMnWJsyPI8EPB7Nr7tDGhCCCkJIGazSLAnCjgVx77Q?=
 =?iso-8859-1?Q?pqv6KmaLyhRyruAzByGbRj3Abvr1S0aF5Rrty/qs7qxBsWNPPZgZ399C36?=
 =?iso-8859-1?Q?mDGtdei73H1wvE4440XdFw9d7qTC7mRFvK3jpNC5IyAwlLfRDtXm/Lg9tf?=
 =?iso-8859-1?Q?TKwe0nqomxEAoHSdiuxQeHhrIIj8Um/dT3oxZ/48GmK4rf8tLdjgMIsFmh?=
 =?iso-8859-1?Q?Fz/myWQaLZBHuUYZcVsxQaNSPKqDD9TqsUcGwBiU3UoQKNStXucsFkTHc2?=
 =?iso-8859-1?Q?Gd2g8aTvNYL80/ACfdJC5zEnUMD0RM+XiqQaqwlVbJ/xxg/3Hv+inT5wNk?=
 =?iso-8859-1?Q?y20wl0SEAhMeP/BFP6IclamYHKUA6UdGOTCYsI7uYYd1PDV07YJ/IY0PDE?=
 =?iso-8859-1?Q?2hsELuCHW+CSnNsVB/ohbhP8dtjPg0m0NYqyVAO2NCQ6Pnr3XaOvcH9KBZ?=
 =?iso-8859-1?Q?C3YudovgLIFhKB+3pRkR9ConlayCg9fHF6unv/1ktGsKW8YRYzfJsFyZyL?=
 =?iso-8859-1?Q?oqDFq3dalQhwo5RibXAT4YxmoKw14BsdsCPMrqwxqOoQBhLxqRwm7d5Lni?=
 =?iso-8859-1?Q?7PONd1z5mJB2h7XSAOZlmpDEV/qP7DPsO5+rOAESJItzgcizt6Rr/ek5eU?=
 =?iso-8859-1?Q?+70M4c/0MDjauSpy9gqC/1qGs+9zIMJpDhRM5tiAvhpEXYfbYiPX0tPgUy?=
 =?iso-8859-1?Q?TVYcE0RiZjIOnSR1mXiVb8Q74FhRtrG0DjIA3QqkMXJiyjepmKJS6dYXG8?=
 =?iso-8859-1?Q?qIa7bLif5cLh8h4FfX2zfxd8aW1Kab21xNnE2OjCEGdn1QWxExkrFQBO5x?=
 =?iso-8859-1?Q?kOTA7qSGq5+p09thHV5jJcES+LcMHRMW4bAaEYnbJz12W48cJB75xkqsv7?=
 =?iso-8859-1?Q?PbclK9DFvQfUZ4cLGk1NMLizt/WP1+OCx7yES6b0NPPXlZRiq6b0x3ng?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0885245f-3a5d-40ec-fabb-08dc16a3abc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 14:58:59.6694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kQTRLxrwRJd16fFIGa16TY12XQPX0JEc58NIc8KNWsKzapXV/iNu3mVWy5KiAlTsUZbHlOCeEDQrxpqMrMTRPJ6WHGPF+346UtG8avIyzuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6048
X-OriginatorOrg: intel.com



