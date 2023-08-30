Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66D878D0D7
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Aug 2023 02:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237114AbjH3ADR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Aug 2023 20:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238341AbjH3ADN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Aug 2023 20:03:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1881D1BF;
        Tue, 29 Aug 2023 17:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693353789; x=1724889789;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=W3PFO8Z5iekgVrE4WDuKkcz7eYvQycPTL2isgNCmiMY=;
  b=a04e/Q85GwtgdoEQar5uKdwpN7xmAxBXpiSPWsrojy9jEfGm1jgtWmZq
   004pMeKyUJNe2BaCXSmRPZScNop354kjshuYh/fr8F9/ej24GgU3LyGjo
   GEZXUJgqtOQdsKUF0vqH9l75pGFUJCH+cQsQ8PQPotSUgc0jjycvZ8Zfe
   CX5GVJ+YjweFd1QdQGfKff/GfnVyl83Y/h1hho7m8eN96BN5/nOguFu6T
   iQpqc86qYgtoTv6S1NgiijZOG6kL5O/mN7c4Lt01lMsdrN+AJsXzCZlV2
   3Igypa9cAW4qM2EG+Gcx+KvnuuryLjhUw0ymJ+P4tOXI2OFJO5vS1mn7l
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="360507270"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="360507270"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 17:02:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="862412948"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="862412948"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 29 Aug 2023 17:02:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 17:02:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 17:02:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 17:02:51 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 17:02:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdyNY7bUBJQN0Hm4txVMDzDR2HaE19EurjNF/OoYN6yHruHJDCB8cqzz/507+QL/MXrnLJwEHd/T1/MAJrOsbjTMEz5qgZ4e1f4Q25XY74UC3PeKsN2zLqVQ89Ej9CfIZwjcH4xfv4FgjE4e30NIyBg+KQ0R0gVxvNbbGL5/GudXW6yd7s4vEqbghDazRXAm9WXJUfCPjiSK1htrHYJfRTZ2/mb9LMWAKKilMfVkuiaVbT/CgpPnxcuWi4VZnTE+Qn/SqskLHsnC3bfN0JDRn/K0Ri6t2jTZ1YTbNhzEZ+XwqkoL4s74truEQZXh0ZhCok9SW06BIwtVv2mzjJd5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3PFO8Z5iekgVrE4WDuKkcz7eYvQycPTL2isgNCmiMY=;
 b=CfAzHdVwRTrFoHddCiMQKuFt9YBS7hdg4czwEABCWThqkdQfejmzusdU2it46VhDAXUmS9Nq9B11YTbORIAbc5U8UNMp6Ibx4l7OjaN7+H8XMPaK2Us/VITQUH3XuQzu9AOyPfRvsw9JEJWXaFLvk4I/HfvHLCWRgfWG8sjP9kTvOHxbClz1bmCtnvWAsWHTPpMYWsMBs44/NfWDvkrQslEUdbGcMa0MavjJVqWtioBab0ctHiJIrTFjMtJAv/j3Dl3aMjwUuX4Afei71/Q30/Eb8A+20K7c+IoM/AwTt88G9ylRUtE/5gqYHyB1EDuVxY/TgNxBNPQ+Lpc/l05brg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA1PR11MB8350.namprd11.prod.outlook.com (2603:10b6:806:387::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Wed, 30 Aug
 2023 00:02:44 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 00:02:44 +0000
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
Thread-Index: AQHZsCj93PB3G0C0Vk6xHcwugUyu3bACSkaA
Date:   Wed, 30 Aug 2023 00:02:44 +0000
Message-ID: <28cfc19ac3171c270896d080f30aeda11b587bb8.camel@intel.com>
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
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA1PR11MB8350:EE_
x-ms-office365-filtering-correlation-id: 258a12e2-fead-458e-87e1-08dba8ec6f8c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w49rAhVWAbGWwjNugsRhQhO8aSzgDSqx+iVt1U+P+ywrGFdC9eBtiMfvlAuctu7oDKuRgP0DHj/knXJPORGUYa5hhQYro5LEELcjCgnXmKf8qwRtk90ifCyIa4RqiNqIqGPzFY0AJHoLSkS1zDDLqLLnivDkMwWBsy1j1rbXfzktXbrFo3m43x3fK8+ebiCMjSH7BMdYNrvZj7IgT+dQb74nbKGv47xmhk1T2HLzg1BNdo0zZhbgYXqsL1c+1hx33eIuE4zl7ZLB8CRgX5kGsUacFAyMrTgmLRNOy/ty+eCXUrvaUAJ8ZPFR7T+9TodkdPYODWoUfybJXQqaZ3eKJD9Z5HshKlcdoOKtmcK5+Of3UqxnU1gsdlVspwCaGSLey3pcqvvtwmfnrnmxMum6gAiBWidi/Dy5B+vgZFbfJaBQLcZp7nPNpcZeIJAtRV65XZeEwU8eBmd9YmNvLszkleVdfdPfwcoqqoj5xrWB3rpleYaaQUZWHKARMXG8h3D+mvrUOXdbs8TbqaUdMNtrHtluShnAYahUNgMO6CIQCKBzKkjvpy1YYt4yaEaOpXtv4kVh0qv7G5tGHkjGMU72dbTpOtaFCj6zvdtKZrAkP6dSLGjLV6cr2V8OJbpO40+0g/hRjxZK4y0OjBXd0Fdn2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(39860400002)(396003)(376002)(136003)(346002)(366004)(1800799009)(451199024)(186009)(5660300002)(316002)(7416002)(38070700005)(66446008)(64756008)(41300700001)(38100700002)(76116006)(66556008)(91956017)(66476007)(110136005)(66946007)(83380400001)(6512007)(82960400001)(478600001)(2906002)(921005)(122000001)(8676002)(8936002)(86362001)(71200400001)(6506007)(6486002)(2616005)(36756003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S09VOVJEVmZtOTRVSXFiQWI0YldReWR0OS9qbkhRRTZFY0lIQjFhd2ViNFNX?=
 =?utf-8?B?MlM5TDRSbDgwVUJSMHFONnlTOHN3bVlua09Mc0dnck1PMWlrRnFsaVdLUGdZ?=
 =?utf-8?B?TDdGalRQc0dienZxb2xLdFRMeTFBb2tnTFBHNWFLekFFdHdQS0xoTFZlaGZh?=
 =?utf-8?B?aUR3b0FWTEVIZXpwbHFXOVlGRCtXelhlMXBTekVMTWwxWXNGUm9Mdnh6SHl1?=
 =?utf-8?B?NUNPRTZOMFA0UGRMOWl6bm4rTlM5bDhmZlBGcVdiM1JaemhaZFFaVjdCOXFi?=
 =?utf-8?B?SFFNc3BiamhqSWlLTDFhV2tLQklNbSswVUNNbE1neXladDgwMDZST1FPY1NH?=
 =?utf-8?B?MmpHTWpNMTFyVDByUEV1NnZiT09iOVBTV3FRbXY5aVRrK0JOZUYrbWE0aWFk?=
 =?utf-8?B?NnpyeWRjZG5uZEFVc3ZSalVwRkdNYWxXWnRPKyszYXFiWGdZbUR3eVN6U3Rs?=
 =?utf-8?B?UDZIMkdsRGlySWR4N2trb0JXUUVPT2tLWjNLeHNKUUt1K1BtSnRyL1BGVG1H?=
 =?utf-8?B?eTBiM2lFSnFIN3VpNnRob2RrVEJodmtZd3dYRkFuNURMejNuZi9nblFmUm1s?=
 =?utf-8?B?N0FRQm1oZEZYdDc4ZGpZREtGKzltSlFrckRDeFVmNlZub2hQQ200Z1BtNnpy?=
 =?utf-8?B?bWo1N0JaNzNFMlRrY0pVaXRIUTFYdDFmYlZqbnduYVFVL24vaWt2MVpaOUh3?=
 =?utf-8?B?d0x4Nk44NFNkc0R1U3lrUjFXTlUyRHFtZCtISWFya0srRG52RGQvSG1laDVH?=
 =?utf-8?B?K3hnS2pMc2NzNEFLeXJaTlRSWjRxV2V4eW5IVzN0ZkxSWERuRnBUWENscVBG?=
 =?utf-8?B?QytaeTl3SzEreGxnbHNwSDVwaWs4SUVDRnQydjBBRWtmNGJRVUdpNHpEcmFH?=
 =?utf-8?B?dVRETE5SY2xRSVFLVXFURTg3bHE4TFJmRVJJNFIzaU9NWEtFMkducDlxdS9p?=
 =?utf-8?B?dlFnMjJmWXdndWVLL296UmF5TjR4SkcxVmxvalIrVU9UR0ZNVHZVaUhISUFp?=
 =?utf-8?B?S0xRRHlRSlhmWmxjQ0pxVU5rNmEvRndwc0FNN25HT3l3N3BDZHJFVkc1TWQ5?=
 =?utf-8?B?NWJNeHp3R3pIVkdibkdwKzdSL0lHenZiV24wSC9HL3NmT1Q0ekZHc0tTd3g3?=
 =?utf-8?B?aEpNSjJjbStzY09oa2g5alYvRmxLdXJxLzhKV3VOdkFaVFBQbEZMUWdwTXhr?=
 =?utf-8?B?VmJXcXpOZkxUL29HR1lFa3VkVkZUWUUwTTU1dSsxcGo1ODY4ckpOQ1U0ZVhh?=
 =?utf-8?B?enNoS3AxbXVvbm5SV3FSUW51R0pia2poS3ZjN1djQ2w4TUdyRVpNcEs1OVI1?=
 =?utf-8?B?ZjhWQ3p5WU15RDJXNG1BNklGQTBabDA5ekpqRmhKaDRFczNoc2dHTWc2ak1x?=
 =?utf-8?B?WG9mQVdyNnNEVnU4S043SExKczZnMEtvUTRzd3dycXpqUFlzZWx6VHQvR21s?=
 =?utf-8?B?UXZqVVRTL2NvYzFlb2ZyWGVaMWQwQUdoZVQ0SURWNnhtSXo2TTM5SXY2MG5L?=
 =?utf-8?B?NGV4cXg2NFozaGZ5cjR4UDlwZEk2VUxBKzk5NExvTk5vTnBGdEQxS3lxcmtJ?=
 =?utf-8?B?Sm1kV2FvZyt1T1N4cHZqVVpvUjhUSXRLQnpWRTY0aGJxb1JMTG9MRkxjcjJQ?=
 =?utf-8?B?aGtIa1RUaEdndEdCaitNTUhJL3VTWU5HQUZ4THFsTGIvMThxdjNWY01zVG1o?=
 =?utf-8?B?RlFDazQvOGlvSnpTSUdPam04cHNrUWwzc3VGYVk5MVg3WU11TmYzUHdQNWdw?=
 =?utf-8?B?RWVlWTdXNzhseHRHUUFWL0FEaytjZG5TMmg4T2JZbUhYT1IydU81a3ZDekJK?=
 =?utf-8?B?S1lTNnRiLzd2UWdHYXh0bGcwalJXdis2bklCNlFub3RqemNHVXRaM0wwZDJv?=
 =?utf-8?B?MFBmK1pDcC9aR1dlY0tDYnhOSmZRWk9RSktEdWhjUXY1dVN3eVloYUdqejVJ?=
 =?utf-8?B?V1ZlZzEwWUJUY2E0WTh4R29rR1grcURFZHR6aTVuOUpNektFT3R4RGgrMjVR?=
 =?utf-8?B?eEJpQmprbThFamY1Vk5qSFBTd1IrelIvSkNrNVd6OGxUeGZVL1R3TStjWXVE?=
 =?utf-8?B?cVZzZk5DUzRZZUlva0l2YnNTMGt1aGluQll4MzA5OWVRemRBMUlsRDJaWEhs?=
 =?utf-8?B?UHFkc3c0OHRLSUZCVDdmbmxOdUQrd3JRdHBicG1SWmlPNi9pOVZsT3U1aDlj?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE1829FE225F494E803E19151CB58960@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258a12e2-fead-458e-87e1-08dba8ec6f8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 00:02:44.0179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWzW3nWJcGrh7+DiEc/sDKnPGuJH9AbeNI0yZASHrvfR4hVyVOImuyb2NJGTziSdivSDZp/azNSfT7A7d3gBFUyk0SJGWogks+vRpKmU6tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8350
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

T24gVGh1LCAyMDIzLTA3LTA2IGF0IDA5OjQxIC0wNzAwLCBNaWNoYWVsIEtlbGxleSB3cm90ZToN
Cj4gSW4gYSBDb0NvIFZNIHdoZW4gYSBwYWdlIHRyYW5zaXRpb25zIGZyb20gcHJpdmF0ZSB0byBz
aGFyZWQsIG9yIHZpY2UNCj4gdmVyc2EsIGF0dHJpYnV0ZXMgaW4gdGhlIFBURSBtdXN0IGJlIHVw
ZGF0ZWQgKmFuZCogdGhlIGh5cGVydmlzb3INCj4gbXVzdA0KPiBiZSBub3RpZmllZCBvZiB0aGUg
Y2hhbmdlLiBCZWNhdXNlIHRoZXJlIGFyZSB0d28gc2VwYXJhdGUgc3RlcHMsDQo+IHRoZXJlJ3MN
Cj4gYSB3aW5kb3cgd2hlcmUgdGhlIHNldHRpbmdzIGFyZSBpbmNvbnNpc3RlbnQuwqAgTm9ybWFs
bHkgdGhlIGNvZGUgdGhhdA0KPiBpbml0aWF0ZXMgdGhlIHRyYW5zaXRpb24gKHZpYSBzZXRfbWVt
b3J5X2RlY3J5cHRlZCgpIG9yDQo+IHNldF9tZW1vcnlfZW5jcnlwdGVkKCkpIGVuc3VyZXMgdGhh
dCB0aGUgbWVtb3J5IGlzIG5vdCBiZWluZyBhY2Nlc3NlZA0KPiBkdXJpbmcgYSB0cmFuc2l0aW9u
LCBzbyB0aGUgd2luZG93IG9mIGluY29uc2lzdGVuY3kgaXMgbm90IGEgcHJvYmxlbS4NCj4gSG93
ZXZlciwgdGhlIGxvYWRfdW5hbGlnbmVkX3plcm9wYWQoKSBmdW5jdGlvbiBjYW4gcmVhZCBhcmJp
dHJhcnkNCj4gbWVtb3J5DQo+IHBhZ2VzIGF0IGFyYml0cmFyeSB0aW1lcywgd2hpY2ggY291bGQg
YWNjZXNzIGEgdHJhbnNpdGlvbmluZyBwYWdlDQo+IGR1cmluZw0KPiB0aGUgd2luZG93LsKgIElu
IHN1Y2ggYSBjYXNlLCBDb0NvIFZNIHNwZWNpZmljIGV4Y2VwdGlvbnMgYXJlIHRha2VuDQo+IChk
ZXBlbmRpbmcgb24gdGhlIENvQ28gYXJjaGl0ZWN0dXJlIGluIHVzZSkuwqAgQ3VycmVudCBjb2Rl
IGluIHRob3NlDQo+IGV4Y2VwdGlvbiBoYW5kbGVycyByZWNvdmVycyBhbmQgZG9lcyAiZml4dXAi
IG9uIHRoZSByZXN1bHQgcmV0dXJuZWQNCj4gYnkNCj4gbG9hZF91bmFsaWduZWRfemVyb3BhZCgp
LsKgIFVuZm9ydHVuYXRlbHksIHRoaXMgZXhjZXB0aW9uIGhhbmRsaW5nIGFuZA0KPiBmaXh1cCBj
b2RlIGlzIHRyaWNreSBhbmQgc29tZXdoYXQgZnJhZ2lsZS7CoCBBdCB0aGUgbW9tZW50LCBpdCBp
cw0KPiBicm9rZW4gZm9yIGJvdGggVERYIGFuZCBTRVYtU05QLg0KPiANCj4gVGhlcmUncyBhbHNv
IGEgcHJvYmxlbSB3aXRoIHRoZSBjdXJyZW50IGNvZGUgaW4gcGFyYXZpc29yIHNjZW5hcmlvczoN
Cj4gVERYIFBhcnRpdGlvbmluZyBhbmQgU0VWLVNOUCBpbiB2VE9NIG1vZGUuIFRoZSBleGNlcHRp
b25zIG5lZWQNCj4gdG8gYmUgZm9yd2FyZGVkIGZyb20gdGhlIHBhcmF2aXNvciB0byB0aGUgTGlu
dXggZ3Vlc3QsIGJ1dCB0aGVyZQ0KPiBhcmUgbm8gYXJjaGl0ZWN0dXJhbCBzcGVjcyBmb3IgaG93
IHRvIGRvIHRoYXQuDQo+IA0KPiBUbyBhdm9pZCB0aGVzZSBjb21wbGV4aXRpZXMgb2YgdGhlIENv
Q28gZXhjZXB0aW9uIGhhbmRsZXJzLCBjaGFuZ2UNCj4gdGhlIGNvcmUgdHJhbnNpdGlvbiBjb2Rl
IGluIF9fc2V0X21lbW9yeV9lbmNfcGd0YWJsZSgpIHRvIGRvIHRoZQ0KPiBmb2xsb3dpbmc6DQo+
IA0KPiAxLsKgIFJlbW92ZSBhbGlhc2luZyBtYXBwaW5ncw0KPiAyLsKgIFJlbW92ZSB0aGUgUFJF
U0VOVCBiaXQgZnJvbSB0aGUgUFRFcyBvZiBhbGwgdHJhbnNpdGlvbmluZyBwYWdlcw0KPiAzLsKg
IEZsdXNoIHRoZSBUTEIgZ2xvYmFsbHkNCj4gNC7CoCBGbHVzaCB0aGUgZGF0YSBjYWNoZSBpZiBu
ZWVkZWQNCj4gNS7CoCBTZXQvY2xlYXIgdGhlIGVuY3J5cHRpb24gYXR0cmlidXRlIGFzIGFwcHJv
cHJpYXRlDQo+IDYuwqAgTm90aWZ5IHRoZSBoeXBlcnZpc29yIG9mIHRoZSBwYWdlIHN0YXR1cyBj
aGFuZ2UNCj4gNy7CoCBBZGQgYmFjayB0aGUgUFJFU0VOVCBiaXQNCj4gDQo+IFdpdGggdGhpcyBh
cHByb2FjaCwgbG9hZF91bmFsaWduZWRfemVyb3BhZCgpIGp1c3QgdGFrZXMgaXRzIG5vcm1hbA0K
PiBwYWdlLWZhdWx0LWJhc2VkIGZpeHVwIHBhdGggaWYgaXQgdG91Y2hlcyBhIHBhZ2UgdGhhdCBp
cw0KPiB0cmFuc2l0aW9uaW5nLg0KPiBBcyBhIHJlc3VsdCwgbG9hZF91bmFsaWduZWRfemVyb3Bh
ZCgpIGFuZCBDb0NvIFZNIHBhZ2UgdHJhbnNpdGlvbmluZw0KPiBhcmUgY29tcGxldGVseSBkZWNv
dXBsZWQuwqAgQ29DbyBWTSBwYWdlIHRyYW5zaXRpb25zIGNhbiBwcm9jZWVkDQo+IHdpdGhvdXQg
bmVlZGluZyB0byBoYW5kbGUgYXJjaGl0ZWN0dXJlLXNwZWNpZmljIGV4Y2VwdGlvbnMgYW5kIGZp
eA0KPiB0aGluZ3MgdXAuIFRoaXMgZGVjb3VwbGluZyByZWR1Y2VzIHRoZSBjb21wbGV4aXR5IGR1
ZSB0byBzZXBhcmF0ZQ0KPiBURFggYW5kIFNFVi1TTlAgZml4dXAgcGF0aHMsIGFuZCBnaXZlcyBt
b3JlIGZyZWVkb20gdG8gcmV2aXNlIGFuZA0KPiBpbnRyb2R1Y2UgbmV3IGNhcGFiaWxpdGllcyBp
biBmdXR1cmUgdmVyc2lvbnMgb2YgdGhlIFREWCBhbmQgU0VWLVNOUA0KPiBhcmNoaXRlY3R1cmVz
LiBQYXJhdmlzb3Igc2NlbmFyaW9zIHdvcmsgcHJvcGVybHkgd2l0aG91dCBuZWVkaW5nDQo+IHRv
IGZvcndhcmQgZXhjZXB0aW9ucy4NCj4gDQo+IFRoaXMgYXBwcm9hY2ggbWF5IG1ha2UgX19zZXRf
bWVtb3J5X2VuY19wZ3RhYmxlKCkgc2xpZ2h0bHkgc2xvd2VyDQo+IGJlY2F1c2Ugb2YgdG91Y2hp
bmcgdGhlIFBURXMgdGhyZWUgdGltZXMgaW5zdGVhZCBvZiBqdXN0IG9uY2UuIEJ1dA0KPiB0aGUg
cnVuIHRpbWUgb2YgdGhpcyBmdW5jdGlvbiBpcyBhbHJlYWR5IGRvbWluYXRlZCBieSB0aGUgaHlw
ZXJjYWxsDQo+IGFuZCB0aGUgbmVlZCB0byBmbHVzaCB0aGUgVExCIGF0IGxlYXN0IG9uY2UgYW5k
IG1heWJlIHR3aWNlLiBJbiBhbnkNCj4gY2FzZSwgdGhpcyBmdW5jdGlvbiBpcyBvbmx5IHVzZWQg
Zm9yIENvQ28gVk0gcGFnZSB0cmFuc2l0aW9ucywgYW5kDQo+IGlzIGFscmVhZHkgdW5zdWl0YWJs
ZSBmb3IgaG90IHBhdGhzLg0KDQpFeGNsdWRpbmcgdm1fdW5tYXBfYWxpYXNlcygpLCBhbmQganVz
dCBsb29raW5nIGF0IHRoZSBUTEIgZmx1c2hlcywgaXQNCmtpbmQgb2YgbG9va3MgbGlrZSB0aGlz
Og0KMS4gQ2xlYXIgcHJlc2VudA0KMi4gVExCIGZsdXNoDQozLiBTZXQgQyBiaXQNCjQuIFNldCBQ
cmVzZW50IGJpdA0KNS4gVExCIGZsdXNoDQoNCkJ1dCBpZiB5b3UgaW5zdGVhZCBkaWQ6DQoxLiBD
bGVhciBQcmVzZW50IGFuZCBzZXQgQyBiaXQNCjIuIFRMQiBmbHVzaA0KMy4gU2V0IFByZXNlbnQg
Yml0IChubyBmbHVzaCkNCg0KVGhlbiB5b3UgY291bGQgc3RpbGwgaGF2ZSBvbmx5IDEgVExCIGZs
dXNoIGFuZCAyIG9wZXJhdGlvbnMgaW5zdGVhZCBvZg0KMy4gT3RoZXJ3aXNlIGl0J3MgdGhlIHNh
bWUgbG9hZF91bmFsaWduZWRfemVyb3BhZCgpIGJlbmVmaXRzIHlvdSBhcmUNCmxvb2tpbmcgZm9y
IEkgdGhpbmsuIEJ1dCBJJ20gbm90IHZlcnkgZWR1Y2F0ZWQgb24gdGhlIHByaXZhdGU8LT5zaGFy
ZWQNCmNvbnZlcnNpb24gSFcgcnVsZXMgdGhvdWdoLCBzbyBtYXliZSBub3QuDQoNCj4gDQo+IFRo
ZSBhcmNoaXRlY3R1cmUgc3BlY2lmaWMgY2FsbGJhY2sgZnVuY3Rpb24gZm9yIG5vdGlmeWluZyB0
aGUNCj4gaHlwZXJ2aXNvciB0eXBpY2FsbHkgbXVzdCB0cmFuc2xhdGUgZ3Vlc3Qga2VybmVsIHZp
cnR1YWwgYWRkcmVzc2VzDQo+IGludG8gZ3Vlc3QgcGh5c2ljYWwgYWRkcmVzc2VzIHRvIHBhc3Mg
dG8gdGhlIGh5cGVydmlzb3IuwqAgQmVjYXVzZQ0KPiB0aGUgUFRFcyBhcmUgaW52YWxpZCBhdCB0
aGUgdGltZSBvZiBjYWxsYmFjaywgdGhlIGNvZGUgZm9yIGRvaW5nIHRoZQ0KPiB0cmFuc2xhdGlv
biBuZWVkcyB1cGRhdGluZy7CoCB2aXJ0X3RvX3BoeXMoKSBvciBlcXVpdmFsZW50IGNvbnRpbnVl
cw0KPiB0byB3b3JrIGZvciBkaXJlY3QgbWFwIGFkZHJlc3Nlcy7CoCBCdXQgdm1hbGxvYyBhZGRy
ZXNzZXMgY2Fubm90IHVzZQ0KPiB2bWFsbG9jX3RvX3BhZ2UoKSBiZWNhdXNlIHRoYXQgZnVuY3Rp
b24gcmVxdWlyZXMgdGhlIGxlYWYgUFRFIHRvIGJlDQo+IHZhbGlkLiBJbnN0ZWFkLCBzbG93X3Zp
cnRfdG9fcGh5cygpIG11c3QgYmUgdXNlZC4gQm90aCBmdW5jdGlvbnMNCj4gbWFudWFsbHkgd2Fs
ayB0aGUgcGFnZSB0YWJsZSBoaWVyYXJjaHksIHNvIHBlcmZvcm1hbmNlIGlzIHRoZSBzYW1lLg0K
DQpKdXN0IGN1cmlvdXMuIEFyZSB2bWFsbG9jIGFkZHJlc3NlcyBzdXBwb3J0ZWQgaGVyZT8gSXQg
bG9va3MgbGlrZSBpbg0KU0VWLCBidXQgbm90IFREWC4NCg0K
