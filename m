Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F0A77977B
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Aug 2023 21:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjHKTE4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Aug 2023 15:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjHKTEz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Aug 2023 15:04:55 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021014.outbound.protection.outlook.com [52.101.57.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5161BD;
        Fri, 11 Aug 2023 12:04:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iadivOud4oxts7b+enrYENzuqQTg0zn88Ua++eofmgRen+v52vdgY88aDlIqx56imo5iictqi0Q2nP0b9oFxjkk7f3qGlVYbcwmnCYZUPbD1QMb4Wn+loSn5pgUs2KVO8nvXBWrdkyEERWYH2NII/+ssxddWAAOOHFh505bkOX6CFVfpJH5S1APp0NRSkQUXKP4eK3gDrY/NCyukJPjoRYseke62NB9qX9QUC00Neu7UEsBUQYcItQTJ+f8TCscogM+6Ss4Z489P3GlbE3/7CuY0zIs7ejZyY1A5WGO6y9NJlTFfKzBT3jOVEe4v7ln4IUMCvd1zXWnVtP5+ZZniYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/odxoGQr85hyH6HOftwOJXG192Bh/ocEjHBJeWLR3I=;
 b=cbPIsFltgzP5gUt0TY8t4ySstbvJ8EcPWnQVAhLW5zvfkYhs2xLb6WlfS2L2ijo4EToetvS6VvItceiwelXxoN3Sy3K1Udf+Sja5lsFzwS5HjhNwbBkJNRJrxG6iT9kg5Lv/tAHbWfb09e4RSsJFcyhHgzKNgpXADxD/ujroOE5gdjBbGKtaFMGzeGIC6iVqSJp9nhdMvg0rCFL/YJp6JPAZF9kigR/a07Xt2OQg9NKPr3XKv6AKYBGGs3WE0rHwFs3dkbASCWmThEOnXOUj/VeQcIluDa3s778Vl3lgDSClLoRFQrYbCiUWXVU0iXkU++lhXHWE+cZSuYnOuRGYzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/odxoGQr85hyH6HOftwOJXG192Bh/ocEjHBJeWLR3I=;
 b=NDlEP7kG2/A5ak3H7VHBiWZGNiA/fRN+YE/RB0xWaZ3YsVu/WpNQ8txgm08Rw9vLMHrRRUdsIgbPmn4gJE/5ZMr+tm3DFU2agL1ESsDy7DJr9+jDtr39gprzmZj20CmD3E2bNrULXH2RFeR8W+ohFu2MEEA4NNRHU0cihuNbDhU=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by BY5PR21MB1394.namprd21.prod.outlook.com (2603:10b6:a03:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.9; Fri, 11 Aug
 2023 19:04:49 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870%5]) with mapi id 15.20.6699.009; Fri, 11 Aug 2023
 19:04:49 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>, jason <jason@zx2c4.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        Anthony Davis <andavis@redhat.com>,
        Mark Heslin <mheslin@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "xiaoyao.li@intel.com" <xiaoyao.li@intel.com>
Subject: RE: [PATCH RESEND v9 1/2] x86/tdx: Retry TDVMCALL_MAP_GPA() when
 needed
Thread-Topic: [PATCH RESEND v9 1/2] x86/tdx: Retry TDVMCALL_MAP_GPA() when
 needed
Thread-Index: AQHZzF/1w2sitW+foU2uZwwF/DQXMK/lcpXA
Date:   Fri, 11 Aug 2023 19:04:49 +0000
Message-ID: <SA1PR21MB133508E0683D75FE281E6BB4BF10A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230811021246.821-1-decui@microsoft.com>
 <20230811021246.821-2-decui@microsoft.com>
 <f6d6cd65-011d-0f94-5db0-de4b2d35207e@intel.com>
