Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1790C694F21
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Feb 2023 19:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBMSVe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Feb 2023 13:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjBMSVc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Feb 2023 13:21:32 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57E6D514;
        Mon, 13 Feb 2023 10:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676312491; x=1707848491;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Fs5caYKjDLcwV+kqjLD3Y7ZErSP/GpZ9g8PUeJXCHhI=;
  b=eagmuc+j7v/DRz0DpZCRiTjNs0xicbs/Le3hT1E04OjRgrjHk02bRddk
   asbh4ErvGqMh2dNqDmBl32FfDKyUGkuItEVCJ2uZZnUH1/fILbGz6Uac/
   VqtZIl77oKJEhSypPeYcrw3hPWo2tCKC1Ay1l1I1KJBG+rG4erE+JNBEg
   QSSOtW/owbfzHT9+8eWRZaMnaQbKTC1N7xee7QLbpUR83Pms0L148BUov
   XSeDuwrAVDu13qztFxWZtjlm8lY02T2JXH+8bUFVI9jRgxGf2BjIa3Mr0
   r9lt/+rIj1zYzy1kMB1ndj5MzDPSZTB/T4TJO9Q4KEaPs+MeQfFRIM7FY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="417177776"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="417177776"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 10:21:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="914419459"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="914419459"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 13 Feb 2023 10:21:30 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 10:21:30 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 10:21:30 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 10:21:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4abGUitSBf+QMJz7T9aRbPWERvUNhCbzV9RjbGZsW0+EztDVsQfpk9pTVE228lMWjVp0LfPpm0QCybrbu95Eb5gHnPzfSMJ6iYg/AhYYSo5+xPZCkWbhlX+Cf0sdC85xR06Fj7/hSkxGFd0dvmQE+5bxFypMvD9IJs63alifMDvaqnqtvT/FWI1QpFzbhpei7zB9ruoOpAtoh88GEyd2M5cPUvZZ0OWFnNPn60cImsVZ3TCnMC/wwzm4j/xEtTKayDJxCBZ4E+aRu5yBwJH6/7GIrjRbGV2TAwlkxvT2KycqMfG0nkRPArQKvkM3uxU/03w4ETBMvW5khk6D+iodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fs5caYKjDLcwV+kqjLD3Y7ZErSP/GpZ9g8PUeJXCHhI=;
 b=Q1XAyYPt4l8IOlTSrz7DCR5Q0/Z2x+EBEK0OEXL/GRpLbosMM8drr5YM5IouI+eWpqoA9BTY4Qc3xj3cquLztMQuNCXxJTvHoRtk5Q8rbpkKrJg/tKke+gkjbgIfvmCBZvzCWAKgDv7jTm9IgC0YuSEuokv84LuNgXP+fvyazHEklbwXP36/m+zZzByjw6i/zbwJIw9hKOrlzB5Pwf2/IiZqAg0kQ4ICtbwMLRr+ZnQdtRMjNbtO8zQF+iAPcCYAaiS2BHw7PdeLh1EJHeIhUcmY70R9b7tPE3lByY+atqjzO9p+d604iFPay3UGrmemvwZOv2eLBwimpW2PH31Bkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SN7PR11MB7067.namprd11.prod.outlook.com (2603:10b6:806:29a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Mon, 13 Feb
 2023 18:21:26 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 18:21:26 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gross, Jurgen" <jgross@suse.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "Ostrovsky, Boris" <boris.ostrovsky@oracle.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "lists@nerdbynature.de" <lists@nerdbynature.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "Cui, Dexuan" <decui@microsoft.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 0/8] x86/mtrr: fix handling with PAT but without MTRR
Thread-Topic: [PATCH v2 0/8] x86/mtrr: fix handling with PAT but without MTRR
Thread-Index: AQHZPaym1OeQ0uPDs0uotDA3o+cSyK7MaNuAgADLwoA=
Date:   Mon, 13 Feb 2023 18:21:26 +0000
Message-ID: <cb98f918fbc8b58e0a8d6823b4f92ad1d4265cfe.camel@intel.com>
References: <20230209072220.6836-1-jgross@suse.com>
         <efeaec9b303e8a3ec7a7af826c61669d18fd22dc.camel@intel.com>
         <e983da4b-71d5-1c9d-5efa-be7935dab8fc@suse.com>
In-Reply-To: <e983da4b-71d5-1c9d-5efa-be7935dab8fc@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SN7PR11MB7067:EE_
x-ms-office365-filtering-correlation-id: b1868438-57b2-4397-f75c-08db0def1e85
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z5HC+XRbYu1M4Pe7xGCOz9zhKI82FpGUOGa5ObyE62HWgMR4JgXHANmVi1S1oPODMs0mVA+TJiu4kR9OTHX3WmOsIADa6M64A6qlZ2/+p+gk4Rste1MS4fov7wThiWT6OSMMhLz1PrwtWpv4mNVEM/iFf2KkaZdwL21osatpPuaDzgiyZzBKwIcACzYhpTtoMtIkeznGZv7d/r0G6+UbE/NhZAoFB7pBny+/nNvxTiAmTxRwAxPSOl5icGMRjFgyr5ZtYon0FWbrDqi0IqWKuYOnRq6m53dZM+sHTYaCJSbtCxvSzGBlGCDXdvSmCjDQtuiTy/2UhQA+us0xnJ/nMDCHdBIz9GRa+BNg7WHyKTfX/UTDM9+o9Ab7L4Ou99Hw1vvUS8tnbA+V0rJoDISQJqimdi9DQcPp0/3L4h4okq3wSYY9d7JiStBkzmeEfswTSM8YZiXa+RsBfEfxr/J2iyidc9Ikhg13mwSGa5czdZ/Yxfa8C/ogVhnOq8TnTZe1hxfOGOjbbtb5in2lWfvxLtul4Ii3T7w7Ox+9h+qW3X1KEta1QpbLG3sPx4X5J2rdsrAc8VkuesfunHrTv1EVccoM3iUqSUYhY2q2Q94s9NauB0Bltv4psGTSvvjo/9fqO6Zd96vmSdE49o6TGamAYfAt2RZfxG39Vtfu0lhjs3UzDzcNfWdigxEi2ZLvCirkfIk/J5ilOlMf+xYA1s/DMH0fjNE0gnFL5ahzAESPR34=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199018)(38100700002)(122000001)(82960400001)(5660300002)(86362001)(66446008)(36756003)(558084003)(2906002)(66556008)(66476007)(4326008)(7416002)(38070700005)(8676002)(64756008)(76116006)(66946007)(8936002)(41300700001)(2616005)(71200400001)(6512007)(6506007)(26005)(110136005)(54906003)(186003)(478600001)(91956017)(6486002)(316002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmJIQWRJaXNUYzlOY0Z5ZVk2dVo0NUZ1L2QzR1MvZWlrT3h6M0J0QUZ6b0N1?=
 =?utf-8?B?blJtbWpiRmh3UnNiODdCVi9NbEFmWTc0UUVIMmpUeXdkNHQ3Y3hHYS9TVE54?=
 =?utf-8?B?eUdjWVdLTGZrQ3RSRzVBQTRRcFBJNEswSmRZekVjYlluZ29nUHEwZklkU2Qw?=
 =?utf-8?B?d3BWY2xlclcvTWNoVndPUy9Xd1gydUkveVRsUkgvblloM0RxaXJTQUtaR3dE?=
 =?utf-8?B?Y1BlNk5WWmxoOEpyZEtKNzA3ZnpCMXBpQzBuelRnbXpOTEVadDhuRWJmUzRB?=
 =?utf-8?B?eldrQ2xQSHhyVW1BV0dhUTlDRnA1cWQ4dzJuc1RZMEs3UDMxWmRENnV0bkYz?=
 =?utf-8?B?TlN2MEtURCtjbHMzSG5Nc3ZnNzhEZnprUTQ1eWgyVWdXTllPVjNmcUZJczBQ?=
 =?utf-8?B?elREMEdpc1RpcUphczJmcUF4N1lvZnRnTTZabE0xckNndmFTSGlYRVg2V2M1?=
 =?utf-8?B?aVhVbHQvMU9hZkpMUjdqdW9oZ29FSXpYelFzZktBSnlLQ0JSaUJ1NGk2N2JR?=
 =?utf-8?B?SHYzQkVmamJZMldKUk1qY2tJUXUyVE5ocng0NXcwZWFYaGxxSjlsdW1VQW9N?=
 =?utf-8?B?QjBxU2ZRK091YVkzNFRvTzhVSmtZM1lBSnRhWVFQUWhGVlZqVnpkMVd6Q1Yx?=
 =?utf-8?B?emtjRjIxZzFFYVpORmpKQjJ5L1dOZU5vOGwzbUE1cklIUnZFWjhZdCsrZENN?=
 =?utf-8?B?SXVUN1FVV08wMXpyT2h3VUFCUGNpZEhQZDRmZ2tGRlFrWXJ6NVBrNEw2dHRQ?=
 =?utf-8?B?Z0NzaDVMLzJLTWw5ZllwOHdTYkdlRXVGYlUweUhZc0s5ZFJGdi9BR1A1d2sz?=
 =?utf-8?B?TWxwbDJ1YVlvZWowU0FLWldIUUFXUWY4MTFEVytZMHlIZ2dkR0RjeFp4cVZR?=
 =?utf-8?B?ZGVwV3N3S09FdXJEdHgydVRvY2IyNHprSEJkckE1MVNocW00ejhwcjBFVmdB?=
 =?utf-8?B?b0U2dW0vZjZrRTNCaXVuY2lYcXh0NFdYU0xaSjI4UUtqcVpzWmVKZ0Y1Z3JW?=
 =?utf-8?B?YkxoZ1JQL1orUERISENxODkxVlRIcmhpaDNpYlpReitPMTdqUUs4SThVRlAr?=
 =?utf-8?B?THRlUk1BMWhGbTNEOHVuYVU0d25RWTlnK25UTHhNK1Y4elpDcDJoeHFXTUNu?=
 =?utf-8?B?dWdHaTExL2pmZmZCQ1lodUdsNWNlNUNiWjZwTFhmVk9XMysvakttWmQ4NllB?=
 =?utf-8?B?am5NNFdhajdYT0treTYxNTZGT2ZPUTVMcFVGdlF5WkQwRjFwQ3VvLzVzL205?=
 =?utf-8?B?RTFFNU91aXpzSmE1WVNidmtTY29wdGtpYW1UZXkvU1BBbDlHOVUxemxldmJi?=
 =?utf-8?B?RUlpS1VPalc2dmhiazROY2ljaHdGdlQzV0V6QVFydXp2RTV6VkVXYTlPRjFm?=
 =?utf-8?B?Mmh2V04rQmRDdVZHNHhxNDI3bVBud0ZFME96VVZxTVVrV2k2ZVdSWGRkSkRZ?=
 =?utf-8?B?UllKV2Jqekl0Q2pBczZuY053Y0lEUWxTbVNIMVRSZTZvMDRPYml3NjZ1MGtG?=
 =?utf-8?B?THJ3U0NueXRmT1lRZHBGY2JmaHRpRzdKRzcreHBTMk1oUUY1RmFYRjhqSksw?=
 =?utf-8?B?dGFmSWpZS3Y4M0p5ZStRenlJNXJsRk8rZkZCS21sYm1FNjVTVDBjWnptV0pq?=
 =?utf-8?B?VFV1WGhHQ25SR25HVUg4MWRRQWZCczlsMDczSkNYL1EzTWM1Y0QxbEs5djFI?=
 =?utf-8?B?bGl6RW5uTGNRbnl1NXMxVnh3Vk9XS1VvbEZ3eGZzQkJlTUJkeE50SmI3S1Zn?=
 =?utf-8?B?SHRXOUpIaHJ2T1BMOVRyYVI0Vk1CT1dIOHpXWjdwRHh1YVJDWmhEZ0RBZ2JY?=
 =?utf-8?B?MW9MQ0gycHNIbkR5L0Q3b0ZSekJwbEpEUTRrTHlBeEpKa3pNQ3E0dldsbmhK?=
 =?utf-8?B?ZFpUNkRpUU1jQjkybElweFllY29uak5KUExOWXhuNTJkNExhSDB6N2hNdGpi?=
 =?utf-8?B?OVVjRHFzOGhrVmM1SldVNjh4YldmWDl4cjY2WlZkSTNDMEdOc2hVVDdWUC8r?=
 =?utf-8?B?UGIrOFJOZlNDNXdXbWJ2aDVWQU9WczRiNUI3Qy9lT1YzOGQ2WExVSjNPckV4?=
 =?utf-8?B?QXlnS05QRUVtb3pSVGZTY2l4TWsxU3hzUlk3N0dUa3BMMTBabjVEVTVtQzVI?=
 =?utf-8?B?azRPMnRHaU5HaWx3VzJuZjhXQzlJVXdNcXpsWHlUY0Mwc0Q0elJSOERWNGtQ?=
 =?utf-8?Q?BkSfQpzJ+nxCKASvefVWUhE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74584F4737DAA5409E00937B788D04EB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1868438-57b2-4397-f75c-08db0def1e85
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 18:21:26.2873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vIK/QO5FhAKy9Jy2PiT/QpI7snKgqMGKRvr56uZr20UBZuDj8wHZVMVR23FPSgnMFBvxzyQK8Pz90U7JFLQ2lBO8Gzm5KQO07O01H5iHWLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7067
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

T24gTW9uLCAyMDIzLTAyLTEzIGF0IDA3OjEyICswMTAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0K
PiANCj4gVGhhbmtzIGZvciB0aGUgcmVwb3J0Lg0KPiANCj4gSSdsbCBoYXZlIGEgbG9vay4gUHJv
YmFibHkgSSdsbCBuZWVkIHRvIHJlLWFkZCB0aGUgY2hlY2sgZm9yIFdCIGluDQo+IHBhdGNoIDcu
DQoNClN1cmUsIGxldCBtZSBrbm93IGlmIHlvdSBuZWVkIGFueSBtb3JlIGRldGFpbHMgYWJvdXQg
Ynkgc2V0dXAuDQo=
