Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B937900C3
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Sep 2023 18:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245608AbjIAQed (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 1 Sep 2023 12:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237492AbjIAQec (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 Sep 2023 12:34:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F23810EB;
        Fri,  1 Sep 2023 09:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693586069; x=1725122069;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Zmn5v4BE6Vi2XYfb5lD52S0Wll13e636d+QtmtOeJrc=;
  b=mVvMmr862bqLKAqFz/9oycAmVwyj2RcHVYbggQSEGt3ZtspQDmNGhyRW
   qV8b2iBevIkXglyFy81U3agyeo0mJcSxlo9rL5JKPa1WSx05fYWWSvfE4
   glku9HpYPaBeuOyuUnWJ2be3cGZAlLJGvsqG3sjfZIX6pJxvSK231TWQG
   YvIJw/aToAgNXDRr1u/l0lBdYvuNioWx1lg7WZlhT0WsVw26EIoB3G/oB
   jf3jwQqxyT+7IOG09q/eRwwJjjuxg+he1hB0ItA3SXr9ZAV2OenWWqx6W
   oaCNljq9wNhdf/jJjBTCCJNTNlN32X1c4WxyLBlqOYR6KWYS6Om/jlZ8z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="366487721"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="366487721"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 09:33:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="986736519"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="986736519"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2023 09:33:50 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 09:33:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 1 Sep 2023 09:33:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 1 Sep 2023 09:33:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRQbn5ksWbgsFJDfDo8CrkU/18FJmgf6ccnZIoqLLbZezEn0pWiQuiWknDw601/HOBt1bBX49OmHgq40b/ArD9QTGGFRuWQkqkNWW7nJ+cqCliZZyMIYfarNJB9YGovhJRuDf/pa8sJjRUbgUarqQfCngnEmTLmyPOz19X12DXpghLEBToi+YB0kbadgH967eJ88e1wH1rNEUOXyGVuDRwCSm8RNH2yvWSWOHGH4z7Rt+DBBPUjBp2mldh8wqkb289Crx6UHUQG02J8CmDFNVdSAeAFyApdpwDJYaUZW2ewUOM6D5lhs4els0/4wd3zu7Pzbh8zKcJSfISl83ZWe1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zmn5v4BE6Vi2XYfb5lD52S0Wll13e636d+QtmtOeJrc=;
 b=GzIw4g24KipdKBichKHz4JBZOwfh+TegDq5ll/i+0rPSHFWOT81h07U8KPtAQ0q+LKgbHMqTDSfYeQirvUvkXmtDwSj0/rsXW978zFOyj0Hfz8KLjV7pnDczGwNN72A1WYpgusI4Z6wzxg+hq7y5XufdDOMl/gJask447a6d/qWyY5Yx6U0dmn7Uch+1qE0tVnrUdUyi3W+ZTqxipKm9WeoYEdmNRWA8f5BfDDc+W1b4WiwFtFpwTzr00xBwU+1WQoKqvYWXo3OVMdsHZf2c+Vh1BYh+MPz47BddkPGNG2tuAhpGNkOvhRj/yFZaR4r+Dm9+Z5+kpQBVvr6dRPbbMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA0PR11MB8378.namprd11.prod.outlook.com (2603:10b6:208:48e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.26; Fri, 1 Sep
 2023 16:33:47 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6745.020; Fri, 1 Sep 2023
 16:33:47 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Lutomirski, Andy" <luto@kernel.org>,
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
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "Yamahata, Isaku" <isaku.yamahata@intel.com>
Subject: Re: [RFC PATCH 1/1] x86/mm: Mark CoCo VM pages invalid while moving
 between private and shared
Thread-Topic: [RFC PATCH 1/1] x86/mm: Mark CoCo VM pages invalid while moving
 between private and shared
Thread-Index: AQHZsCj93PB3G0C0Vk6xHcwugUyu3bAD1nGAgAEqqQCAAWRUgIAAHmgA
Date:   Fri, 1 Sep 2023 16:33:46 +0000
Message-ID: <60b7f1d0100320d3dc4a61838e01cbd08c0e529f.camel@intel.com>
References: <1688661719-60329-1-git-send-email-mikelley@microsoft.com>
         <72def9c793a99bc9bc39fbc887fd72ded00e4910.camel@intel.com>
         <a2570676d1b06a0227e733ff09d408567d1d615d.camel@intel.com>
         <BYAPR21MB16889C1EA1EFEF5F1F3306BBD7E4A@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB16889C1EA1EFEF5F1F3306BBD7E4A@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA0PR11MB8378:EE_
x-ms-office365-filtering-correlation-id: 688473bb-94d1-44dd-ebec-08dbab09370d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9QqWGtBk6rVKcoUOiIR+6ZGv0c6l8etNHRPwahAGHPGJy+Vx2TJwO5SBlq5/DmyRUXtPANeSt5eLedUEueA3ZyE8LhH5cAwumDKahUiE64Ww9OipxXXU2DkdmeHCrQR6DlnNil/4flw0xfYM54zTsFD7zSS2MiS5wEmcCf4M44CvfPyPXs1dpmitVne8l8ZSYsXqU1u7wcDSSEbTYwqQR3fO8SwNryadJUiq/JnD2l9DTz+iBpC2S42ygY1zKGddgBR57+hoBuTjb/XHRz5KUCBJYdwBS4N0HgJewlsG7B9xJInATCFd5ff768Xyv0RR+oqD1Prgkzp/kzfcDROfnqFgJ4y9wdv+qYIyoTQG9wBNQ4LQpsbXwP8/9YNxYoVxQ64Rade4TTnbuDt6L3IVoWOAMPE9LIq1gOe7aQJtSHVSzfOV3peaaQsfOy/HIklTM7rjhwoDO4Qfyf36/8hCJHTrzOgN6g/WXrqzGiUIG9pYPPeGI4E+MMLwWZiIDtZAeT9KC+NvqR6LBqZhgmc1ZuE6f7s6Ur051AEeM15I4xMwaGMRGHXbkPVg4AUmMfvRe7Yg9KGeMdkgzb7YIZZmPW4eXEFpNYdmCfJkRmyulY0GBoK7oOxuB/GBmtQRdtZexNj3UAv0Z9kAOMHcz7ZSpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199024)(186009)(1800799009)(122000001)(478600001)(71200400001)(2616005)(921005)(91956017)(110136005)(38100700002)(38070700005)(66556008)(66476007)(64756008)(66446008)(83380400001)(26005)(6486002)(76116006)(66946007)(6512007)(82960400001)(6506007)(2906002)(5660300002)(8676002)(41300700001)(316002)(7416002)(66899024)(8936002)(86362001)(36756003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnhPbEN6Y3ZNTGNjWUpPUjRSU1BreUV6cmtURGJNcFFVUVdpSHN2bjd6Wk0x?=
 =?utf-8?B?bHQyeHY0R1ZmaHg4MHl3M3ppMW1tWjJHbTRwNUVVQ0ZSTk9LUDJVOFhEUnVp?=
 =?utf-8?B?amdhcTRNano2dDlDQWFWYXFFZmFTSEpxMERCTEpCTXNBV3c1YWphdUpTajJt?=
 =?utf-8?B?M3BiYW1pTGZxZkwzNUdaRXhBQ2JJaXc5MUlVaEJIbUhVdnFnUi9iN3JNK3Bk?=
 =?utf-8?B?RmUrRzkreXhKMVlrU2hxNjJSSzMxeG1zWUZOc2lLYkc3amZPUnFqYkR6MmxM?=
 =?utf-8?B?ZHkwWkR2SWpWQlVkUXd2U29KRWtiSEl3d1JRbGR3ODdJUFFGSlpRbndXY3Vn?=
 =?utf-8?B?QmUrOFg5VFN3WTJ1RUY0Z1diR0ZBQytPUTcxNzhpem1oUmc0Y1NPajlWWkV4?=
 =?utf-8?B?MnlkZFBKUW1sMTJ5eWNGZ2p4SUQxcXR6QzMyVWxhNW9zTVg5am5yNUpLNUp5?=
 =?utf-8?B?UmIxRzFvcnF3RHhMcnhxa0lBbTBKdDlrdEtOQWZEaGJ6TWdUMGJlQVZTUElS?=
 =?utf-8?B?YU00cUI5d0ZiMEJYenMwa09xRnZhY3ZsNDNqTDNDN3dIUzl5ZDJ0cFljTWgz?=
 =?utf-8?B?Q24wZFdZNjNQNk9aK0RnL3dDbnFodVNMZzdKVWxRSmhseW9xTElOVThveE9O?=
 =?utf-8?B?eGhmOWRyVDVFNWpzL1N5Wkd0MHdLd3FtdzJHMjgxT2VJUDA5ckVVVkNmTi8w?=
 =?utf-8?B?SXhjZDFNMEI5WXpodHVmV2o0NXFEdXdjK1B6Q3ZNNVdYdjFIMzJtRUMwdG9B?=
 =?utf-8?B?cjFFaWsrUG1QTWhRVmlmbXFDL2pkelF1VnZiTTR5cy9sczlZVUlMNXFkVUhh?=
 =?utf-8?B?czNEWXM4UUtCd2V6cDlnaW9mVzhnWFBqYndiQ3pya08yZFdTNFpPRldRdWJq?=
 =?utf-8?B?dGdqUHdLT1BPZ3VYUDVYZXc1Zm12RGpmaUVCY1RDVXJNdlJ0YTJ6MjVNZUtw?=
 =?utf-8?B?clFrMittUCtBQi9sMUc2YkVKZUphajZkT1VOdHFqbGlKczF1WExtNXVvWTVL?=
 =?utf-8?B?aVlUNnd3clBJZ2Q0NFhGdVJmcUs0aTNTODhiRTQveFNWOXJVK2xHbTFDYUta?=
 =?utf-8?B?Q3lsNzVBR3NjVDJldiswK0padHo0am9QQ3RwZElkcW1mYzhHT1RNY2l3TmJq?=
 =?utf-8?B?M2ZJN01Rcjc5ZE55Mi80MURVTkV0WnErMDh1VlRVN3U3eUF4RWY5Z25VZHdp?=
 =?utf-8?B?QzhWY1dEdWk0TGhrTU1uSGU5eE9STE5oL1hJMEcxdDgwa1gyVkxEWTc5dG5N?=
 =?utf-8?B?ZGJDNWk4MXVXSUZYZmVTOEQrbFhnWHB0OFlDbWl2SHlpaThUaHArREM3M2ph?=
 =?utf-8?B?d3VoZ0xFbVZGUldRUkhQdW55M1B6czkzRWg5VDI3a3JkRE1rRVF0S01xcFpu?=
 =?utf-8?B?bXM2UUVINWx2aHR5UHdJWXN2T0l6WEJhdDZpNE5zbEdzWm9tajRXRFhzd0sr?=
 =?utf-8?B?Ny9NdElTVDJVRVlvdDl1VHU0b3daWVFSb0VFanprUnJuNWcwVlQ1ZndRUjhV?=
 =?utf-8?B?U05wTC9zb1hXdDM5MWZtZWZoZTZsNmozdG5Pb25SZmE5aWxjdDhGMWdpYSsz?=
 =?utf-8?B?OGVDeWlwL1UrWlBJdGJDajNqeExpSGNRb0dYMkNaMlIwUVFLb1VER0EvWnlL?=
 =?utf-8?B?S3pEZlpTS0xtRnJmd1g0WlVqNkFYRUxmTjNoK2l4V2tQR2JuSjMrMk5id2VK?=
 =?utf-8?B?b21ZZmc0QjRuWlJPNkU3MXA3Y3BIV1M5WUtTcE5PUGFTY0hYemZZUXFualhM?=
 =?utf-8?B?aGN5QjJBek52NHFjTUhHQVAxMTBSQ0p1UVZnVHgxc1RRakxCRGFVSFNyc1N6?=
 =?utf-8?B?MzE4MW80WVlPTlhUTG5OaEdmZjNVNVl4eERJYXdnMUk0bS9YTnBWRlVrVUhi?=
 =?utf-8?B?OWxrUHRwU2FhRWVTVHVlY1BuTFQzaDVRYmNaOXdHb0E2Tys5dEJGVXZjdEw4?=
 =?utf-8?B?YThLNmVDVzdvOXJMVTFaczUwY1RoVHZXSWxIZlFYOFE1amhHcUZWVjR2Q2xB?=
 =?utf-8?B?NnNzdjRDZm1SUlg2SmFiMWY3K0R5QXdTeWtvNFF0QUtMR252Yi9IQnBVcDFS?=
 =?utf-8?B?NjR5K0diTnAwTmV5d3BMUTBReGNwYTlVY0R1WnBBTFZxdS9GSTUzLzFzcHNk?=
 =?utf-8?B?ekd4WmpXc1lDV0Vzcm5YcG9pa1c1TUVuTU1JVC93Y09lV1lRQXoxYTFWRjNT?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AA00730ECCC294681637BD71BAB263C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 688473bb-94d1-44dd-ebec-08dbab09370d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 16:33:46.9569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uqa+VcEZjdI/n2sNTfLoNqPT8rBY4U/V6AaNUMA9+aI1K+liQkIMNH1EIUdQD1MAoC/ipuFZJp47iQuRH+s0PyXKgH7Sh7a4kTbVDJaXdWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8378
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

K0lzYWt1DQoNCk9uIEZyaSwgMjAyMy0wOS0wMSBhdCAxNDo0NCArMDAwMCwgTWljaGFlbCBLZWxs
ZXkgKExJTlVYKSB3cm90ZToNCj4gPiBXYWl0LCBzaW5jZSB0aGlzIGRvZXMgc2V0X21lbW9yeV9u
cCgpIGFzIHRoZSBmaXJzdCBzdGVwIGZvciBib3RoDQo+ID4gc2V0X21lbW9yeV9lbmNyeXB0ZWQo
KSBhbmQgc2V0X21lbW9yeV9kZWNyeXB0ZWQoKSwgdGhhdCBwYXR0ZXJuIGluDQo+ID4gdGhlDQo+
ID4gY2FsbGVycyB3b3VsZG4ndCB3b3JrLiBJIHdvbmRlciBpZiBpdCBzaG91bGQgdHJ5IHRvIHJv
bGxiYWNrIGl0c2VsZg0KPiA+IGlmDQo+ID4gc2V0X21lbW9yeV9ucCgpIGZhaWxzIChjYWxsIHNl
dF9tZW1vcnlfcCgpIGJlZm9yZSByZXR1cm5pbmcgdGhlDQo+ID4gZXJyb3IpLg0KPiA+IEF0IGxl
YXN0IHRoYXQgd2lsbCBoYW5kbGUgZmFpbHVyZXMgdGhhdCBoYXBwZW4gb24gdGhlIGd1ZXN0IHNp
ZGUuDQo+IA0KPiBZZXMsIEkgYWdyZWUgdGhlIGVycm9yIGhhbmRsaW5nIGlzIHZlcnkgbGltaXRl
ZC7CoCBJJ2xsIHRyeSB0byBtYWtlIG15DQo+IHBhdGNoIGNsZWFudXAgcHJvcGVybHkgaWYgc2V0
X21lbW9yeV9ucCgpIGZhaWxzIGFzIHN0ZXAgMS7CoCBJbg0KPiBnZW5lcmFsLA0KPiBjb21wbGV0
ZSBlcnJvciBjbGVhbnVwIG9uIHByaXZhdGUgPC0+IHNoYXJlZCB0cmFuc2l0aW9ucyBsb29rcyB0
byBiZQ0KPiBwcmV0dHkgaGFyZCwgYW5kIHRoZSBvcmlnaW5hbCBpbXBsZW1lbnRhdGlvbiBvYnZp
b3VzbHkgZGlkbid0IGRlYWwNCj4gd2l0aCBpdC7CoCBGb3IgbW9zdCBvZiB0aGUgc3RlcHMgaW4g
dGhlIHNlcXVlbmNlLCBhIGZhaWx1cmUgaW5kaWNhdGVzDQo+IHNvbWV0aGluZyBpcyBwcmV0dHkg
c2VyaW91c2x5IGJyb2tlbiB3aXRoIHRoZSBDb0NvIGFzcGVjdHMgb2YgdGhlDQo+IFZNLCBhbmQg
aXQncyBub3QgY2xlYXIgdGhhdCB0cnlpbmcgdG8gY2xlYW4gdXAgaXMgbGlrZWx5IHRvIHN1Y2Nl
ZWQNCj4gb3INCj4gd2lsbCBtYWtlIHRoaW5ncyBhbnkgYmV0dGVyLsKgIA0KDQpBaCBJIHNlZS4g
RGlyZWN0IG1hcCBzcGxpdCBmYWlsdXJlcyBhcmUgbm90IHRvdGFsbHkgdW5leHBlY3RlZCB0aG91
Z2gsDQpzbyB0aGUga2VybmVsIHNob3VsZCBiZSBhYmxlIHRvIGhhbmRsZSB0aGF0IHNvbWV3aGF0
LCBsaWtlIGl0IGRvZXMgaW4NCm90aGVyIHBsYWNlcyB3aGVyZSBzZXRfbWVtb3J5KCkgaXMgdXNl
ZC4gSSBhbHNvIHdvbmRlciBpZiB0aGUgVk1NIG1pZ2h0DQpuZWVkIHRvIHNwbGl0IHRoZSBFUFQv
TlBUIGFuZCBmYWlsIGluIHRoZSBzYW1lIHdheSwgd2hpY2ggd291bGQgYmUgYQ0Kc29tZXdoYXQg
bm9ybWFsIHNpdHVhdGlvbi4NCg0KQW5kIHllcywgSSBzZWUgdGhhdCB0aGlzIGlzIGFuIGV4aXN0
aW5nIHByb2JsZW0sIHNvIGRvbid0IG1lYW4gdG8NCnN1Z2dlc3QgaXQgc2hvdWxkIGhvbGQgdXAg
dGhpcyBpbXByb3ZlbWVudC4NCg0KSXQgc2VlbXMgdGhlcmUgYXJlIHRocmVlIG9uZ29pbmcgaW1w
cm92ZW1lbnRzIG9uIHRoZXNlIG9wZXJhdGlvbnM6DQogLSBIYW5kbGluZyBsb2FkX3VuYWxpZ25l
ZF96ZXJvcGFkKCkNCiAtIE1ha2UgaXQgd29yayB3aXRoIHZtYWxsb2MNCiAtIFJlbWFya2luZyBl
dmVyeXRoaW5nIHByaXZhdGUgd2hlbiBkb2luZyBrZXhlYw0KDQpBbmQgdGhlbiBub3cgSSdtIGFk
ZGluZyAibGFjayBvZiBmYWlsdXJlIGhhbmRsaW5nIi4gVGhlIHNvbHV0aW9ucyBmb3INCmVhY2gg
Y291bGQgYWZmZWN0IHRoZSBvdGhlcnMsIHNvIEkgdGhvdWdodCBpdCBtaWdodCBiZSB3b3J0aA0K
Y29uc2lkZXJpbmcuIEknbSBub3QgdmVyeSB1cCB0byBzcGVlZCB3aXRoIHRoZSBDb0NvIHNwZWNp
ZmljcyBoZXJlDQp0aG91Z2gsIHNvIHBsZWFzZSB0YWtlIHRoYXQgcGFydCB3aXRoIGEgZ3JhaW4g
b2Ygc2FsdC4NCg==
