Return-Path: <linux-hyperv+bounces-1157-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A0A7FEAA8
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Nov 2023 09:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9251C20E58
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Nov 2023 08:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4035020DE6;
	Thu, 30 Nov 2023 08:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XqLiTY+O"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90B69A;
	Thu, 30 Nov 2023 00:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701333074; x=1732869074;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HJCFF6elBBo8Qml1t28Z7BVTZd2/ktUZPkLr49AXFu8=;
  b=XqLiTY+OGiw+TxNoU+JH8sf6h3Gz87T16qjwo9grEv6f50aKHBfgzk3/
   H3eD9nCz7VevbMTJYWkGOOOtUlAtELnIdOGJ7HIqGKqzSrJ7ga/1smEch
   664yR9K2ajMis+8+V++1JgleSjFeane/h8lRTlhv5jAMTAv+qAAoei4G3
   Nep/35tP5b1kD+gG/S+n4nuhOzGHJJ241aoYIvmgLMc0xwhfkQ/bzT69T
   NqRvfhngAkXIt1ydLlz0/FQ1UU0tnS+j2pjdWUSbjwkDK+fsrb/WsgWsP
   PF/8I+vUH5ED7f6/Us0GB4iV2c0zHDUDYwUlZldFUvauzREhNPWGsvLNI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="188434"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="188434"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 00:31:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="887169535"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="887169535"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 00:31:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 00:31:12 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 00:31:12 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 00:31:12 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 00:31:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emKawW7WGKxuSTPo2ye0VyyliTSmHewBXt9HHrH2FNhLlmmAXn90WWRlAIhuinqIk15Uuv2OYdymQyT1lzHiXt/4t8DZJJth0WWDi17zAI5M42k3Z+0H/URdy8ECHN/zTORdxi3arWBSZqY9mNH+1QF53n//1zfymmhQLc4MLgh3npDdodwTOnQ0YGjuZJzUKJ8IG0xfnCRY4xdOabuT6vyAPPj/fXX8vKX8KB1FwgwPv2MfNCCJYnR56pjONwn1Vtwrw/JuNWB9NIrWxfFPT3BiQOA+h7iRBzdi4ZuKrhjdZoQS2puC6DLJglqTvqO/fX+1u2SORh3daI0zaJj5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJCFF6elBBo8Qml1t28Z7BVTZd2/ktUZPkLr49AXFu8=;
 b=KTFHv6YjiT4/8Yc3aUIy77CZCFwiezh4U8QkPbGySRU+uLMBtzvONSkscnKBORK6iCYzJLnZUbxVS9Sl4HVt7ss9sZCjQHaIphHo6WPmRD1PYbyym6u3UJNL2oFn79ytFNETs0Uzaz9EEBKvvIJP7sOKI1xJ8yoiYCELYQF3toZaS/0PRvHPCc5lgzuAMR1OrgikQSjmEwEckatEuwEW2WCgPFIf2nquaQrBZ1nvcC2FDbLxshlge6bRZN90OxyDlnQQMuiQdQmJD7h4gUU5tTkNLPqF2xSpoiTpSjJ3LTVbQrFvT6/1Y7AljLqd9FnUAudSfzrNyzDHDQL79pWCnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 SJ0PR11MB4912.namprd11.prod.outlook.com (2603:10b6:a03:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.26; Thu, 30 Nov
 2023 08:31:09 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed%3]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 08:31:03 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: Borislav Petkov <bp@alien8.de>, Jeremi Piotrowski
	<jpiotrowski@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"stefan.bader@canonical.com" <stefan.bader@canonical.com>,
	"tim.gardner@canonical.com" <tim.gardner@canonical.com>,
	"roxana.nicolescu@canonical.com" <roxana.nicolescu@canonical.com>,
	"cascardo@canonical.com" <cascardo@canonical.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "sashal@kernel.org"
	<sashal@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, "Ingo
 Molnar" <mingo@redhat.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Michael Kelley <mhkelley58@gmail.com>,
	Nikolay Borisov <nik.borisov@suse.com>, Peter Zijlstra
	<peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tom Lendacky
	<thomas.lendacky@amd.com>, "x86@kernel.org" <x86@kernel.org>, "Cui, Dexuan"
	<decui@microsoft.com>
