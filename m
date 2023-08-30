Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1CF78D28D
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Aug 2023 05:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbjH3DdU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Aug 2023 23:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbjH3DdS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Aug 2023 23:33:18 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021019.outbound.protection.outlook.com [52.101.62.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0E81AE;
        Tue, 29 Aug 2023 20:33:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWTg/fbiKdBZ/PlCpyJajx8gveh1uDUZVddsAPwR9syb/orxmyrt7cFGqKC3+U5lD7CDoWA20gkfwXfr0gz+31YDi4WgYM7ujR0MgE5R1L3pCpkRl4cmFzxPJE0FUvwjT8virnCfINmSH48HJhKywE86xzb4YNQE5XOnGDaB+jUHL/ubZS+BpnkYDjejFD/XUwTcRTc75M5gQoNoPvkTghEGwLv17RUzg+JNdhaNr+m21ysuiJNc0/yrin+Tlgl7VkJQVsXVlmTQbTnxoufdOub/FPhLoLDa2wc4CZ5lHSa6fgLw3AFeY8+Ivs0lcV3ODV+7vyMMPMhihtcEhqRvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OR5v1HzBBUvR2SCzCxOGNcmaffsAIjMVPDlPpHIHL1k=;
 b=Wdd+ABlDMvkE5mwuiBHNxGDSAMTxfOWvZHmStrkvnFfPQ35P9Y5pTr4ttYdquNGKpftDGqmrtZxUgRoPXGUPBqiRnvGjmU7SHWaijBXIkUcvn6HbGHRrOG4EsXmhOakpPBd8j8IzipX2qTQFbEKCT1qZGTwiRGAlbDbOaDMF+Y+XjaotqVDT207FrYCJAfTlxZZ1ScluujsPsiF4KZ1Acxh4uogNYnrAc5IauxMEwVNEkGec/+q8wB6g9WYuF8IHyeZ52kKFUYNGm0LpMM1twCUP4eVNGZSJuaztCrLB70R6NirqESgB0tHNbNXKUZRvzzqESrcr2eTe19WYZ/9Rew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OR5v1HzBBUvR2SCzCxOGNcmaffsAIjMVPDlPpHIHL1k=;
 b=iN2g7GNLShIkJmUPfYwfYsevjPq8VmJ6lTGYMpxqDpuF1HD3U5nZC8HTlddVvcfraNcpia1q6PQOGWIqrlndXTtjqrCgL+al/tSbKLnPlvuvjyQKB2sVzg5GDp7OZyELF5vyBz6BuB3q6cosQR3tZ1OLXeZeU+sQ2MkN9ONI/PY=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CH2PR21MB1384.namprd21.prod.outlook.com (2603:10b6:610:8c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.9; Wed, 30 Aug
 2023 03:33:11 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f%5]) with mapi id 15.20.6768.009; Wed, 30 Aug 2023
 03:33:11 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [RFC PATCH 1/1] x86/mm: Mark CoCo VM pages invalid while moving
 between private and shared
Thread-Topic: [RFC PATCH 1/1] x86/mm: Mark CoCo VM pages invalid while moving
 between private and shared
Thread-Index: AQHZsCj16DTf9qLclEez7by16vQ1nrACSkgAgAAqDJA=
Date:   Wed, 30 Aug 2023 03:33:11 +0000
Message-ID: <BYAPR21MB168893B4667A5320AC48904DD7E6A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1688661719-60329-1-git-send-email-mikelley@microsoft.com>
 <28cfc19ac3171c270896d080f30aeda11b587bb8.camel@intel.com>
