Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E4378F1EC
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Aug 2023 19:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244856AbjHaR37 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 31 Aug 2023 13:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjHaR36 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 31 Aug 2023 13:29:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EB1E6B;
        Thu, 31 Aug 2023 10:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693502989; x=1725038989;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=jEqfxk3Zi0JTEBaauFI6xcNVGJhrkbQVXgJF18eD0Us=;
  b=MB/pyeA4Zs1yr6UoesN04Q8O0FtXgDUwjsOMX79m+F/bKv36cL66YFMf
   nxX8dca2RQn2I2XnLA+Eh9zzOfe4K0zw4oPlj1dPBsAC0JODS9joVDTNU
   SRT25mrTbMevl1iHNEgirFj+XU3oSQdG0ZxsFNpab6ZMl7A8aCycWmZrL
   hT7YFBFSYTFxZQ5eNTHRwOskVQJk7KaRvU7+ukKw8PuvcKhljhr8vGv0k
   I89D4vnvJbFoJ8o51Xn8JiQV5rVSpJuJxzRyq5eubdxcl3x+hcP2UIFxx
   10zLawu30ALKizfLbTe63d833Lbl3UrO2EcqvjP76UhZJSBhjZXRgqQXw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="442408776"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="442408776"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 10:29:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="689432624"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="689432624"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 10:29:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 10:29:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 10:29:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 10:29:43 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 10:29:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLINZXzNcwM0MIsvVJGoxNYEw46Qgg2RHDVenQK3qCjcgAc17rr2zpbUXwH+MfdA4QXgY17xO2seKmanRUR6e0B1X6/9nMSMrOe4cPbBCuyoQVc0dPaUH04SBo11uOSzA2VHXkeGGgxIvCXZ1F1PHWErQmyYvzs7ujFSTV+rDn0ARQ+WK4lSBR1VkcZWSCVtdnEAiioZerJi+ZPtRirrC2sSi9Z/O/2yxi8tbGbtXDK73qDg5UCx/LBuZnEc4OMN/4T5vsMYdnrjXeWzXgCtPWOJKdanesGMuLHPS1KANpCun46n3FMYGOqVM0fAITYLjUsQgVmwSwZ0Cm/gYympEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEqfxk3Zi0JTEBaauFI6xcNVGJhrkbQVXgJF18eD0Us=;
 b=aTqPF0OG+RHIQoeCQ6L5XW2PwqHG+/sygH2+vDGfNTwe85F2q7WoA2TCpyE8vd0PWTlOUbwiGp2IaKHBU3yql0kI+B/YdpPVmgouUToE+tAo7BTp6/sLUtUwQbb4kOC11l90qxCg+/Nu5PPw43cnsBsN8k+pibO6LMUNiT3TSGO6Bwrvl7Usv0QjvyqqiW1mK9sKmM7YxGlAE5l4A/tRJna17zDdxThLaPTAhGaC+uEQdud8vv1FE3tlYGBc+oyMYob4S9XEs1yqYtfp/TjjIY9VLEYD480R7L0GW0aqROJmX5ygaaE5usEjwilP6RsfzHvVcpRwQqNyxQZg4QFQOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MN2PR11MB4677.namprd11.prod.outlook.com (2603:10b6:208:24e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Thu, 31 Aug
 2023 17:29:37 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 17:29:36 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC PATCH 1/1] x86/mm: Mark CoCo VM pages invalid while moving
 between private and shared
Thread-Topic: [RFC PATCH 1/1] x86/mm: Mark CoCo VM pages invalid while moving
 between private and shared
Thread-Index: AQHZsCj93PB3G0C0Vk6xHcwugUyu3bAD1nGAgAEqqQA=
Date:   Thu, 31 Aug 2023 17:29:36 +0000
Message-ID: <a2570676d1b06a0227e733ff09d408567d1d615d.camel@intel.com>
References: <1688661719-60329-1-git-send-email-mikelley@microsoft.com>
         <72def9c793a99bc9bc39fbc887fd72ded00e4910.camel@intel.com>
