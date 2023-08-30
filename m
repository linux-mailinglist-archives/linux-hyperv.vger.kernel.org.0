Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E404278E366
	for <lists+linux-hyperv@lfdr.de>; Thu, 31 Aug 2023 01:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344541AbjH3XlB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 30 Aug 2023 19:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344547AbjH3Xk7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 30 Aug 2023 19:40:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8880D7;
        Wed, 30 Aug 2023 16:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693438853; x=1724974853;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=63XNZjc+8OTBuCfs6e86Cvc9MabEqAFbkEVRpLTlGH0=;
  b=DglX011zJDvXs+f5VkA6FL/khCyV2hqDVl54P8SdMHgPMiIyRhjN4yuG
   lz4siOFeA4DUcpQV3T+DkwCRG+ba0o8mgdFCMuDpxdyPYS9VbXL2ozfAW
   nwY6VIc22gvWPw8Vh+GY82G/OQdABbxXc1EnDAhK8j33Ajtdr05nvmthV
   Ix2e0TDILZP+EsTv6pqodvKEdrF1/a864t7COQrQ5y47SFiyvetm0pjqG
   Tn7YAwDKDG84S1aA+Y8+7JGz6Jl3nYGW7vv9yHvuHioVcMJaU6rnOry15
   7CcQSUmsvKwNZa1UXOy/pJb9mAuvBYgMKUbpU6OhOzoc3uRsAefx9LH7i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="378491527"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="378491527"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 16:40:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="882923451"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 30 Aug 2023 16:40:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 16:40:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 16:40:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 16:40:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWNzqZQhR0My9pmdFh3sUpQT54r16SPBDrLxOIggFJO3sPsXWArJLksHi336rioSkXtFoqPsbsQu/N5UnvbWTPnSCNnQl7vciSWp/8f7pFFaxVcasEvfcmO/Rn2bagVjIdViBJ7Zqxy1AreuWDYOPhE0UKmxcYj0byhQhjrWNVNkG8ZEp4gBuJ5luroZUe8uQTI5dqbXzI677ysYs6ryd9t487wjfHRUl4eDAPpJl9NXpUekfzL464Lt5kSFaTwQHSqZoIIPepVkG/Jj4rsgn/hip2LZXZFBKF0fA/ZP+qGgVZ/DI0bIyn2dPRt+tGbAU3fRvH2oiN58Kp2hH3Yhdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63XNZjc+8OTBuCfs6e86Cvc9MabEqAFbkEVRpLTlGH0=;
 b=BbyhK8Wh2PJCwNdgFPQe4g33BbOwH8BSklw3jVATwm8OCr3kjlXZ9sQuOF/vnexSS5i4zfY/xN1aerD56TMsYa6JnHW8b88uIuwPUVLbq/w2fHzzscR6TDKQGCdMAuTqq77VhdOh4dIIuQVSngwuRkJYreADzG/cYyoC12UszsmA/P0cYL04ikLj81ddtICYNyr1qh/sHixeZiNKYzBdbEY5j1FXw/1+duq46G/5TyKoYxDy/MVciewBwXcdEV4st/8b/4kNQTWolFtu3X3bZO4vxBwjc/XC9QiCrkN9zdh7wtYx5p0ZqBgxVHuOSzuLXceMmE/DViCbRvCigRDE/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH3PR11MB7865.namprd11.prod.outlook.com (2603:10b6:610:128::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 23:40:40 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 23:40:40 +0000
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
Thread-Index: AQHZsCj93PB3G0C0Vk6xHcwugUyu3bAD1nGA
Date:   Wed, 30 Aug 2023 23:40:40 +0000
Message-ID: <72def9c793a99bc9bc39fbc887fd72ded00e4910.camel@intel.com>
References: <1688661719-60329-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1688661719-60329-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH3PR11MB7865:EE_
x-ms-office365-filtering-correlation-id: 94f40ea1-a828-474d-b885-08dba9b2851e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lp6pwzKWXSAXAIZ+NyAmplcSmeIhtiDRKgysrLnB3/as+Gghi6Mk7zzOF7Nkt9eLcDtqPXyfEoUtCNV+wJJBE8PMABq+mYsJhapmaska22ZVlNLdC1dHF9v6a+vvOAzZlE4g83NUl0ZGCEjBLVDNb5IhGNBe0HFdnf87v7b3sFiqAmvNrVfF9oB9R+i4EANbGEkYEqf3HxbqLIbUAAe1IH8Dox5UXgMyMAVhtJE3wXPRxoMsx73/R9lxnUPXgL3paeX49KcBOKfmgL+fGzBuUADdzOFQZroGjpEMDy8feg3C8S4uDEofJTrCxFLWZod853tBkXFBQYEEAv0YuuVUr8hjyX7fWFr08NKuyrnVLBUbYptw6kUyT+bDp7FxanXXrz720QlXkWMIWCBcE70lasW9oEr93vNPQY1GX0NfF4aEQlHONFPyBI2Ew359/dqCEvW5TggjSBva4KuUmjosPJtZGaoMNRp7m1Jz3nTMAfGuzIJn33yDZMK1e85ygs7GQG/T4m+Wc4XnZLuvIBpTk8R0BR1sUFJUUa42j4N6ddnZ01WRJ6H8BlysBXQS0g7rOmGh+WAm7w9zmp42ZLk8Dg/kEoUimd3HcDssUq6ChMXfdxf/ktaghUBoZvHzIVyrPrlDKTRmb0AsW93K4+8lig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199024)(1800799009)(186009)(6512007)(316002)(38070700005)(38100700002)(41300700001)(82960400001)(5660300002)(7416002)(83380400001)(2616005)(26005)(8676002)(86362001)(36756003)(2906002)(8936002)(921005)(66556008)(6506007)(71200400001)(64756008)(6486002)(66446008)(66476007)(91956017)(76116006)(122000001)(478600001)(110136005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWRWQzV2dU45YlBIeS94RkF5akx2UnVvanZJbG52WlVWcHNwcUNnQ3c4dzUv?=
 =?utf-8?B?R3o4T2RaUHdwUEwrMldoTkpkT1BBVThNakVzVnhlWTBpa09rRFRFOHlieDBG?=
 =?utf-8?B?Y3V1Y0N3R0crRDlQaXBWMHBzbStGY2N2MUszem9DREJzZHpkYTRkM1pzTjNy?=
 =?utf-8?B?azJDSUFxV3JrSlNKaHl1RnZISnpTblp3aHRjMzRqaHVUNDJvREtzeW5BaVc1?=
 =?utf-8?B?eTFyWWRpWDFwUDI2c2pjRnJsZzJkYTRrbEpEQ0tZeWZWTzFOaTBhM3doZDR4?=
 =?utf-8?B?cjY5K2NFSSsxV1ErUEJBM1BJcWFuemJtQTFYa2dTQUNiQlFiQ2phbEVFZ2Rt?=
 =?utf-8?B?WFhnMUFwQVJQdmtRdFdOWWlLblB3WExKRzZqZ3IrY3BpRVpaVHl0NFc2RTE1?=
 =?utf-8?B?V2Nxd05Kck9yZEt1SDZZd29CdE5GRjZoaUxjaDdmV2E0SjJScUpBaytNSTRk?=
 =?utf-8?B?S3FRTnlydUJINXhXOE1aRnVWeFZ2eVFHWWZNanpsNTdKcndiYmlnd29hanBt?=
 =?utf-8?B?NWhwMXVTR2M4VVNHWlc4a0grdXpmWUZNK0JObUNlRFVPd2dORlVLKzlJL2ha?=
 =?utf-8?B?UW9rNTVUY01heThRVVlKN3cyQTZkL3V3SzFvQy8rR3RUclZweitveUc0ZEZl?=
 =?utf-8?B?R25EUXVIN2xEZ21oS2U2OTNDVmNNTFFvRGYyWXg0OUd0bEd4UmdZUTlEdUov?=
 =?utf-8?B?Yk5HcU0wYXEyWkZLM2VvSE5rcWxSVk5zY0xLTzBYZXJIYjFNL3ljUjFnb2dy?=
 =?utf-8?B?V3oyNGZ5YkNWaWFQQ2VaM2R3TlZCS21VczZTTlRXRkJ2clA5ZTZmTGRyMktl?=
 =?utf-8?B?SW5reGFRQnNlMGtpRjZxTXkrRDNwNlBkR3NjTnVNeEZlbnlsWmQ1TTRsa2tm?=
 =?utf-8?B?V0hIbGkvcVNIMnBCTnYvSjFYRXh1eXNrSmo1Ujh3OWp4SC9ZL0w0QlpnWXVm?=
 =?utf-8?B?VEtvVzZqdys2eW95MmQxa2I4VU1QUTQxckZmZVQ4K3ZjaG9yY0V4YVpkNHRs?=
 =?utf-8?B?cVd6Z0oyQ09zNEFSRTQ0Y1MvQUpyVWxacTBGN2lwaGlZMjdjR0tjK0lJMWlJ?=
 =?utf-8?B?elprQms0MHorZ2ZicXBoRWpHN3lKRFI1eU9YbzdoNUtoYTJpejZZRzREMDB4?=
 =?utf-8?B?UElDSUQ5bWVrcmVhWnNzY3FWZnFIK1NkN0oyNjJyNkx3NG81NzF3dHRBOXBD?=
 =?utf-8?B?NUV0d0NXZkFnbnlMYitsKzFPUm1IbkZBN0N4OFJIK3d2K21SaXZnTHFXSlZp?=
 =?utf-8?B?WDBlVG04cWlTMlk0djdIY3RoWHJMZzBOd3YxY1pPckQwRHhUMlZkTlR4a1l0?=
 =?utf-8?B?cjhYdkRYanZxV2pab1FBTkNqTlNaaTBFYVZrMVZGZGFlcUtzMTFXNDdzQXE5?=
 =?utf-8?B?aUxJNTcrU3pRMW5wTzBSbGNUQklaK2phTUNWVW1EeE1YNE50M09uRHlQZ09J?=
 =?utf-8?B?VTl0NXRRVEdCZ2NPODFZeE02OFd3VEwyamdBWEo4SWRKcXdMN0RQWWpsRXBK?=
 =?utf-8?B?YnpDK1hzU0VEWnZ6RlQ0d3Q1WVRNc1JRenlVV2QwbXpSSW9IeFAyRGErcU9a?=
 =?utf-8?B?c2VtYlVxZ25ranE0OGthZkdUMmdHdGYweExDSVNMbC82d24zaGRhbi9kUFJH?=
 =?utf-8?B?dmpHcWxaUk1nbHppNzFjZlZEd0NCMDFxcUorYW1qNTdsbmdXZDQ2NnRtQXB0?=
 =?utf-8?B?eGZUcDBkOGZTWjc0ZHJoOUpsODVqL0ZicXZGSHdEZ3NqQlcvTS9WRUhrOFdC?=
 =?utf-8?B?dXNOa081UjN5Q05LelgyOXZIM21qRGJ4N2g1WHAvdG11Z1lDTXM1dkd1RVoz?=
 =?utf-8?B?UkxTK3hpUUhrNWxVZFBMRXpUdHpTUXF1NERDbzU2M2c5Y2V6a2d6dUo5VDlF?=
 =?utf-8?B?aS82QkFvMGtpVWJhWlE1dngyZDBCRWZKbWJTM0tYTmN0SEdjZUgxeFJZdEdx?=
 =?utf-8?B?S2JqUXRSd0kyaUNyaXVRbml5MHJuYmE2cXIwR2I4aFUySi80QkgwQS95NWUr?=
 =?utf-8?B?bitaZXhJWWl0dTYxVS9wckxMVVZ6ajRlWldBZTdJT2w3L0p2M3ZmaGZhb0xk?=
 =?utf-8?B?N1RmMFZGdEowMDROcU9DUkc1ZG9KNDQvYVhXcldqRWpTMWtHSjVUVkliUWJw?=
 =?utf-8?B?SkU3Zlg0WUZuUzNkRk1mS3JGTFZMSGVwZ2RkSWxoZndHb21aNWhVSURtZUwz?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A24EA1B45DA37478A0B04B021EA2341@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f40ea1-a828-474d-b885-08dba9b2851e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 23:40:40.5130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3aEWpUrAP+nxt6tOSrwVc86VIZkLqgivc8kexfkukvrWkBzki2UHCYT5mZf8D2TTgzBdDV7WqpV5sfidG/UoFlnLd+ePvVW06RAP2RpvqrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7865
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

T24gVGh1LCAyMDIzLTA3LTA2IGF0IDA5OjQxIC0wNzAwLCBNaWNoYWVsIEtlbGxleSB3cm90ZToN
Cj4gVG8gYXZvaWQgdGhlc2UgY29tcGxleGl0aWVzIG9mIHRoZSBDb0NvIGV4Y2VwdGlvbiBoYW5k
bGVycywgY2hhbmdlDQo+IHRoZSBjb3JlIHRyYW5zaXRpb24gY29kZSBpbiBfX3NldF9tZW1vcnlf
ZW5jX3BndGFibGUoKSB0byBkbyB0aGUNCj4gZm9sbG93aW5nOg0KPiANCj4gMS7CoCBSZW1vdmUg
YWxpYXNpbmcgbWFwcGluZ3MNCj4gMi7CoCBSZW1vdmUgdGhlIFBSRVNFTlQgYml0IGZyb20gdGhl
IFBURXMgb2YgYWxsIHRyYW5zaXRpb25pbmcgcGFnZXMNCg0KVGhpcyBpcyBhIGJpdCBvZiBhbiBl
eGlzdGluZyBwcm9ibGVtLCBidXQgdGhlIGZhaWx1cmUgY2FzZXMgb2YgdGhlc2UNCnNldF9tZW1v
cnlfZW4vZGVjcnlwdGVkKCkgb3BlcmF0aW9ucyBkb2VzIG5vdCBsb29rIHRvIGJlIGluIGdyZWF0
DQpzaGFwZS4gSXQgY291bGQgZmFpbCBoYWxmd2F5IHRocm91Z2ggaWYgaXQgbmVlZHMgdG8gc3Bs
aXQgdGhlIGRpcmVjdA0KbWFwIHVuZGVyIG1lbW9yeSBwcmVzc3VyZSwgaW4gd2hpY2ggY2FzZSBz
b21lIG9mIHRoZSBjYWxsZXJzIHdpbGwgc2VlDQp0aGUgZXJyb3IgYW5kIGZyZWUgdGhlIHVubWFw
cGVkIHBhZ2VzIHRvIHRoZSBkaXJlY3QgbWFwLiAoSSB3YXMgbG9va2luZw0KYXQgZG1hX2RpcmVj
dF9hbGxvYygpKSBPdGhlcidzIGp1c3QgbGVhayB0aGUgcGFnZXMuDQoNCkJ1dCB0aGUgc2l0dWF0
aW9uIGJlZm9yZSB0aGUgcGF0Y2ggaXMgbm90IG11Y2ggYmV0dGVyLCBzaW5jZSB0aGUgZGlyZWN0
DQptYXAgY2hhbmdlIG9yIGVuY19zdGF0dXNfY2hhbmdlX3ByZXBhcmUvZmluaXNoKCkgY291bGQg
ZmFpbCBhbmQgbGVhdmUNCnRoZSBwYWdlcyBpbiBhbiBpbmNvbnNpc3RlbnQgc3RhdGUsIGxpa2Ug
dGhpcyBwYXRjaCBpcyB0cnlpbmcgdG8NCmFkZHJlc3MuDQoNClRoaXMgbGFjayBvZiByb2xsYmFj
ayBvbiBmYWlsdXJlIGZvciBDUEEgY2FsbHMgbmVlZHMgcGFydGljdWxhciBvZGQNCmhhbmRsaW5n
IGluIGFsbCB0aGUgc2V0X21lbW9yeSgpIGNhbGxlcnMuIFRoZSB3YXkgaXMgdG8gbWFrZSBhIENQ
QSBjYWxsDQp0byByZXN0b3JlIGl0IHRvIHRoZSBwcmV2aW91cyBwZXJtaXNzaW9uLCByZWdhcmRs
ZXNzIG9mIHRoZSBlcnJvciBjb2RlDQpyZXR1cm5lZCBpbiB0aGUgaW5pdGlhbCBjYWxsIHRoYXQg
ZmFpbGVkLiBUaGUgY2FsbGVycyBkZXBlbmQgb24gYW55IFBURQ0KY2hhbmdlIHN1Y2Nlc3NmdWxs
eSBtYWRlIGhhdmluZyBhbnkgbmVlZGVkIHNwbGl0cyBhbHJlYWR5IGRvbmUgZm9yDQp0aG9zZSBQ
VEVzLCBzbyB0aGUgcmVzdG9yZSBjYW4gc3VjY2VlZCBhdCBsZWFzdCBhcyBmYXIgYXMgdGhlIGZh
aWxlZA0KQ1BBIGNhbGwgZ290Lg0KDQpJbiB0aGlzIENPQ08gY2FzZSBhcHBhcmVudGx5IHRoZSBl
bmNfc3RhdHVzX2NoYW5nZV9wcmVwYXJlL2ZpbmlzaCgpDQpjb3VsZCBmYWlsIHRvbyAoYW5kIG1h
eWJlIG5vdCBoYXZlIHRoZSBzYW1lIGZvcndhcmQgcHJvZ3Jlc3MNCmJlaGF2aW9yPykuIFNvIEkn
bSBub3Qgc3VyZSB3aGF0IHlvdSBjYW4gZG8gaW4gdGhhdCBjYXNlLg0KDQpJJ20gYWxzbyBub3Qg
c3VyZSBob3cgYmFkIGl0IGlzIHRvIGZyZWUgZW5jcnlwdGlvbiBtaXNtYXRjaGVkIHBhZ2VzLiBJ
cw0KaXQgdGhlIHNhbWUgYXMgZnJlZWluZyB1bm1hcHBlZCBwYWdlcz8gKGxpa2VseSBvb3BzIG9y
IHBhbmljKQ0KDQo+IDMuwqAgRmx1c2ggdGhlIFRMQiBnbG9iYWxseQ0KPiA0LsKgIEZsdXNoIHRo
ZSBkYXRhIGNhY2hlIGlmIG5lZWRlZA0KPiA1LsKgIFNldC9jbGVhciB0aGUgZW5jcnlwdGlvbiBh
dHRyaWJ1dGUgYXMgYXBwcm9wcmlhdGUNCj4gNi7CoCBOb3RpZnkgdGhlIGh5cGVydmlzb3Igb2Yg
dGhlIHBhZ2Ugc3RhdHVzIGNoYW5nZQ0KPiA3LsKgIEFkZCBiYWNrIHRoZSBQUkVTRU5UIGJpdA0K
DQo=