In-Reply-To: <28cfc19ac3171c270896d080f30aeda11b587bb8.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=84f2eb3d-afbf-4b19-9340-cb4eb85015a6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-30T02:33:13Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CH2PR21MB1384:EE_
x-ms-office365-filtering-correlation-id: 95628ed2-9715-4a2e-4bf4-08dba909d5f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Mzpg/Rp8VwINokO1wwrW71HkhalqFwW8ts0yR2NOFOoI9ni5cijXbV6R05h4+tTz5uS332b9kXWJgsSPo3R7Cvx/8ZYGbtaOCYZD5s6rceZuYqCiEGNNd++adbw64fEHsHLBRa8DF8vYXc01qXcc3V6s0EBpFYqnBpxHCE+AiFix7glUdl4/oEGvfn78rbCa43YVC8bj8RenQyaq4vqTcyZN5v3fc7hMTeaDVYr+V31smt/g+YqC4QiXd0py6rwLhdLClMtmhGyXTt7Uw/s9Hv1a+4hjYDN+BIbw0rvg0mZPyhX4m+dC/nIIKUPERltMl17YtCXI/1YHrSr3lzAJZYPEFl0sznMtE3OC+PyVvJ2DcLhHHr9Oa3/8DX56Z7e9OQxvkO6etUd1tUc24i1D/eA2JpzguCov8ARVmquqbHSxHF9vA5mZ0VtahdzwK7P9x1s8+gWNxEOnmaoy2wrCpFSxV9RXVKb6KiOvoLTqwMqn54rcYKzPVc5t0D11ufb+FG7NGw1sFkhCcDCL3mGHTwqL1ATKpGIO2Vwz+2LeJ7Oe1k7vhqhD8SDMf/tpz7qQmdVsIFluRwYezW1Ix4d5vEDL3ga6o87RMXEppLl2ynuC3zRk3uZyCdh4nlyes0AeWYDhSL8nhscArSsEZDnVg3N8O47gBXoiHQG97E3O9E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(396003)(376002)(136003)(366004)(346002)(39860400002)(186009)(1800799009)(451199024)(41300700001)(7416002)(82960400001)(82950400001)(921005)(122000001)(71200400001)(38100700002)(38070700005)(86362001)(33656002)(10290500003)(478600001)(966005)(83380400001)(8990500004)(26005)(9686003)(6506007)(7696005)(55016003)(76116006)(66446008)(66476007)(66556008)(64756008)(2906002)(110136005)(66946007)(316002)(8676002)(8936002)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnRwYjdzS1BQWjRHU1ROT0t1WkxNZ3JCdTdmemlqNmN1Yno3STU4UXRQVDBQ?=
 =?utf-8?B?R01aMXN1UitxMDhMMytpN3pwUittMkxsODZKNHdqZGkzZ09vTThxZk5ldXg3?=
 =?utf-8?B?bGlYLzdweEFUcG5kbFM1ZlFKd0lUU3hXaUl1ZjlnMWRuc0o5dDRuSXVFSU1P?=
 =?utf-8?B?T3lnekIrQ0R5cGJIL1MxRnREbDk2WUw4bXhwRzhFWVdEYzhhN2lINDJaUlVG?=
 =?utf-8?B?b09kSEhhWGhzS0FDWEpKZmpiNURiMnNzT0prWGJhTUtjR1NHL2ozM3dmUVl4?=
 =?utf-8?B?c1RYa1ZVUVM4d3hZZXNodUpvdFNBOEZ0eDRSd1BhdWpnWkdXczdydnJoM0JW?=
 =?utf-8?B?a0hRQmlWUmJkaUFIek5mVHd3N0JiUmpoQll4SnQvU0Z6Z0w3eFN6Uk05Qy9K?=
 =?utf-8?B?VHlMOTRVWVpWSUQzSDk3QUtOUmJaR3AyZVJMOVJ6NTZKUlJCbTZPbU1oYWpv?=
 =?utf-8?B?SHRQMjRTaTI3cUpQc3J0NE5oNE9WTHJmcWJaSDN5bnRvN2FLVnNIWVhqK1E5?=
 =?utf-8?B?Si9TUWNaYVBnY2JMNy9NL1RNaVM4VFBmTGIySUhxVElHUUtvc3pKOHNELzVG?=
 =?utf-8?B?MlBxWFpRNThqM2N1eDAxY1k1NDA2UCt1NlB2VDBTN1M2Ry9JU09nK3cxeWdv?=
 =?utf-8?B?RWZaV3F1dkZQMEdhSFdMbWJUaUFkRlFFVWt1M3dlbC91UU93SnMyaG5jbkpS?=
 =?utf-8?B?Q291QUdjV0hVbUZ1WjdXU1gvZEhwN3AwbHpxelUvSXRmdjF4UTJaZHUzVk5J?=
 =?utf-8?B?b1pjREsxYW5Mb0pkRHhkRVQ5aExrTnQreWtpaFpZMytraENsOHQ0RGoyRmpP?=
 =?utf-8?B?Z0VFUkQ0eC9rYXplNGk3WVFGNlRROWxMR0MzRks0N0V2ZWcyeUt0N0U0V0VM?=
 =?utf-8?B?OHEzaWdCenZMNUxnZ3I4VjNpWFdpcUhNbERSV2I1RitLMXpZSEthYTMveUhC?=
 =?utf-8?B?TlZVSDRwbXVVcTE5UnhYcTBGZlFRN0UxbHhDYXNzc2ZNL1hzQ1FZbkpYZXIz?=
 =?utf-8?B?eTJMakR1TDhNU3lhQlNQRE1CajhYcElPZGJpbGZSSVN3VHZnbS81ZHllSVZw?=
 =?utf-8?B?ZytjYXJnTmFiOVFVdVE5K0VCS1lTT25JbEtJY1dmWTVYQ1dpVnFCZTVuYWIr?=
 =?utf-8?B?bWxNTDI4UEZtSlQ2Vjh0bU12TFljMElmR0JzaktNZWhRQnBsVnNFenJNMVBp?=
 =?utf-8?B?dmRzL2RjdTV2KzluRlp2eVY3aURROGlzRHhkdThSQm5VRmljYW1vcVlkQUFq?=
 =?utf-8?B?OVVCNHlIdkNuVnUvQ2loZVZkRVBPUXAzSTM2RENkNHhnTXFMTEtRMXNBd05G?=
 =?utf-8?B?ek93cXUzZldoK2dJWmtEWEJreDBnb3ZzZko1OWpCOEdWaVk3cnRaS1RFbGVi?=
 =?utf-8?B?eGZLam1BQzQ2S0dBYlBpRUJ0Q3c1QlVQT1F1VUlUZk9sNmR0aUR4Y25WWXZM?=
 =?utf-8?B?TlJqdW4rUy9TMVQzVjV6ZGt4SWovM3N3RENRM2NzeVFkZjVHdlFwV3pzakps?=
 =?utf-8?B?TDVzQ0FLUXluTzFvSmE4NTZ1Q2dVM1Nta3ViV251dGVWd0NtZnA0Nnp4QU0v?=
 =?utf-8?B?M2FHZTRnRm1UcXJOd1Z0ZWV1MkJ1S2YvQ1c3LytDQnJFNGdMR25INkliQTZE?=
 =?utf-8?B?L0paVGJzelJlTWhzRlErUjExTmhodXJxc1NuSkFnek54SGp5d2N4a21OWHQ4?=
 =?utf-8?B?clVJcVZpM1dJQzdwbEt0Vk9KUzZXRzJUUnJUWFkwcVQ4TE9STlpoMk1abUZw?=
 =?utf-8?B?amdha2xQS0l2RXZnTmFKY0ZqeVpPdlJtaW5sWEUxWithQTRGWGo3QlQyRVdI?=
 =?utf-8?B?a2RUSklDKytQenNZUVQ0VnlsVHFYR003alZyKzVMMkkrenFLWllpdHE5VHlz?=
 =?utf-8?B?TXl5L0xiVExQSFFxZUlsaTBXNmNoeDM5dmxYbzlLMDRZaHcvQURKVXlsM2xV?=
 =?utf-8?B?RnQ5NG5wSEpsRlBGeGFXZlNHT0FFMFBGUE11bDdvajl5eGF0bzlnMEFQYWFr?=
 =?utf-8?B?d2ZLTDRCS2w2WTYvSW9yWHF5QzQ5cENwRDVDWUlqWHNkdGRSck0xOWJGWHV5?=
 =?utf-8?B?UnpOMjlwRmphZW12MEdpekFDMkw2dG8xVXhWVVdMWEtQN3RKdERJMnYwZzZj?=
 =?utf-8?B?eURrQXFBRXZ2aW1NWUJIZjhoMHFWUHB5Tm9tMGtMODFGWVBKTG9EL1FaaU9T?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95628ed2-9715-4a2e-4bf4-08dba909d5f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 03:33:11.2326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q1pyhxvNvN4znKt3thGgpAOsEYALW+bOxhbQ0FSE7a2wL2ayBbgzRnWDxJ7CXyWdvGiYexbvItE0dhOxUqqcA2ztCNATqGVsVJ+o8rfWiLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogRWRnZWNvbWJlLCBSaWNrIFAgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPiBTZW50