In-Reply-To: <72def9c793a99bc9bc39fbc887fd72ded00e4910.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MN2PR11MB4677:EE_
x-ms-office365-filtering-correlation-id: 38560efa-7cb0-4972-cd2d-08dbaa47d92b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2xOBrwIW0d4/sczuDY7gUpcURDhGOdApFToikeUeHu7YVMT69R/qoTlZ2WJ7D+PRy/9fXAwJEkmFt6n+QuxI/xuajH+OkeNO5exVXSgj8mZRCeD3kq2WpwjiamuCiUbLCa3QyUQteJXmopjA+PX7IYw5PJWOt48AgDOV6tp4v3Q8UY414OCmDiO0DrZ0PyErzuBGSmESRoQ8ReOM36B+QJAYBF7ip9sv/uFx/LYikWhPLg5DRCJz35LDQ75A9/C8fjGCn1vYJo5IgtmqgMVFe0rsO/qEN4eAosRBA/6EPUOJpEc7YHME5zZcdbmvxb6KIV7968qSJQ3q+ufb867qsIbfOE99zLEa1yA+eppTeSPhYyW/FXfn5TueScF8LdYCbvgMWbMXG2ubyfWCyWNRn0nHw+Z19KU2Ap51wCJu3hWIVQGABLSloPw2sKP0qGM8Yq4XIwgRzXEbF0tKLQCtFHPVz9zsIyj+LaL0fSYYqeFinjmr5xhiYNDcqwDaKQ+OHBb48W/BfP/Cg/Nkpf+vrUfCB0kGaoQQhAkFajdf4HD1P7DEMj63cLHh2WY+SmL9G+EcAEPiASyzdg/sOc7kARwU8zLB7L9JgBshs9GIz59kJWPGQbvBQ/NYLNuOlewvCoJ1NMtRSncaNMHxu9lkVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(346002)(39860400002)(136003)(396003)(366004)(376002)(1800799009)(186009)(451199024)(66556008)(6512007)(41300700001)(66476007)(86362001)(66946007)(2906002)(76116006)(64756008)(316002)(66446008)(8676002)(8936002)(2616005)(26005)(36756003)(5660300002)(7416002)(83380400001)(38100700002)(38070700005)(82960400001)(122000001)(921005)(71200400001)(478600001)(6506007)(6486002)(91956017)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFVIWFYvdWxpTUJNY1RzYUFuenBEaG5qZEdOdGI3cmZzbkJBSmg2aVZtdmEv?=
 =?utf-8?B?QXBnWkFjVjVEYzVndGlBSXhuYzZlUXlKTHhrTmZFMGp0Zk53VXRqMURJdFp5?=
 =?utf-8?B?bWUrWGRVNmN0M1ZjeEhybWMzTVFDOUIyaVpCQVZiNXI4NE5WQnMxSXE2a2ZJ?=
 =?utf-8?B?azRkbFpaWjR2L2dpV0wyR003ZGVRbFFMbFFJQ2pEZlhKalFXZEFTbS9RYVEr?=
 =?utf-8?B?UzZNc0k0VStJMmRSbDZPTTZhUC93RmhHdFNrbkFVakFkaHBjcHNDMWVpWk5l?=
 =?utf-8?B?YWhFRnBvWkdQS0g3R1dlTFg0UFpSdE50Sk9lcyt5ZUJ0MG9MV3dDdUp0Rkpw?=
 =?utf-8?B?Nm5FZGJRaGs1Sld6VWJVenU4M2lxakk2L05RNkdCQk5pSUttTDhDZFNxMHY5?=
 =?utf-8?B?ejhMS1QvWW9PRVpwMFVMUUpqMmE5TytUYi9JdHZmMnA4cGtVVlFzdmw2czBJ?=
 =?utf-8?B?QVZYZGF2QVRZZHE1OUZYS0htMG8rSFNnclM0U0dram55bUpDOFk4NFZkalFB?=
 =?utf-8?B?TWRTZDJtd0txRWtxOGI4WjA3Y1NnTWRVL3lGNmVzL2MyUU5TV2ROZENTTXhx?=
 =?utf-8?B?SHdUM3NwK25HMUF4b1VjeWhpT0ZFb2xaci91azJDRGg4bWVXWWFIQmtKajkx?=
 =?utf-8?B?a1p1OUFEa1pvKzk0RDJSVGVUV2lydm5kSUsrTmRaWDNVZjIzNkdtajY1NWdj?=
 =?utf-8?B?eWJuS0xlVDBBbHpUbm1zUlRsVXNLUzV5Ty9VUGFoOUpueHFjVXdrZUVDYU1v?=
 =?utf-8?B?R3o0R2pOTVhRRXUzTEtEcVNlTDY1WUlkdC9IcGVxcVYybkJyWHc1anpMa0dv?=
 =?utf-8?B?K1BEK2VkSCtXRnlRMDgwbEt0eEdZc2F1Y3NscndHZzRnbU9TZzlsUUhVUGdp?=
 =?utf-8?B?Z29vbFZMRHllYW1zUENBZlFNMGFrVmVIZ0dVYlZXbWV0bHlMNWsrR1lhVlpl?=
 =?utf-8?B?QzdEOS9mYTJmM1RSUFN4Qi9xZm5JbENaR0l6NURDcHV3WWtmb1UxZ2ZwdG1Y?=
 =?utf-8?B?eWJKckFvNHNaMWFWVjZUVVZDL2hNRDZVYWRsRFJIWWY3RVBHanpMeEtkWnNL?=
 =?utf-8?B?eSt6aE1TeGtRZ1VkVmNkbEMzT0dFTzJWcDNRS09ib3RYZ0JKV2JtT2ZtanJU?=
 =?utf-8?B?bG1wRjJ5MUtNWElJVDhQQ3hPdnRpUjRyaXV0UkxFVnN4STJac2dCYXhEd3ds?=
 =?utf-8?B?eFpsVzd5MzIyb052S1RVRFZjalRaZHZmZSt2RjBPTldpSlFnaTYySnNubUFu?=
 =?utf-8?B?cFlCdTZ1K01ya0s4TTJLeHRObVpuTVd3aFBiY3oxc0psTXE3N0VXZ3BiT3VI?=
 =?utf-8?B?aFFTOFIrbEVQUXQ0YTRUV25zWDUxVisyWERHWTlNSk9pbmxoTk03OE4yN21E?=
 =?utf-8?B?Y25Xd0hST2xUcWtYODF3ZWVLRnduVTRGK3ZVc2FZM3N0ZzJTK255NkhMSXdy?=
 =?utf-8?B?WGF4bDZORFQ3VmFUQXkxYVF0bndibVQxbWhQaExEb1oycXN4VEFHdlpHY1BP?=
 =?utf-8?B?QmtSVFBGUnB0VVVXenVqb1Vya3RTUG5QOEtxUVNUTTJQdnpMOEluMUI1aVRp?=
 =?utf-8?B?RlBVdlVoZG5PREpqMnd5MjVCbTZRY0JnLzYwVkFZTkErTHpXaitPWjAxTTFX?=
 =?utf-8?B?d1dBeDNHY0tISUwwazNnQ0l1R01BNXhtV3pkQngwRXhVa3E3MTgxZm4rSlJh?=
 =?utf-8?B?bXVic09pMTk1dVpJUUZ3Qnk3MFBGRXNJZENxU1lqVjVyMXlUTmw0Yy9vaCtR?=
 =?utf-8?B?WE5waWt6enk0ZEMyd29PN2t2bUh1cndlK0J1ZmdXWXJ1SHBFR2VuUVN2dVlB?=
 =?utf-8?B?ak5TTDdtNHRrYUV6Wk9CY2M0MmsvR05zalFrcUljSldpNjZSRm40UDYzWEJ4?=
 =?utf-8?B?N0xmdnBqQ0Z2Zk1xdjQyZlBBMDI4QnhNaWJOcHdFQWk5RDdSdDRhYlcvK0xq?=
 =?utf-8?B?ZHpPTGhUTDVyS2JtdVp3Ti9Idkw3Q2wxc1RVUERueDJJN0pXMkJ6SnVhY3BC?=
 =?utf-8?B?TjkrMnlsRHhERVpMQ0ZTV21LNmdLUGNGVDMxMDdlRTY1TXFoR1FZQWIzak9Y?=
 =?utf-8?B?eVVaeHZGeUJQQjhoWFlyOThPZUZXVkRYZE1JWTVyZVlYREg5QVZkekRCaXVq?=
 =?utf-8?B?N2tNVXk4MVlWbzBWZDJJKzFCNm5KbzdhZW5TSVloZmVlZTFZOS8wRkxTYVk2?=
 =?utf-8?Q?GEAxowQHv/7qDUhvBMdJsjo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C247F3F9C05CED4F8EC40180B1357C18@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38560efa-7cb0-4972-cd2d-08dbaa47d92b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 17:29:36.5779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a3F1ghNreq3w/huJUXB0BxzIYqr95C72EifmmlnHJL1bl1mQbWBE40pg2EaJaUkBv4yikRhAHSjpx6abjklFMhpmo9bryw8W7vy2FouV5Oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4677
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