Subject: RE: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Thread-Topic: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Thread-Index: AQHaHWWtJXruLfiu906BueKp3+5D87CGlUMAgAr1j4CAAOyO0IAAEySAgAAE1MA=
Date: Thu, 30 Nov 2023 08:31:03 +0000
Message-ID: <DM8PR11MB575049E0C9F36001F0F374CEE782A@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <0799b692-4b26-4e00-9cec-fdc4c929ea58@linux.microsoft.com>
 <20231129164049.GVZWdpkVlc8nUvl/jx@fat_crate.local>
 <DM8PR11MB575085570AF48AF4690986EDE782A@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20231130075559.GAZWhAD5ScHoxbbTxL@fat_crate.local>
In-Reply-To: <20231130075559.GAZWhAD5ScHoxbbTxL@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: jpiotrowski@linux.microsoft.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|SJ0PR11MB4912:EE_
x-ms-office365-filtering-correlation-id: fee22175-e49e-44a9-45ea-08dbf17eb0a9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kdNW4fUWGBc/Rm8xZASPli4Yo1NtN1GNV7es+SDBwue1JuPCQ4LYJtUQjgiHEAV/8/pBqw+AxcnkV0Z0rygjQaFzLG37GJLdWfvuw5eBgUTUwnvt4Cjnykt28qLTcdX209UGj3GJkrKFKcAiWCrWmCA2A9FFEDPyZE3X28gd3vYrxEDQTDEicGeXNNHotxMFd71PBOGK1KAjvxzsj5TsGyULgxMdTZuch7jI5HpFWe5Z7NlkEJm0LBs+66H0Tr+SlNJE97nMg7AOiwqppZ0NCm130t+ryMJJY62A8wO9/C/108ER2RxoB5mbIzYYhWKLTe1ULW8Yolq3zmWkI0gWjkfbn6bgYfannKx3/VOmyplZ3gesPFdu6TRS69F4Xak60HJOm9Iddvqa4fb75GlTFyefxcSPhulBXn/Ta0n8afGLdMTXQyPdTmAcYEbvw8riBSsNPoo3q0wuzP17sqvzKO/QOeFJJZEV8gxSBgm/MAWtqApw3N40Nes8P7MfBoUU34HW2RTLCJatrhJ3cNCxZpLWfOI5UmSwktWXdSO4oQ1CJUR/8JmwmB3k8Nk66bA283JGgD9CJvnJ64D6OZI3HJNGhI6mhVr/6WgO/d6VLZLPD6QNi99H3d+/HrDDOJWv1Ph7K/WzhKqDmBswL9yi2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(366004)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(110136005)(66556008)(66446008)(64756008)(76116006)(54906003)(66476007)(66946007)(316002)(478600001)(71200400001)(38070700009)(2906002)(7416002)(5660300002)(966005)(41300700001)(33656002)(52536014)(4326008)(8936002)(86362001)(8676002)(122000001)(55016003)(83380400001)(26005)(82960400001)(202311291699003)(6506007)(38100700002)(7696005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFBEY1Jld0Nqd09MQU9TSUh2eGN4VUJuMVJ2anZ1a1UvaWFGeGNac2djU2hG?=
 =?utf-8?B?cFR3M3RIa3JCeTRlR25UL2h0UlhObUx2enJISEFrcFhqVXBYdlBaSG5udFY2?=
 =?utf-8?B?NlNnVTl5Zk5IYndtU3FBc3ptT0xHN1p2cnROM3ZQTDdNOVE5Qm9tWDZ1WmRB?=
 =?utf-8?B?N1NQMjFDdW5QVG5aR1pwQmUyc0doaHZ2SzlqK0xMY3FTWnFaV3E3Yjh1TVl0?=
 =?utf-8?B?VzRycVBxZkQ1NU1lY1BQM2xvK2FFeEpPMEFZRWFMZC8yV1I5ZVB3N2IvUDNS?=
 =?utf-8?B?aUxxRnY4a2tjWEtwUXdmU2pUYzVPNVlzenk0N1p0YVNUMEQ0OWRsMFZKMG5o?=
 =?utf-8?B?ek52R1ZobTdiTlNFWEIzSlNlSlZVRFphUXlLRDhVK2VjUEIvZE5rMWlhOVFO?=
 =?utf-8?B?dGxCbWpHaXVERHQ4M0x1WjF1bmRUclNadTZ5WlVyWlpVT0tsWUoxUTZkcVpC?=
 =?utf-8?B?WnUxUXlldzV1VC9aNjFaNEh4aHlqd0gzR3JLQlg0WmlaSFpQSG5aY254M3M3?=
 =?utf-8?B?Ulo1bjNqSUkzYlp2UGtHN0xUVi96ZjhzWHVOUUhZTTRXTXlBcjJ5bUIra2dV?=
 =?utf-8?B?YzRTSVB2QjhvOUNiOURjQTJ4WmVIOGRuejlEaEhJc1pFeUtuTHRTSDBxZnpT?=
 =?utf-8?B?SmZCTEdoalF2cGliQ001NGk4aFNEdHIwQW1lUFV1YlgxQ0RRWFpwbElKNk9i?=
 =?utf-8?B?amhBKzNjVTVXM0tVaHYzb0V3eEJYcU11SkxnQVN0aDFOR09GajRKSWthSFBs?=
 =?utf-8?B?WmNYSm1WUStxTFp6RDgvZVZGUUFMc3RMR0RBenBaNVVQblRxdXNBaXVFOXh2?=
 =?utf-8?B?cEFOMHBoM1hra291SW16SE43TUZ1OURCcy9NUjRiakU5bFF1NjF4Qzk3R0Zh?=
 =?utf-8?B?aXpwZUZHanBENWlZMTNiSHNyZm81OVdUZDdhdFNldk5mRGVuUngwTG9WbkNu?=
 =?utf-8?B?b29VdVlWUkxrTG1BeDJLZGdia2FYT2JhU0tudjJpV0dIQkRpT2Q1THpEbzUz?=
 =?utf-8?B?azlNbkFRa0o2UmxjdU1DRTRXVlZsVXBGZllINFlGYkNuUUk3U2VwdTg1L1p1?=
 =?utf-8?B?cDlla0FDT0gxd2ttaGJ4ZHFrRHVXWWtrWDdsbVNBVUJLWG5oakJBSDhxczVW?=
 =?utf-8?B?amNqVGN3THJnSEV5NmptRXlyZEsxTFJFK0tZeHY0WWJxa3pFNHE4TzNYaWFl?=
 =?utf-8?B?ODlqOGJaVXZ3K1cxd1l5aVNiYjVtN2tudllHSWxzYkY1MVV3TmpxRGxodWZP?=
 =?utf-8?B?aFdvWDZYbjlxaDZmODRZWmdPd2ZycFVuQnl2ZzhFcjB1VHJBR0x3QlJNbndB?=
 =?utf-8?B?WVp4eFd1SHM1dVI0UjMwVGdMT00zZVl4RkU2MXpUcW9WNk9yMlhVR2ZNZnpq?=
 =?utf-8?B?dEl4OFBpQzNaSWprRDBtUFJTWGQ0Yktna3lUckRXa1RNa1lOd3VqUENWdXpY?=
 =?utf-8?B?Y2VwWlZ2N2ExL0RzTVpsSjliclFHbTUyN2xjb3FTQ2I5RWtQWmRzd0FGTEpW?=
 =?utf-8?B?RFF4TStjamhJOENLTll4SHFpTm1NL25RTmlRZWVXaHQyNjlrYkh2a1AxRkx5?=
 =?utf-8?B?SGJpR2MzZ0d6clBYSzRxREZ2UUVvNERrZklnd0FkNzdJNlNZeVgyMFdIa1VF?=
 =?utf-8?B?T0JTTHFERGhVb1V6dEFVZTRhT0xFMkxYVzFxcHkxcmgvQXliYm5IK21FdzI0?=
 =?utf-8?B?RDg3M0FTRkQwTFNST3VLWmdxQ2xZUlFVWko3QmNDWlJwZGVzZ3RoTFpEZXcv?=
 =?utf-8?B?b0JKZ1RQL3BlY3NvaGhtUHRaSjI1TUw5ZFJ5cWpMaTdsc3c2K1BPQi9GbXZk?=
 =?utf-8?B?Z1RQUkc4ZDlGZVBZMDZuZWRvaG1jMzlOakpkWW00RXBkSFBlcXo4emNKR0tS?=
 =?utf-8?B?aDExaXMxSHB4cHFnNlVSREJVNTIwN3ZNblRaVUtyM2hyQjNqZkZUNTlHSERV?=
 =?utf-8?B?SVJkZkhkdG1UWjNET0lac0xlRHZMTStHZ3RWRy9mWXNhMysxQ1oxSmRFOG90?=
 =?utf-8?B?WSs1MEEyM2lqQVhCSUxwK3ZkV1NxMVJvSXNDMUx5WmYrOURYUlFYVnV1RUYw?=
 =?utf-8?B?eHNsU2ZVVUt0WnRpREJDZnpWU2UyQ0ZHWkVkTHl3VzNkb3pzbzlaQzBNUllP?=
 =?utf-8?Q?q0TcukdlvpZqL9mlVnexANvnD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fee22175-e49e-44a9-45ea-08dbf17eb0a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 08:31:03.4994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YXZBcN1BZLChBG+dmlY91M66KzS4VPGLGmn5F0+W9EBsHt9DNQQlLN2wcsQNHUI+Fc3VnRlxcekt0hYP/nc3x6XospvLDwTunHwansYOUic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4912
X-OriginatorOrg: intel.com

DQo+IE9uIFRodSwgTm92IDMwLCAyMDIzIGF0IDA3OjA4OjAwQU0gKzAwMDAsIFJlc2hldG92YSwg
RWxlbmEgd3JvdGU6DQo+ID4gLi4uDQo+ID4gMy4gTm9ybWFsIFREWCAxLjAgZ3Vlc3QgdGhhdCBp
cyB1bmF3YXJlIHRoYXQgaXQgcnVucyBpbiBwYXJ0aXRpb25lZA0KPiA+ICAgIGVudmlyb25tZW50
DQo+ID4gNC4gYW5kIHNvIG9uDQo+IA0KPiBUaGVyZSdzIGEgcmVhc29uIEkgY2FsbCBpdCBhIHZp
cnQgem9vLg0KPiANCj4gPiBJIGRvbuKAmXQga25vdyBpZiBBTUQgYXJjaGl0ZWN0dXJlIHdvdWxk
IHN1cHBvcnQgYWxsIHRoaXMgc3BlY3RydW0gb2YNCj4gPiB0aGUgZ3Vlc3RzIHRocm91Z2guDQo+
IA0KPiBJIGhlYXIgdGhyZWF0cy4uLg0KDQpObyB0aHJlYXRzIHdoYXRzb2V2ZXIsIEkganVzdCB0
cnVseSBkb27igJl0IGtub3cgZGV0YWlscyBvZiBTRVYgYXJjaGl0ZWN0dXJlDQpvbiB0aGlzIGFu
ZCBob3cgaXQgZW52aXNpb25lZCB0byBvcGVyYXRlIHVuZGVyIHRoaXMgbmVzdGluZyBzY2VuYXJp
by4NCkkgcmFpc2VkIHRoaXMgcG9pbnQgdG8gc2VlIGlmIHdlIGNhbiBidWlsZCB0aGUgY29tbW9u
IHVuZGVyc3RhbmRpbmcgDQpvbiB0aGlzLiBNeSBwZXJzb25hbCB1bmRlcnN0YW5kaW5nIChwbGVh
c2UgY29ycmVjdCBtZSkgd2FzIHRoYXQgU0VWDQp3b3VsZCBhbHNvIGFsbG93IGRpZmZlcmVudCB0
eXBlcyBvZiBMMiBndWVzdHMsIHNvIEkgdGhpbmsgd2Ugc2hvdWxkIGJlDQphbGlnbmluZyBvbiB0
aGlzLiAgDQoNCj4gDQo+ID4gSW5zdGVhZCB3ZSBzaG91bGQgaGF2ZSBhIGZsZXhpYmxlIHdheSBm
b3IgdGhlIEwyIGd1ZXN0IHRvIGRpc2NvdmVyDQo+ID4gdGhlIHZpcnQgZW52aXJvbm1lbnQgaXQg
cnVucyBpbiAoYXMgbW9kZWxsZWQgYnkgTDEgVk1NKSBhbmQgdGhlDQo+ID4gYmFzZWxpbmUgc2hv
dWxkIG5vdCB0byBhc3N1bWUgaXQgaXMgYSBURFggb3IgU0VWIGd1ZXN0LCBidXQgYXNzdW1lDQo+
ID4gdGhpcyBpcyBzb21lIHNwZWNpYWwgdmlydCBndWVzdCAob3IgbGVnYWN5IGd1ZXN0LCB3aGF0
ZXZlciBhcHByb2FjaA0KPiA+IGlzIGNsZWFuZXIpIGFuZCBleHBvc2UgYWRkaXRpb25hbCBpbnRl
cmZhY2VzIHRvIGl0Lg0KPiANCj4gWW91IGNhbiBkbyBmbGV4aWJsZSBhbGwgeW91IHdhbnQgYnV0
IGFsbCB0aGF0IGd1ZXN0IHpvbyBpcyB1c2luZyB0aGUNCj4ga2VybmVsLiBUaGUgc2FtZSBjb2Rl
IGJhc2Ugd2hpY2ggYm9vdHMgb24gZ2F6aWxsaW9uIGluY2FybmF0aW9ucyBvZiByZWFsDQo+IGhh
cmR3YXJlLiBBbmQgd2UgaGF2ZSB0cm91YmxlIGtlZXBpbmcgdGhhdCBjb2RlIGJhc2UgY2xlYW4g
YWxyZWFkeS4NCg0KRnVsbHkgYWdyZWUsIEkgd2FzbuKAmXQgb2JqZWN0aW5nIHRoaXMuIFdoYXQg
SSB3YXMgb2JqZWN0aW5nIGlzIHRvIG1ha2UNCmV4cGxpY2l0IGFzc3VtcHRpb25zIG9uIHdoYXQg
dGhlIEwyIGd1ZXN0IHVuZGVyIFREWCBwYXJ0aXRpb25pbmcgaXMuIA0KDQo+IA0KPiBOb3csIGFs
bCB0aG9zZSB3ZWlyZCBndWVzdHMgY29tZSBhbG9uZywgdGhleSdyZSBtb3JlIG9yIGxlc3MNCj4g
ImNvbXBhdGlibGUiIGJ1dCBub3QgZnVsbHkuIFNvIHRoZXkgaGF2ZSB0byBkbyBhbiBleGNlcHRp
b24gaGVyZSwNCj4gZGlzYWJsZSBzb21lIGZlYXR1cmUgdGhlcmUgd2hpY2ggdGhleSBkb24ndCB3
YW50L3N1cHBvcnQvY2Fubm90L2JsYS4gT3INCj4gdGhleSB1c2UgYSBwYXJhdmlzb3Igd2hpY2gg
ZG9lcyAqc29tZSogb2YgdGhlIHdvcmsgZm9yIHRoZW0gc28gdGhhdA0KPiBuZWVkcyB0byBiZSBh
Y2NvbW9kYXRlZCB0b28uDQo+IA0KPiBBbmQgc28gdGhleSBzdGFydCBzcHJpbmtsaW5nIGFyb3Vu
ZCBhbGwgdGhvc2UgImRpZmZlcmVuY2VzIiBhcm91bmQgdGhlDQo+IGtlcm5lbC4gQW5kIHR1cm4g
aXQgaW50byBhbiB1bm1haW50YWluYWJsZSBtZXNzLiBXZSd2ZSBiZWVuIGhlcmUgYmVmb3JlDQo+
IC0gbGFzdCB0aW1lIGl0IHdhcyBjYWxsZWQgImlmIChYRU4pIi4uLiBhbmQgd2UncmUgYWxyZWFk
eSBnZXR0aW5nIHRoZXJlDQo+IGFnYWluIG9ubHkgd2l0aCB0d28gTDEgZW5jcnlwdGVkIGd1ZXN0
cyB0ZWNobm9sb2dpZXMuIEknbSBjdXJyZW50bHkNCj4gd29ya2luZyBvbiB0cmltbWluZyBkb3du
IHNvbWUgb2YgdGhlIFNFViBtZXNzIHdlJ3ZlIGFscmVhZHkgYWRkZWQuLi4NCj4gDQo+IFNvIC0g
YW5kIEkndmUgc2FpZCB0aGlzIGEgYnVuY2ggb2YgdGltZXMgYWxyZWFkeSAtIHdoYXRldmVyIGd1
ZXN0IHR5cGUNCj4gaXQgaXMsIGl0cyBpbnRlcmFjdGlvbiB3aXRoIHRoZSBtYWluIGtlcm5lbCBi
ZXR0ZXIgYmUgcHJvcGVybHkgZGVzaWduZWQNCj4gYW5kIGFic3RyYWN0ZWQgYXdheSBzbyB0aGF0
IGl0IGRvZXNuJ3QgdHVybiBpbnRvIGEgbWVzcy4NCg0KWWVzLCBhZ3JlZSwgc28gd2hhdCBhcmUg
b3VyIG9wdGlvbnMgYW5kIG92ZXJhbGwgc3RyYXRlZ3kgb24gdGhpcz8gDQpXZSBjYW4gdHJ5IHRv
IHB1c2ggYXMgbXVjaCBhcyBwb3NzaWJsZSBjb21wbGV4aXR5IGludG8gTDEgVk1NIGluIHRoaXMN
CnNjZW5hcmlvIHRvIGtlZXAgdGhlIGd1ZXN0IGtlcm5lbCBhbG1vc3QgZnJlZSBmcm9tIHRoZXNl
IHNwcmlua2xpbmcgZGlmZmVyZW5jZXMuDQpBZnRlcmFsbCB0aGUgTDEgVk1NIGNhbiBlbXVsYXRl
IHdoYXRldmVyIGl0IHdhbnRzIGZvciB0aGUgZ3Vlc3QuDQpXZSBjYW4gYWxzbyBzZWUgaWYgdGhl
cmUgaXMgYSB0cnVlIG5lZWQgdG8gYWRkIGFub3RoZXIgdmlydHVhbGl6YXRpb24NCmFic3RyYWN0
aW9uIGhlcmUsIGkuZS4gIm5lc3RlZCBlbmNyeXB0ZWQgZ3Vlc3QiLiBCdXQgdG8ganVzdGlmeSB0
aGlzIG9uZQ0Kd2UgbmVlZCB0byBoYXZlIHVzZWNhc2VzL3NjZW5hcmlvcyB3aGVyZSBMMSBWTU0g
YWN0dWFsbHkgY2Fubm90IHJ1bg0KTDIgZ3Vlc3QgKGxlZ2FjeSBvciBURFggZW5hYmxlZCkgYXMg
aXQgaXMuIA0KQEplcmVtaSBQaW90cm93c2tpIGRvIHlvdSBoYXZlIHN1Y2ggdXNlY2FzZS9zY2Vu
YXJpb3MgeW91IGNhbiBkZXNjcmliZT8NCg0KQW55IG90aGVyIG9wdGlvbnMgd2Ugc2hvdWxkIGJl
IGNvbnNpZGVyaW5nIGFzIG92ZXJhbGwgc3RyYXRlZ3k/IA0KDQpCZXN0IFJlZ2FyZHMsDQpFbGVu
YS4NCg0KPiANCj4gVGh4Lg0KPiANCj4gLS0NCj4gUmVnYXJkcy9HcnVzcywNCj4gICAgIEJvcmlz
Lg0KPiANCj4gaHR0cHM6Ly9wZW9wbGUua2VybmVsLm9yZy90Z2x4L25vdGVzLWFib3V0LW5ldGlx
dWV0dGUNCg==