OiBUdWVzZGF5LCBBdWd1c3QgMjksIDIwMjMgNTowMyBQTQ0KPiANCj4gT24gVGh1LCAyMDIzLTA3
LTA2IGF0IDA5OjQxIC0wNzAwLCBNaWNoYWVsIEtlbGxleSB3cm90ZToNCj4gPiBJbiBhIENvQ28g
Vk0gd2hlbiBhIHBhZ2UgdHJhbnNpdGlvbnMgZnJvbSBwcml2YXRlIHRvIHNoYXJlZCwgb3Igdmlj
ZQ0KPiA+IHZlcnNhLCBhdHRyaWJ1dGVzIGluIHRoZSBQVEUgbXVzdCBiZSB1cGRhdGVkICphbmQq
IHRoZSBoeXBlcnZpc29yIG11c3QNCj4gPiBiZSBub3RpZmllZCBvZiB0aGUgY2hhbmdlLiBCZWNh
dXNlIHRoZXJlIGFyZSB0d28gc2VwYXJhdGUgc3RlcHMsIHRoZXJlJ3MNCj4gPiBhIHdpbmRvdyB3
aGVyZSB0aGUgc2V0dGluZ3MgYXJlIGluY29uc2lzdGVudC7CoCBOb3JtYWxseSB0aGUgY29kZSB0
aGF0DQo+ID4gaW5pdGlhdGVzIHRoZSB0cmFuc2l0aW9uICh2aWEgc2V0X21lbW9yeV9kZWNyeXB0
ZWQoKSBvcg0KPiA+IHNldF9tZW1vcnlfZW5jcnlwdGVkKCkpIGVuc3VyZXMgdGhhdCB0aGUgbWVt
b3J5IGlzIG5vdCBiZWluZyBhY2Nlc3NlZA0KPiA+IGR1cmluZyBhIHRyYW5zaXRpb24sIHNvIHRo
ZSB3aW5kb3cgb2YgaW5jb25zaXN0ZW5jeSBpcyBub3QgYSBwcm9ibGVtLg0KPiA+IEhvd2V2ZXIs
IHRoZSBsb2FkX3VuYWxpZ25lZF96ZXJvcGFkKCkgZnVuY3Rpb24gY2FuIHJlYWQgYXJiaXRyYXJ5
IG1lbW9yeQ0KPiA+IHBhZ2VzIGF0IGFyYml0cmFyeSB0aW1lcywgd2hpY2ggY291bGQgYWNjZXNz
IGEgdHJhbnNpdGlvbmluZyBwYWdlIGR1cmluZw0KPiA+IHRoZSB3aW5kb3cuwqAgSW4gc3VjaCBh
IGNhc2UsIENvQ28gVk0gc3BlY2lmaWMgZXhjZXB0aW9ucyBhcmUgdGFrZW4NCj4gPiAoZGVwZW5k
aW5nIG9uIHRoZSBDb0NvIGFyY2hpdGVjdHVyZSBpbiB1c2UpLsKgIEN1cnJlbnQgY29kZSBpbiB0
aG9zZQ0KPiA+IGV4Y2VwdGlvbiBoYW5kbGVycyByZWNvdmVycyBhbmQgZG9lcyAiZml4dXAiIG9u
IHRoZSByZXN1bHQgcmV0dXJuZWQgYnkNCj4gPiBsb2FkX3VuYWxpZ25lZF96ZXJvcGFkKCkuwqAg
VW5mb3J0dW5hdGVseSwgdGhpcyBleGNlcHRpb24gaGFuZGxpbmcgYW5kDQo+ID4gZml4dXAgY29k
ZSBpcyB0cmlja3kgYW5kIHNvbWV3aGF0IGZyYWdpbGUuwqAgQXQgdGhlIG1vbWVudCwgaXQgaXMN
Cj4gPiBicm9rZW4gZm9yIGJvdGggVERYIGFuZCBTRVYtU05QLg0KPiA+DQo+ID4gVGhlcmUncyBh
bHNvIGEgcHJvYmxlbSB3aXRoIHRoZSBjdXJyZW50IGNvZGUgaW4gcGFyYXZpc29yIHNjZW5hcmlv
czoNCj4gPiBURFggUGFydGl0aW9uaW5nIGFuZCBTRVYtU05QIGluIHZUT00gbW9kZS4gVGhlIGV4
Y2VwdGlvbnMgbmVlZA0KPiA+IHRvIGJlIGZvcndhcmRlZCBmcm9tIHRoZSBwYXJhdmlzb3IgdG8g
dGhlIExpbnV4IGd1ZXN0LCBidXQgdGhlcmUNCj4gPiBhcmUgbm8gYXJjaGl0ZWN0dXJhbCBzcGVj
cyBmb3IgaG93IHRvIGRvIHRoYXQuDQo+ID4NCj4gPiBUbyBhdm9pZCB0aGVzZSBjb21wbGV4aXRp
ZXMgb2YgdGhlIENvQ28gZXhjZXB0aW9uIGhhbmRsZXJzLCBjaGFuZ2UNCj4gPiB0aGUgY29yZSB0
cmFuc2l0aW9uIGNvZGUgaW4gX19zZXRfbWVtb3J5X2VuY19wZ3RhYmxlKCkgdG8gZG8gdGhlDQo+
ID4gZm9sbG93aW5nOg0KPiA+DQo+ID4gMS7CoCBSZW1vdmUgYWxpYXNpbmcgbWFwcGluZ3MNCj4g
PiAyLsKgIFJlbW92ZSB0aGUgUFJFU0VOVCBiaXQgZnJvbSB0aGUgUFRFcyBvZiBhbGwgdHJhbnNp
dGlvbmluZyBwYWdlcw0KPiA+IDMuwqAgRmx1c2ggdGhlIFRMQiBnbG9iYWxseQ0KPiA+IDQuwqAg
Rmx1c2ggdGhlIGRhdGEgY2FjaGUgaWYgbmVlZGVkDQo+ID4gNS7CoCBTZXQvY2xlYXIgdGhlIGVu
Y3J5cHRpb24gYXR0cmlidXRlIGFzIGFwcHJvcHJpYXRlDQo+ID4gNi7CoCBOb3RpZnkgdGhlIGh5
cGVydmlzb3Igb2YgdGhlIHBhZ2Ugc3RhdHVzIGNoYW5nZQ0KPiA+IDcuwqAgQWRkIGJhY2sgdGhl
IFBSRVNFTlQgYml0DQo+ID4NCj4gPiBXaXRoIHRoaXMgYXBwcm9hY2gsIGxvYWRfdW5hbGlnbmVk
X3plcm9wYWQoKSBqdXN0IHRha2VzIGl0cyBub3JtYWwNCj4gPiBwYWdlLWZhdWx0LWJhc2VkIGZp
eHVwIHBhdGggaWYgaXQgdG91Y2hlcyBhIHBhZ2UgdGhhdCBpcyB0cmFuc2l0aW9uaW5nLg0KPiA+
IEFzIGEgcmVzdWx0LCBsb2FkX3VuYWxpZ25lZF96ZXJvcGFkKCkgYW5kIENvQ28gVk0gcGFnZSB0
cmFuc2l0aW9uaW5nDQo+ID4gYXJlIGNvbXBsZXRlbHkgZGVjb3VwbGVkLsKgIENvQ28gVk0gcGFn
ZSB0cmFuc2l0aW9ucyBjYW4gcHJvY2VlZA0KPiA+IHdpdGhvdXQgbmVlZGluZyB0byBoYW5kbGUg
YXJjaGl0ZWN0dXJlLXNwZWNpZmljIGV4Y2VwdGlvbnMgYW5kIGZpeA0KPiA+IHRoaW5ncyB1cC4g
VGhpcyBkZWNvdXBsaW5nIHJlZHVjZXMgdGhlIGNvbXBsZXhpdHkgZHVlIHRvIHNlcGFyYXRlDQo+
ID4gVERYIGFuZCBTRVYtU05QIGZpeHVwIHBhdGhzLCBhbmQgZ2l2ZXMgbW9yZSBmcmVlZG9tIHRv
IHJldmlzZSBhbmQNCj4gPiBpbnRyb2R1Y2UgbmV3IGNhcGFiaWxpdGllcyBpbiBmdXR1cmUgdmVy
c2lvbnMgb2YgdGhlIFREWCBhbmQgU0VWLVNOUA0KPiA+IGFyY2hpdGVjdHVyZXMuIFBhcmF2aXNv
ciBzY2VuYXJpb3Mgd29yayBwcm9wZXJseSB3aXRob3V0IG5lZWRpbmcNCj4gPiB0byBmb3J3YXJk
IGV4Y2VwdGlvbnMuDQo+ID4NCj4gPiBUaGlzIGFwcHJvYWNoIG1heSBtYWtlIF9fc2V0X21lbW9y
eV9lbmNfcGd0YWJsZSgpIHNsaWdodGx5IHNsb3dlcg0KPiA+IGJlY2F1c2Ugb2YgdG91Y2hpbmcg
dGhlIFBURXMgdGhyZWUgdGltZXMgaW5zdGVhZCBvZiBqdXN0IG9uY2UuIEJ1dA0KPiA+IHRoZSBy
dW4gdGltZSBvZiB0aGlzIGZ1bmN0aW9uIGlzIGFscmVhZHkgZG9taW5hdGVkIGJ5IHRoZSBoeXBl
cmNhbGwNCj4gPiBhbmQgdGhlIG5lZWQgdG8gZmx1c2ggdGhlIFRMQiBhdCBsZWFzdCBvbmNlIGFu
ZCBtYXliZSB0d2ljZS4gSW4gYW55DQo+ID4gY2FzZSwgdGhpcyBmdW5jdGlvbiBpcyBvbmx5IHVz
ZWQgZm9yIENvQ28gVk0gcGFnZSB0cmFuc2l0aW9ucywgYW5kDQo+ID4gaXMgYWxyZWFkeSB1bnN1
aXRhYmxlIGZvciBob3QgcGF0aHMuDQo+IA0KPiBFeGNsdWRpbmcgdm1fdW5tYXBfYWxpYXNlcygp
LCBhbmQganVzdCBsb29raW5nIGF0IHRoZSBUTEIgZmx1c2hlcywgaXQNCj4ga2luZCBvZiBsb29r
cyBsaWtlIHRoaXM6DQo+IDEuIENsZWFyIHByZXNlbnQNCj4gMi4gVExCIGZsdXNoDQo+IDMuIFNl
dCBDIGJpdA0KDQpUaGlzIHN0ZXAgaXMgZWl0aGVyICJzZXQgQyBiaXQiIG9yICJjbGVhciBDIGJp
dCIsIGRlcGVuZGluZyBvbiB3aGV0aGVyDQp0aGUgdHJhbnNpdGlvbiBpcyBmcm9tIHNoYXJlZC0+
cHJpdmF0ZSwgb3IgcHJpdmF0ZS0+c2hhcmVkLg0KDQo+IDQuIFNldCBQcmVzZW50IGJpdA0KPiA1
LiBUTEIgZmx1c2gNCg0KSSB3YXMgb3JpZ2luYWxseSB0aGlua2luZyB0aGF0IHNldF9tZW1vcnlf
cCgpIHdvdWxkIGJlIHNtYXJ0DQplbm91Z2ggdG8gcmVhbGl6ZSB0aGF0IGp1c3Qgc2V0dGluZyB0
aGUgUFJFU0VOVCBiaXQgZG9lc24ndA0KcmVxdWlyZSBmbHVzaGluZyB0aGUgVExCLiAgQnV0IGxv
b2tpbmcgYXQgdGhlIGNvZGUgbm93LCB0aGF0J3MNCndyb25nLiAgX19jaGFuZ2VfcGFnZV9hdHRy
KCkgd2lsbCBzZXQgdGhlIENQQV9GTFVTSFRMQiBmbGFnDQpldmVuIHdoZW4gdGhlIG9ubHkgY2hh
bmdlIGlzIHRvIHNldCB0aGUgUFJFU0VOVCBiaXQuDQpjaGFuZ2VfcGFnZV9hdHRyX3NldF9jbHIo
KSB3aWxsIHRoZW4gYWN0IG9uIHRoZSBDUEFfRkxVU0hUTEINCmZsYWcgYW5kIGRvIHRoZSBmbHVz
aC4NCg0KPiANCj4gQnV0IGlmIHlvdSBpbnN0ZWFkIGRpZDoNCj4gMS4gQ2xlYXIgUHJlc2VudCBh
bmQgc2V0IEMgYml0DQoNCkludGVyZXN0aW5nIGlkZWEuICAgQXMgbm90ZWQgYWJvdmUsIGl0IGNv
dWxkIGJlIGVpdGhlcg0Kc2V0dGluZyBvciBjbGVhcmluZyB0aGUgQyBiaXQuICAgQ3VycmVudGx5
IHRoZXJlIGFyZSBzb21lIHRoaW5ncw0KZG9uZSBiZWZvcmUgdGhlIEMgYml0IHNldC9jbGVhciwg
c3VjaCBhcyBmbHVzaGluZyB0aGUgZGF0YQ0KY2FjaGUgb24gVERYLiAgSSBkb24ndCBmdWxseSB1
bmRlcnN0YW5kIHRoYXQgcmVxdWlyZW1lbnQsIHNvDQpJJ20gbm90IHN1cmUgb2YgaXRzIGFjdHVh
bCBzZXF1ZW5jaW5nIG5lZWRzLiAgSG9wZWZ1bGx5DQpzb21lb25lIHdpdGggVERYIGV4cGVydGlz
ZSBjYW4gY2xhcmlmeS4gIFRoZSBjdXJyZW50DQpjb2RlIGFsc28gYWxsb3dzIGNhbGxiYWNrcyBw
cmUgYW5kIHBvc3Qgc2V0L2NsZWFyIG9mIHRoZQ0KQyBiaXQsIHRob3VnaCBJIHdhcyBjb25zaWRl
cmluZyBzaW1wbGlmeWluZyB0byBvbmx5DQpoYXZpbmcgYSBwb3N0IGNhbGxiYWNrLg0KDQo+IDIu
IFRMQiBmbHVzaA0KPiAzLiBTZXQgUHJlc2VudCBiaXQgKG5vIGZsdXNoKQ0KDQpJJ2xsIGxvb2sg
YXQgd2hldGhlciB0aGVyZSdzIGEgd2F5IHRvIHByZXZlbnQgdGhlIGZsdXNoDQp3aXRob3V0IGNy
ZWF0aW5nIGFuIGFsdGVybmF0ZSB2ZXJzaW9uIG9mDQpjaGFuZ2VfcGFnZV9hdHRyX3NldF9jbHIo
KS4gICBNYXliZSBzZXRfbWVtb3J5X3AoKQ0KY291bGQgcGFzcyBpbiBhIG5ldyBDUEFfTk9fRkxV
U0hUTEIgZmxhZyB0aGF0DQpvdmVycmlkZXMgQ1BBX0ZMVVNIVExCLg0KDQpJbiB0aGUgYmlnZ2Vy
IHBpY3R1cmUsIHRoZSBwZXJmb3JtYW5jZSBvZiB0aGVzZQ0KcHJpdmF0ZTwtPnNoYXJlZCB0cmFu
c2l0aW9ucyBpcyBkb21pbmF0ZWQgYnkgdGhlDQpoeXBlcmNhbGxzIHRvIHN5bmMgdGhpbmdzIHdp
dGggdGhlIGh5cGVydmlzb3IuICBUaGUgTGludXgNCm1hbmlwdWxhdGlvbiBvZiB0aGUgUFRFcyBp
cyBhIHNlY29uZCBvcmRlciBjb3N0LCB0aG91Z2gNCnRoZSBUTEIgZmx1c2hlcyBhcmUgbW9yZSBl
eHBlbnNpdmUuICBJdCBtaWdodCBiZSB3b3J0aA0Kc29tZSBlZmZvcnQgdG8gYXZvaWQgdGhlIGV4
dHJhIFRMQiBmbHVzaC4NCg0KPiANCj4gVGhlbiB5b3UgY291bGQgc3RpbGwgaGF2ZSBvbmx5IDEg
VExCIGZsdXNoIGFuZCAyIG9wZXJhdGlvbnMgaW5zdGVhZCBvZg0KPiAzLiBPdGhlcndpc2UgaXQn
cyB0aGUgc2FtZSBsb2FkX3VuYWxpZ25lZF96ZXJvcGFkKCkgYmVuZWZpdHMgeW91IGFyZQ0KPiBs
b29raW5nIGZvciBJIHRoaW5rLiBCdXQgSSdtIG5vdCB2ZXJ5IGVkdWNhdGVkIG9uIHRoZSBwcml2
YXRlPC0+c2hhcmVkDQo+IGNvbnZlcnNpb24gSFcgcnVsZXMgdGhvdWdoLCBzbyBtYXliZSBub3Qu
DQoNCkVsaW1pbmF0aW5nIHRoZSBUTEIgZmx1c2ggYWZ0ZXIgc2V0dGluZyB0aGUgUFJFU0VOVCBi
aXQgc2VlbXMNCndvcnRod2hpbGUuICBJJ20gbGVzcyBzdXJlIGFib3V0IGNvbWJpbmcgdGhlIGNs
ZWFyaW5nIG9mDQpQUkVTRU5UIGFuZCB0aGUgQyBiaXQgc2V0L2NsZWFyLiAgV2UgbWlnaHQgd2Fu
dCB0byBrZWVwDQpib3RoIHRoZSBwcmUgYW5kIHBvc3QgY2FsbGJhY2tzIGZvciBmdXR1cmUgZmxl
eGliaWxpdHkgaW4gaG93DQp0aGUgaHlwZXJ2aXNvciBpbiBpbnZva2VkLiAgSW4gdGhhdCBjYXNl
IHRoZSBwcmUgY2FsbGJhY2sNCm5lZWRzIHRvIGJlIGRvbmUgYmV0d2VlbiBjbGVhcmluZyBQUkVT
RU5UIGFuZCB0aGUgQw0KYml0IHNldC9jbGVhciBvcGVyYXRpb24sIGFuZCBzbyB0aGV5IHdvdWxk
IG5lZWQgdG8gc3RheQ0Kc2VwYXJhdGUuICBBcyBJIHNhaWQgcHJldmlvdXNseSwgdGhlIG1hbmlw
dWxhdGlvbiBvZiB0aGUNClBURXMgaXMgbm90IGEgc2lnbmlmaWNhbnQgY29zdCBpbiB0aGUgYmln
IHBpY3R1cmUuDQoNCj4gDQo+ID4NCj4gPiBUaGUgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIGNhbGxi
YWNrIGZ1bmN0aW9uIGZvciBub3RpZnlpbmcgdGhlDQo+ID4gaHlwZXJ2aXNvciB0eXBpY2FsbHkg
bXVzdCB0cmFuc2xhdGUgZ3Vlc3Qga2VybmVsIHZpcnR1YWwgYWRkcmVzc2VzDQo+ID4gaW50byBn
dWVzdCBwaHlzaWNhbCBhZGRyZXNzZXMgdG8gcGFzcyB0byB0aGUgaHlwZXJ2aXNvci7CoCBCZWNh
dXNlDQo+ID4gdGhlIFBURXMgYXJlIGludmFsaWQgYXQgdGhlIHRpbWUgb2YgY2FsbGJhY2ssIHRo
ZSBjb2RlIGZvciBkb2luZyB0aGUNCj4gPiB0cmFuc2xhdGlvbiBuZWVkcyB1cGRhdGluZy7CoCB2
aXJ0X3RvX3BoeXMoKSBvciBlcXVpdmFsZW50IGNvbnRpbnVlcw0KPiA+IHRvIHdvcmsgZm9yIGRp
cmVjdCBtYXAgYWRkcmVzc2VzLsKgIEJ1dCB2bWFsbG9jIGFkZHJlc3NlcyBjYW5ub3QgdXNlDQo+
ID4gdm1hbGxvY190b19wYWdlKCkgYmVjYXVzZSB0aGF0IGZ1bmN0aW9uIHJlcXVpcmVzIHRoZSBs
ZWFmIFBURSB0byBiZQ0KPiA+IHZhbGlkLiBJbnN0ZWFkLCBzbG93X3ZpcnRfdG9fcGh5cygpIG11
c3QgYmUgdXNlZC4gQm90aCBmdW5jdGlvbnMNCj4gPiBtYW51YWxseSB3YWxrIHRoZSBwYWdlIHRh
YmxlIGhpZXJhcmNoeSwgc28gcGVyZm9ybWFuY2UgaXMgdGhlIHNhbWUuDQo+IA0KPiBKdXN0IGN1
cmlvdXMuIEFyZSB2bWFsbG9jIGFkZHJlc3NlcyBzdXBwb3J0ZWQgaGVyZT8gSXQgbG9va3MgbGlr
ZSBpbg0KPiBTRVYsIGJ1dCBub3QgVERYLg0KDQpEZXh1YW4gQ3VpIGhhcyBhIHNlcGFyYXRlIHBh
dGNoIHRvIHN1cHBvcnQgdm1hbGxvYyBhZGRyZXNzIGluIFREWC4NClNlZSBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9sa21sLzIwMjMwODExMjE0ODI2Ljk2MDktMy1kZWN1aUBtaWNyb3NvZnQuY29t
Lw0KDQpUaGFua3MgZm9yIGxvb2tpbmcgYXQgdGhpcyAuLi4NCg0KTWljaGFlbA0K