T24gV2VkLCAyMDIzLTA4LTMwIGF0IDE2OjQwIC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gVGhpcyBpcyBhIGJpdCBvZiBhbiBleGlzdGluZyBwcm9ibGVtLCBidXQgdGhlIGZhaWx1cmUg
Y2FzZXMgb2YgdGhlc2UNCj4gc2V0X21lbW9yeV9lbi9kZWNyeXB0ZWQoKSBvcGVyYXRpb25zIGRv
ZXMgbm90IGxvb2sgdG8gYmUgaW4gZ3JlYXQNCj4gc2hhcGUuIEl0IGNvdWxkIGZhaWwgaGFsZndh
eSB0aHJvdWdoIGlmIGl0IG5lZWRzIHRvIHNwbGl0IHRoZSBkaXJlY3QNCj4gbWFwIHVuZGVyIG1l
bW9yeSBwcmVzc3VyZSwgaW4gd2hpY2ggY2FzZSBzb21lIG9mIHRoZSBjYWxsZXJzIHdpbGwgc2Vl
DQo+IHRoZSBlcnJvciBhbmQgZnJlZSB0aGUgdW5tYXBwZWQgcGFnZXMgdG8gdGhlIGRpcmVjdCBt
YXAuIChJIHdhcw0KPiBsb29raW5nDQo+IGF0IGRtYV9kaXJlY3RfYWxsb2MoKSkgT3RoZXIncyBq
dXN0IGxlYWsgdGhlIHBhZ2VzLg0KPiANCj4gQnV0IHRoZSBzaXR1YXRpb24gYmVmb3JlIHRoZSBw
YXRjaCBpcyBub3QgbXVjaCBiZXR0ZXIsIHNpbmNlIHRoZQ0KPiBkaXJlY3QNCj4gbWFwIGNoYW5n
ZSBvciBlbmNfc3RhdHVzX2NoYW5nZV9wcmVwYXJlL2ZpbmlzaCgpIGNvdWxkIGZhaWwgYW5kIGxl
YXZlDQo+IHRoZSBwYWdlcyBpbiBhbiBpbmNvbnNpc3RlbnQgc3RhdGUsIGxpa2UgdGhpcyBwYXRj
aCBpcyB0cnlpbmcgdG8NCj4gYWRkcmVzcy4NCj4gDQo+IFRoaXMgbGFjayBvZiByb2xsYmFjayBv
biBmYWlsdXJlIGZvciBDUEEgY2FsbHMgbmVlZHMgcGFydGljdWxhciBvZGQNCj4gaGFuZGxpbmcg
aW4gYWxsIHRoZSBzZXRfbWVtb3J5KCkgY2FsbGVycy4gVGhlIHdheSBpcyB0byBtYWtlIGEgQ1BB
DQo+IGNhbGwNCj4gdG8gcmVzdG9yZSBpdCB0byB0aGUgcHJldmlvdXMgcGVybWlzc2lvbiwgcmVn
YXJkbGVzcyBvZiB0aGUgZXJyb3INCj4gY29kZQ0KPiByZXR1cm5lZCBpbiB0aGUgaW5pdGlhbCBj
YWxsIHRoYXQgZmFpbGVkLiBUaGUgY2FsbGVycyBkZXBlbmQgb24gYW55DQo+IFBURQ0KPiBjaGFu
Z2Ugc3VjY2Vzc2Z1bGx5IG1hZGUgaGF2aW5nIGFueSBuZWVkZWQgc3BsaXRzIGFscmVhZHkgZG9u
ZSBmb3INCj4gdGhvc2UgUFRFcywgc28gdGhlIHJlc3RvcmUgY2FuIHN1Y2NlZWQgYXQgbGVhc3Qg
YXMgZmFyIGFzIHRoZSBmYWlsZWQNCj4gQ1BBIGNhbGwgZ290Lg0KDQpXYWl0LCBzaW5jZSB0aGlz
IGRvZXMgc2V0X21lbW9yeV9ucCgpIGFzIHRoZSBmaXJzdCBzdGVwIGZvciBib3RoDQpzZXRfbWVt
b3J5X2VuY3J5cHRlZCgpIGFuZCBzZXRfbWVtb3J5X2RlY3J5cHRlZCgpLCB0aGF0IHBhdHRlcm4g
aW4gdGhlDQpjYWxsZXJzIHdvdWxkbid0IHdvcmsuIEkgd29uZGVyIGlmIGl0IHNob3VsZCB0cnkg
dG8gcm9sbGJhY2sgaXRzZWxmIGlmDQpzZXRfbWVtb3J5X25wKCkgZmFpbHMgKGNhbGwgc2V0X21l
bW9yeV9wKCkgYmVmb3JlIHJldHVybmluZyB0aGUgZXJyb3IpLg0KQXQgbGVhc3QgdGhhdCB3aWxs
IGhhbmRsZSBmYWlsdXJlcyB0aGF0IGhhcHBlbiBvbiB0aGUgZ3Vlc3Qgc2lkZS4NCg0KPiANCj4g
SW4gdGhpcyBDT0NPIGNhc2UgYXBwYXJlbnRseSB0aGUgZW5jX3N0YXR1c19jaGFuZ2VfcHJlcGFy
ZS9maW5pc2goKQ0KPiBjb3VsZCBmYWlsIHRvbyAoYW5kIG1heWJlIG5vdCBoYXZlIHRoZSBzYW1l
IGZvcndhcmQgcHJvZ3Jlc3MNCj4gYmVoYXZpb3I/KS4gU28gSSdtIG5vdCBzdXJlIHdoYXQgeW91
IGNhbiBkbyBpbiB0aGF0IGNhc2UuDQo+IA0KPiBJJ20gYWxzbyBub3Qgc3VyZSBob3cgYmFkIGl0
IGlzIHRvIGZyZWUgZW5jcnlwdGlvbiBtaXNtYXRjaGVkIHBhZ2VzLg0KPiBJcw0KPiBpdCB0aGUg
c2FtZSBhcyBmcmVlaW5nIHVubWFwcGVkIHBhZ2VzPyAobGlrZWx5IG9vcHMgb3IgcGFuaWMpDQoN
Cg==