In-Reply-To: <f6d6cd65-011d-0f94-5db0-de4b2d35207e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=41f324d9-cc78-46cf-aa0c-92d0465c2661;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-11T18:57:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|BY5PR21MB1394:EE_
x-ms-office365-filtering-correlation-id: 036620be-1739-4a85-6c80-08db9a9dd60c
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pNdm7w09v7ok6qVdhFmPfOeZtg5RdRsAD04CMoZjbQbI3iTcumPjpMRj//Ce2fMiyZLmITcKyfxKlEIohPiLfC7dhKlZsq/j/Y42qh4Jo57IOaJHxIAMne9h1qxP2UgzLBfRQUF66QjQ1Gp0CCyEQ/Kyh0a7i7Ymtl9PqXcJuNZZqxVJN0lVRkQvFjQSs7GI8uD6F/eSht4TXRp5gPof7JhdplzSlcunJlGSzDGJGZLrpqQlzfW74x+XsDc+RciZULpOPFy73v0Eb/1N222BZhNPrh7NVst7mwlCZFH5yE7/Jv2xUCGsBloLM0tVTt8y05BAY+90XBQRvcV2hWHSb3bpJkA4Htde+MVZU2MNcGh9SSJQBZ0cvjdSXmXv99iEiy0rSA+Bp18wpRF937vvi+aPvrjmM6nlUtnmlq0yMOnU+1aZKGN9WOrFrJ+Gh3aGNfbm8tkZXLAEZOZ4spFX5IaR33AJggyl0KwtzrNxZuPZKYWmW7fzDYm6GI9OxstV74RL/XcD659FWKb0UilmmUEJ8UH1oMYSGbY/RY5v4kGNPRufsoFtKICBFBmQXNQ2mm5uc3SbeJtPNvDTUhCcyS8PNAhBg0CzHfQcTjklDH878kmpIGf4ljYqCX2b4MSzZ8NBKcnjlWT2uHFcQmiJfgCsqUuhgvVK2sbWvngVLxAlyh2JIrUokvQ73fbbULP97s8KvMIYrhGICqEO+ZghHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(376002)(396003)(366004)(186006)(451199021)(1800799006)(54906003)(110136005)(478600001)(10290500003)(83380400001)(12101799016)(6506007)(26005)(53546011)(71200400001)(55016003)(82950400001)(7696005)(9686003)(2906002)(38100700002)(82960400001)(7416002)(921005)(38070700005)(8676002)(8936002)(41300700001)(52536014)(5660300002)(122000001)(8990500004)(33656002)(316002)(6636002)(4326008)(86362001)(76116006)(66476007)(64756008)(66446008)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXlnTi9PZGRqV2lFRWFUaEw0ZSsxby91WlRJQXhFb2FZSXA1Q2FUWTE2YTlI?=
 =?utf-8?B?YmNkSzIrcFIwbHZ3WUJsb3NaTTI1MFdyQnZHNktBUUU1Wi9JUGkyVUdGL2xS?=
 =?utf-8?B?RkwwNngvNjlMWklQdEJkZ3ZXZ25GRi9ERTFZRGtURVRxQU53K0hyZmdtQS80?=
 =?utf-8?B?MzZxUHdBUlhDZWlWQnMrRlNQZEhLMDBvMkVLUTk0UHpZTGhKUHprOCtCemZu?=
 =?utf-8?B?emZPQ0NOclcvOVlNUTZ0T2hzbmVkRXlzMDdPMjBySkoxdnBYb1RZYitYRld6?=
 =?utf-8?B?K0hpajRqUFhlNWZuNU8zMVJjd0haMS9ucEEvZlBNUXovaVNiOFlmN1hnN0xQ?=
 =?utf-8?B?c1BrL243TUFzLzMwdDdXUEo1ckNXNkZRQ1NpYmltQ1gxTFRNQ3owUE5iTDQv?=
 =?utf-8?B?V01DU1FNQnFGNXZocHE4SUdMcmZQUURhZGZpZ2U5N2NZUzZXWThuN2hDTkVo?=
 =?utf-8?B?dUdhWWdjM2pOdFZvRm1sbzRXV1kwYTJyS0VvSE16N0c4WWphTnh1Y3FJb0J0?=
 =?utf-8?B?dm53NlB6UitVZUJzVFpmeVJBM0tWMDVxUXdzeVNOcVNtNnF6YjdRdW9qY0hB?=
 =?utf-8?B?Uy85ejJEcWhkc1hJUG9pZWV4b3JLbTZBeEROblpqWkxPblVMNlAwYkxjYjJp?=
 =?utf-8?B?aFJsWVNTZFVad01GbThrcHZBc1AvRDVQUHhuT2J0SjdtSG1JMFR2dXJ1NU4x?=
 =?utf-8?B?THNpOEY2VmFiMEpBdzJ2WnFCRS90VU91Nm9hQnpMTDMzMk5Xc2xaZFNFd2Zt?=
 =?utf-8?B?NTRNUnlRZHNlc2JrR0xZVVRJU0Rta1BTb1oxZXpyL09TTlpXOVZEMWdQaTRV?=
 =?utf-8?B?V2lUc3FNZXRkRG9ib2RYVm0xTVVGSWNzN0lGdGJoWmZ6TzBGRkF2TWVNbE9l?=
 =?utf-8?B?NHh5RHltRmZjdHNmRGF5WVJOOVU5TlZwc3d6Z1ArUm1pUGIwbDhOU3pMaHZF?=
 =?utf-8?B?OG1wZWRUMWplWWY5RDZlcTJUZVp2TU1CNG1uYmgra0lQMWMxRUcrZFpHYjJV?=
 =?utf-8?B?cjRDYTdqbFY1ZXBWaERkSUxadFRmME1BMEVnK01BMXRZUlVSR0lqRkJ1cVJ2?=
 =?utf-8?B?MnFVQWN1ai84bVpqNlJ0alJESnA1em44ckx6QkUzOWdRTmE1dDZwRk1iQ2Rn?=
 =?utf-8?B?ZHRjeURJZFBmaW1qUFVRcjZGcnA4dHloWkh6RzY5QXJxMWwrVDBDKzZFa3U4?=
 =?utf-8?B?OGRSSHZNdzlBNXZXYnVSM0NrRjhuUzhlVGVqcnZSeHJNeTZveEN5MnNZNk4x?=
 =?utf-8?B?d1M2cHRKd1k5bkN3WlhGS2VFbnhiSEN5M0pOWkxrN3hnT01QMjl3dFVOZFVi?=
 =?utf-8?B?cktreWFZcHFla2pnT0doSnNmWHZ3cEhJNzdJa1l5dmZrWnp1TE1GVXdZYTNw?=
 =?utf-8?B?UVpYNHlqSTlsMFAwL2NJejhOYVQwZWxwU2QyK2V5dFlra2k5a2pMNS92WEJV?=
 =?utf-8?B?cFJVY256aGhYTnlVNUVmS1hjTVBtakR4QnBwREdraStPMFlrQXBIam0xZUl0?=
 =?utf-8?B?VkdhaXVyK0daNkNoenpBV2hsZnBBV09DNmlCMEhnUjV4SE5sdlVxMTV5OVpq?=
 =?utf-8?B?QktJVG1WVWVUWU1QNkV2MUt4eG1NSEdWR256WS94RDNWZ0dwWW96QUpheUg1?=
 =?utf-8?B?VzcrSFk0UjdIcTFDbmdqVlF4VUNHcFovYUozWEtWbU1ORVhJY0FLNC80WVJB?=
 =?utf-8?B?bkJxR2ZKL0tYOTZ0S0RXVXJ4WEd3eG1Bbzk1S0p5dElJQUhranR4SlBENVE2?=
 =?utf-8?B?MXpNMmRDOCs5OExGOEROTHAzMDl3VVVTTXBXZ2pIM0pHNEIreWozZzhWaVBr?=
 =?utf-8?B?dVlFNmZrb0ZPVS9DalBvajVBeHhBYnpjSTROL0NmWmdjSVRRRWdVa3IvS0lR?=
 =?utf-8?B?VnJEZUZNY3lRRnZXL2RIOVVQWjlDZmlVSDZGRDRRb1dZdmhtc29zZXdnTFRB?=
 =?utf-8?B?ZzFCcWxRaGx6eWV6VjYyRURhcmJUMUdESGNvOUo0N2NWZGplYVkyV2VFc09v?=
 =?utf-8?B?S2xmOGs3WHZYeWliOUl4YmoxTjBXeWx0cmRtbmRXdmdxampnMXNYSzZ0MzVi?=
 =?utf-8?B?ZW5wTDEyVU1VNitLTzVFcWxUcWdoNDFwTU9XZEFFanJ3RGpmejJIRVFxUDFo?=
 =?utf-8?Q?t9WEhf7SyAxu/BJp8o8PQLZqg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036620be-1739-4a85-6c80-08db9a9dd60c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 19:04:49.4468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YQXJmHF+Wxs07nXZVyUtun5o6l1VZvVn4SdeTvabiS5CmP0xmeMo2BzlQC5r2Z1fngpgdo18rXmlQLnOfQV2yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1394
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIEF1Z3VzdCAxMSwgMjAyMyA3OjI3IEFNDQo+ICBbLi4uXQ0KPiBPbiA4LzEwLzIzIDE5OjEy
LCBEZXh1YW4gQ3VpIHdyb3RlOg0KPiA+IEdIQ0kgc3BlYyBmb3IgVERYIDEuMCBzYXlzIHRoYXQg
dGhlIE1hcEdQQSBjYWxsIG1heSBmYWlsIHdpdGggdGhlIFIxMA0KPiA+IGVycm9yIGNvZGUgPSBU
REcuVlAuVk1DQUxMX1JFVFJZICgxKSwgYW5kIHRoZSBndWVzdCBtdXN0IHJldHJ5IHRoaXMNCj4g
PiBvcGVyYXRpb24gZm9yIHRoZSBwYWdlcyBpbiB0aGUgcmVnaW9uIHN0YXJ0aW5nIGF0IHRoZSBH
UEEgc3BlY2lmaWVkDQo+ID4gaW4gUjExLg0KPiA+DQo+ID4gV2hlbiBhIGZ1bGx5IGVubGlnaHRl
bmVkIFREWCBndWVzdCBydW5zIG9uIEh5cGVyLVYsIEh5cGVyLVYgY2FuIHJldHVybg0KPiA+IHRo
ZSByZXRyeSBlcnJvciB3aGVuIHNldF9tZW1vcnlfZGVjcnlwdGVkKCkgaXMgY2FsbGVkIHRvIGRl
Y3J5cHQgdXAgdG8NCj4gPiAxR0Igb2Ygc3dpb3RsYiBib3VuY2UgYnVmZmVycy4NCj4gDQo+IFRo
aXMgY2hhbmdlbG9nIGlzIG5vdCBncmVhdC4gIEl0IGdpdmVzIHplcm8gYmFja2dyb3VuZCBhbmQg
d2FzdGVzIGJ5dGVzDQo+IG9uIHRlbGxpbmcgbWUgd2hpY2ggcmVnaXN0ZXIgdGhlIGVycm9yIGNv
ZGUgaXMgaW4gKEkgZG9uJ3QgY2FyZSBpbiBhDQo+IGNoYW5nZWxvZykgYW5kIHRoZW4gdXNpbmcg
bWFya2V0aW5nIGZsdWZmIHdvcmRzIGxpa2UgImZ1bGx5IGVubGlnaHRlbmVkIi4NCj4gDQo+IExl
dCdzIHN0aWNrIHRvIHRoZSBmYWN0cywgZ2l2ZSBzb21lIGJhY2tncm91bmQsIGFuZCBhbHNvIGF2
b2lkDQo+IHJlZ3VyZ2l0YXRpbmcgdGhlIEdIQ0ksIGVoPw0KPiANCj4gSG93J3MgdGhpcz8NCg0K
SSBhcHByZWNpYXRlIHRoZSBncmVhdCBjaGFuZ2Vsb2chIFdpbGwgdXNlIHRoaXMgaW4gdjEwLg0K
DQo+IHg4Ni90ZHg6IFJldHJ5IHBhcnRpYWxseS1jb21wbGV0ZWQgcGFnZSBjb252ZXJzaW9uIGh5
cGVyY2FsbHMNCj4gDQo+IFREWCBndWVzdCBtZW1vcnkgaXMgcHJpdmF0ZSBieSBkZWZhdWx0IGFu
ZCB0aGUgVk1NIG1heSBub3QgYWNjZXNzIGl0Lg0KPiBIb3dldmVyLCBpbiBjYXNlcyB3aGVyZSB0
aGUgZ3Vlc3QgbmVlZHMgdG8gc2hhcmUgZGF0YSB3aXRoIHRoZSBWTU0sDQo+IHRoZSBndWVzdCBh
bmQgdGhlIFZNTSBjYW4gY29vcmRpbmF0ZSB0byBtYWtlIG1lbW9yeSBzaGFyZWQgYmV0d2Vlbg0K
PiB0aGVtLg0KPiANCj4gVGhlIGd1ZXN0IHNpZGUgb2YgdGhpcyBwcm90b2NvbCBpbmNsdWRlcyB0
aGUgIk1hcEdQQSIgaHlwZXJjYWxsLiAgVGhpcw0KPiBjYWxsIHRha2VzIGEgZ3Vlc3QgcGh5c2lj
YWwgYWRkcmVzcyByYW5nZS4gIFRoZSBoeXBlcmNhbGwgc3BlYyAoYWthLg0KPiB0aGUgR0hDSSkg
c2F5cyB0aGF0IHRoZSBNYXBHUEEgY2FsbCBpcyBhbGxvd2VkIHRvIHJldHVybiBwYXJ0aWFsDQo+
IHByb2dyZXNzIGluIG1hcHBpbmcgdGhpcyByYW5nZSBhbmQgaW5kaWNhdGUgdGhhdCBmYWN0IHdp
dGggYSBzcGVjaWFsDQo+IGVycm9yIGNvZGUuICBBIGd1ZXN0IHRoYXQgc2VlcyBzdWNoIHBhcnRp
YWwgcHJvZ3Jlc3MgaXMgZXhwZWN0ZWQgdG8NCj4gcmV0cnkgdGhlIG9wZXJhdGlvbiBmb3IgdGhl
IHBvcnRpb24gb2YgdGhlIGFkZHJlc3MgcmFuZ2UgdGhhdCB3YXMgbm90DQo+IGNvbXBsZXRlZC4N
Cj4gDQo+IEh5cGVyLVYgZG9lcyB0aGlzIHBhcnRpYWwgY29tcGxldGlvbiBkYW5jZSB3aGVuIHNl
dF9tZW1vcnlfZGVjcnlwdGVkKCkNCj4gaXMgY2FsbGVkIHRvICJkZWNyeXB0IiBzd2lvdGxiIGJv
dW5jZSBidWZmZXJzIHRoYXQgY2FuIGJlIHVwIHRvIDFHQg0KPiBpbiBzaXplLiAgSXQgaXMgZXZp
ZGVudGx5IHRoZSBvbmx5IFZNTSB0aGF0IGRvZXMgdGhpcywgd2hpY2ggaXMgd2h5DQo+IG5vYm9k
eSBub3RpY2VkIHRoaXMgdW50aWwgbm93Lg0KDQpUaGlzIGNsYXJpZmllcyB0aGUgb2JzY3VyZSAi
d2hlbiBuZWVkZWQiIGluIG15IHZlcnNpb24gYnkgZW1waGFzaXppbmcNCnRoZSAicGFydGlhbCBw
cm9ncmVzcyIuIFRoaXMgYWxzbyBnaXZlcyBuZWNlc3NhcnkgYmFja2dyb3VuZCBpbmZvLiBUaGFu
a3MhDQo=
