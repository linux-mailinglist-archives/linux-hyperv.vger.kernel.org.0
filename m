Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A91681539
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jan 2023 16:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbjA3Pj2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 30 Jan 2023 10:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjA3Pj1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 30 Jan 2023 10:39:27 -0500
Received: from BN6PR00CU002-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11021019.outbound.protection.outlook.com [52.101.57.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDC23E600;
        Mon, 30 Jan 2023 07:39:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDnlilA6vUbxSdIFotD9z13yd2SkAyLbNvqQ3McP4JYhGCih/XjbO/w3CKN3lWK4gMx8V3j0QybnvR+qg1c8SmsqthTHTdRApwnmZwT46otYqiRKmFi4QB89SalhSd+L2ykbrRSy59YiW9JJluLw1bldO8vOHVr9dEeKeXxO447akUco8p8u4Y53ZTF0h+LL+Hn6DH2H5Ig/aRh6EdAPX0czwfjpo83h4QyRyEJcbAEhkOjH2AfYjSsmg/M+3xo54Z3IuBjSE+oBfFkbuPvQTyeJE0gXWwA6M3LhL/OKX0M+frj1fVpci2/2yeiTpo7zc7rifeVCxrAeOEHPGotanw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hibT4sb/cePRDUzzc7KChH33HGFKdNo9hrit6l7ztmg=;
 b=IKC6Ow2zaITWEvm0G989n1kloWwujMXtDNkPC3jG7f7ZTT9SsfEgyEH+bPF5PL6V0KQTDj5LZoc6o5wT51NA5OYGEqON3KZOeiH3kXFWF3dO0KyLFLXIYDNwRMeZwLVBpcNptkRsaOqukyEYUOgT2kwjtT6k9AL/A7TmCXFZ+3QOyGFECOHQv3sdo+ilxR0zo/B4YQBL2Rmp1icpJY5gY6UZK5DrahIev/WzVkYDKHIMGuEMITklnhq2cERGXgnBBzyZKoJOT4tm2iDoGr3dEDGsFsF0/TI4tfSaIG7TtTJkx34IGNNQ3vr1esLzVFHwNG+uyg6vI1HsBXWyw6dlyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hibT4sb/cePRDUzzc7KChH33HGFKdNo9hrit6l7ztmg=;
 b=Kx+oJHtjBD+cG1UwHJrFpU9bBBYoNXQHr8/sFP8WeM6hAn05oLo/6J2WxGUgYOYh/FC68oLD70LhiIii19Xi/v32Ewp7kGJf6iRbRfxhhDsDUgUnQw+te2mlVorbWTRdUejcuLx5zdujq+sBR4rBrGT8kw17y4+ancCyDH9tebU=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB1925.namprd21.prod.outlook.com (2603:10b6:510:17::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.4; Mon, 30 Jan
 2023 15:39:19 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e%6]) with mapi id 15.20.6064.019; Mon, 30 Jan 2023
 15:39:19 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: RE: [RFC PATCH v1 2/6] x86/sev: Add support for NestedVirtSnpMsr
Thread-Topic: [RFC PATCH v1 2/6] x86/sev: Add support for NestedVirtSnpMsr
Thread-Index: AQHZL0r/KNWEXk3zxkasAsVKYGsRxq60P52QgALgF4CAAAMXsA==
Date:   Mon, 30 Jan 2023 15:39:19 +0000
Message-ID: <BYAPR21MB1688EC3B7167A0C2E821D435D7D39@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230123165128.28185-1-jpiotrowski@linux.microsoft.com>
 <20230123165128.28185-3-jpiotrowski@linux.microsoft.com>
 <SN6PR2101MB169362990E4BB621A5A27D13D7CD9@SN6PR2101MB1693.namprd21.prod.outlook.com>
 <20230130152555.GB27645@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20230130152555.GB27645@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=42d7235b-2bfc-4ab1-bb68-d41fd8e5f891;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-30T15:36:58Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB1925:EE_
x-ms-office365-filtering-correlation-id: f47fbf6a-2a80-45d3-fe6e-08db02d82704
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 52hi0BKPuIBsPssd3bq08u37/Emx45ZgJikcgvjB8jVesq/Apj/X6vHqvsN7wtx8eRl31mVHZv/wPavFH9vjtMu17Pq/metEQ4dOy9xw/i6Mm9eksTYuTC0DbohRqzvLCKc31nWrxiQySaqdTfJx6Oeqfox/JeO3zT/aAdZWu1H/z2tZUQbfoMc18mV7lsW3Q3IDplgPu31Ych0FAyYuEv9q3tLo8JTkOFJ0yyCoa4jpkI8XIcpTK9FCX0hfzaebzeE8vP3d604eUmAjNoYZ8loH4H9TavmbNS1YA+meeh2mMMF9rvTAzh7VrRQOcqsGXX9siaaA92PmUqcGuBi0ssaC0nR/Acvmwlz+Kmg7ziV1kwN3Ntq9MlvjIWKfgDv7QzDrGu3WoKCEtY1WtZ1SULMlPY7B7IRUBoiEXJ0fPmACZczGzqFKDDw8c3ROI5lzqhPpjSf5NQeusgrY0DFDdT851Oeh4GrZpJhTkbrhTOlPe3UpmdK7knhFfFRq+HpJAwkHOiJg6/gSPYaF1BnOMVUZ5EfihG0U2rOUD10ulYnua/rncnTfQG8ecKQpE16ihIv/PCqo69z1gGB6m9LTlGwZbk/gK2k7mVZ9uUspOYyd0fzZQVvo3F/n9HmDd/lyibCmJjKUX7dZZguh0EPBm4D6qOydq+tDWmo4+vpFG9bv1BZ4mxU3qTBDlYqfc1Tgm4tOvXNFl02cBJYn2nLPHt0WmB/RbQId0xV3OC4cp6JZ4yaIN1he5QWCFBQfVyHBhQ/zqK8IB/DRWY45uMnVvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199018)(5660300002)(6862004)(76116006)(52536014)(8936002)(316002)(64756008)(66446008)(66946007)(66556008)(66476007)(4326008)(41300700001)(8676002)(54906003)(7416002)(2906002)(10290500003)(8990500004)(186003)(7696005)(26005)(71200400001)(478600001)(6506007)(9686003)(83380400001)(86362001)(82950400001)(82960400001)(33656002)(55016003)(38100700002)(38070700005)(122000001)(156123004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjduNDV3YWVPN1NPTTBGb3cyUXQ4ejhOd0lkNmJySkZOcFE0Tm9zb0JDMjNZ?=
 =?utf-8?B?YWhjY1pjRC9Zand1bWJRMkdWcFo0eThtMmgrU01jUFV6TXRQZ0doZnZXSHhs?=
 =?utf-8?B?ZmFJamtHKzF5QWtFNjJ4MFY1WldKZVJ0TlhONE5iWktqa2hYR3AvZ0pxdGI4?=
 =?utf-8?B?NXNCRmdtYStKQzhPN1RLOVFaSHprcXgwQUtHMlB0SHdyQW0wdnViUnJLazkr?=
 =?utf-8?B?ZmpYVGd6ZGUvNkZrS0s3eWswTlFqTE9vMGkvZDJaRkJiVjN4Ly9KK2xZMUFB?=
 =?utf-8?B?TUJuc1lMRFduQ2s4ZFUxeG85V0YyWDh2cTFQd0NyNkhwc2pWSDBIc2EweGR6?=
 =?utf-8?B?Tkd6VGZ2MjZkMUVxUnNCNXpLS1VRK3JNK2FKMURRbGFSV09DVU1aTC90NXFz?=
 =?utf-8?B?T2JRTlRJQk8rUTVLc2piQVJKd2VhQ1lPNStncG5jNGs5eDRPL2t0cUl4ektj?=
 =?utf-8?B?QjZLNktBZnFNVHpHMTFHT1hwZGJHYVo4ZFJMazhQTDJyMUwyUlg4bXQ1bTd6?=
 =?utf-8?B?cWVzd1FVaXU5SHNCaWltWDRVQmZLMERqZXFWbFNrNTdlYlkvcXpyMUpmQnZt?=
 =?utf-8?B?S0xDTEZ0ait4bldWazJvQVYrbSs5MzY0QkpTU0dIMXBRekM0eElKWlpEOHlu?=
 =?utf-8?B?d3UyL3FhcmNHZjhrTnVhZGtTdVVxRFF0aklaRlRKeE9sOG51MFpqYTVyd1g1?=
 =?utf-8?B?T3h1VXVxMkUwWDllOVFkN0ZNWmF0TjNjYjFLRW1PbE9LT3UzWTdGZlFDbzVC?=
 =?utf-8?B?d3FvL3Z1Rmc0M2RTNmR6ZkpOSHNvVStSSVFMUEVzc29vc1lqQXBNZjlrTVNl?=
 =?utf-8?B?WWNJT1FFY2pWTXVma3VzQmtzRC9WOFdRVDZGdnZGMVltbGRjT0dnQ2pNeWR0?=
 =?utf-8?B?ZkpCL3NjdU50L1BvYTBEc1ZHOFlIRTlJT0JRZ2QrYTZKc053b1pYUFYxbUJr?=
 =?utf-8?B?ODBXajNSeFZiUDJBcmhQU3RBS1BrTWVSZFQrbW9wOGlGQ2w0eURic1VHdnd3?=
 =?utf-8?B?WU9QRDBKbDNxS3AyZEdOSXFja0dmaFBmYWVKQW9LRW16UWFOUWo5dmFIWHl0?=
 =?utf-8?B?SkRJZC9CdGJMeWhzY0RtV244bmtuTUpFTGpGa0RIMjZ0NXN4MVBKRzJlR1FT?=
 =?utf-8?B?OVJUMXBURzVlNjkvckV3R2RxY1pPcFp4WFNUSWV2ZWdUSFhqejg1QnB3bkdV?=
 =?utf-8?B?aFJNL3RhTDdIUi9Wd0tIVm1BckIxWExNcXZ2WktkNXlUWmt0cGNOM3FITm1h?=
 =?utf-8?B?VGd2N1pqeUlzQ0RiTHZEd3RRNWd1blNPdkpZMUVVcHBzNXVPbUxZekRnSG5J?=
 =?utf-8?B?MFBKc09qLzVzL2M3dnpCRldjV29nMFFKYTJTRGlyMTNSMk9HSm55Qk92ck1X?=
 =?utf-8?B?WVVsYjB5K0JueTkyREZKbUVRZW5zY2pyTFhjenpsOFVxRlpDSkN0ZUhVdG5G?=
 =?utf-8?B?elRrQmFrZURxaks1WmtYOFl5eW5qUy9FT09xczFGcjBaeE4wWFhDVjJhdzNz?=
 =?utf-8?B?UDBMbG5CRjZsczI2bWk5eGxZNE1oL0VzYjJLZnVoL1c4RndST3ZhN2doZ2JN?=
 =?utf-8?B?NlpHZXM0cnZQbjVuSURoT2xPeFJHcmxhNERNWjRkelNEaGJ5aWY5SExibTJy?=
 =?utf-8?B?c0dNT0NiT3p3ZkZvVDJNTmVhdlNrSlBsRzA3N1lOMnN0SWYwd2FwWEp0MFZx?=
 =?utf-8?B?YmErNk5Va0Y3N1NudWM5a0JnL09TeldyelpDNUFPNDR1ZXJzSjJuZ1FGbnpG?=
 =?utf-8?B?bG9TMFJrN3ZxcmJTbHl2djMxaG81UHIvQVpTN1dDTzFFQVpVTHJybGpqN1R1?=
 =?utf-8?B?bGlFNGFaWFpuUnFLbGtmUlNYTDdyZWRuYloyOHhYcTFXRUFnVVg2TVRrSUI3?=
 =?utf-8?B?MXhMVlczM2NNdi8xeHFCRm9aUWNSa2g5SWNNRHF5VUFlUDdVTXdCenBGK2ty?=
 =?utf-8?B?aU5rR01oTG9pU0MzZWk0Q0FkbzRrdElhWUlZcGZ6aW5rUStQRlZSS3JxVGY5?=
 =?utf-8?B?bExXODh2UjJ2L3RJYzJhc2tEKzJZOENaN0pTUWxRZlBFbWEvc2JHR2xxWDBF?=
 =?utf-8?B?SHlGSGI0bUJwZk1iVlFJTnhRMElwYWNtY1FzcmVlaTVSVTkzNTFOR3ZxSGoz?=
 =?utf-8?B?cjFmdWN3ZHJlSFNweXhLNi9xZ3pZN3c1cnpSenBQVFppVkFpMGRvbjgyYUc1?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47fbf6a-2a80-45d3-fe6e-08db02d82704
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 15:39:19.3418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MZ22Bf1ECE04LI2KSvqGrOw8whrIcTZU3Sr96EklW1w7M3OK/Svofjt/IBiZMenkRVrgsYTwEfWPR21iOkAMrvFNcAkR0bqxKuVRo0UFV68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1925
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogSmVyZW1pIFBpb3Ryb3dza2kgPGpwaW90cm93c2tpQGxpbnV4Lm1pY3Jvc29mdC5jb20+
IFNlbnQ6IE1vbmRheSwgSmFudWFyeSAzMCwgMjAyMyA3OjI2IEFNDQo+IA0KPiBPbiBTYXQsIEph
biAyOCwgMjAyMyBhdCAwNzo0ODoyN1BNICswMDAwLCBNaWNoYWVsIEtlbGxleSAoTElOVVgpIHdy
b3RlOg0KPiA+IEZyb206IEplcmVtaSBQaW90cm93c2tpIDxqcGlvdHJvd3NraUBsaW51eC5taWNy
b3NvZnQuY29tPiBTZW50OiBNb25kYXksIEphbnVhcnkNCj4gMjMsIDIwMjMgODo1MSBBTQ0KPiA+
ID4NCj4gPiA+IFRoZSBybXB1cGRhdGUgYW5kIHBzbWFzaCBpbnN0cnVjdGlvbnMsIHdoaWNoIGFy
ZSB1c2VkIGluIEFNRCdzIFNFVi1TTlANCj4gPiA+IHRvIHVwZGF0ZSB0aGUgUk1QIChSZXZlcnNl
IE1hcCkgdGFibGUsIGNhbid0IGJlIHRyYXBwZWQuIEZvciBuZXN0ZWQNCj4gPiA+IHNjZW5hcmlv
cywgQU1EIGRlZmluZWQgTVNSIHZlcnNpb25zIG9mIHRoZXNlIGluc3RydWN0aW9ucyB3aGljaCBj
YW4gYmUNCj4gPg0KPiA+IHMvY2FuIGJlL211c3QgYmUvICA/Pw0KPiA+DQo+IA0KPiB5ZXMgaW5k
ZWVkDQo+IA0KPiA+ID4gZW11bGF0ZWQgYnkgdGhlIHRvcC1sZXZlbCBoeXBlcnZpc29yLiBPbmUg
aW5zdGFuY2Ugd2hlcmUgdGhlc2UgTVNScyBhcmUNCj4gPg0KPiA+IEFuZCBieSAidG9wLWxldmVs
IiwgSSB0aGluayB5b3UgYXJlIHJlZmVycmluZyB0aGUgaHlwZXJ2aXNvciBydW5uaW5nIGF0IEwx
LCByaWdodD8NCj4gPiBVc2luZyB0aGUgTDAvTDEvTDIgdGVybWlub2xvZ3kgd291bGQgcHJvYmFi
bHkgaGVscCBtYWtlIHRoZSBkZXNjcmlwdGlvbg0KPiA+IG1vcmUgcHJlY2lzZS4NCj4gDQo+IFRo
ZXNlIGluc3RydWN0aW9ucyBhcmUgY2FsbGVkIGJ5IHRoZSBMMSBoeXBlcnZpc29yIGFuZCBhcmUg
ZW11bGF0ZWQgYnkgdGhlIEwwDQo+IGh5cGVydmlzb3Igd2hpY2ggY29udHJvbHMgdGhlIGFjdHVh
bCBybXAgdGFibGUuIEknbGwgcmVwaHJhc2UgdGhlIGNvbW1pdA0KPiBtZXNzYWdlIHRvIG1ha2Ug
dGhhdCBjbGVhcmVyLg0KPiANCg0KW3NuaXBdDQoNCj4gPiA+ICsNCj4gPiA+ICtzdGF0aWMgdTY0
IHZpcnRfcHNtYXNoKHU2NCBwYWRkcikNCj4gPiA+ICt7DQo+ID4gPiArCWludCByZXQ7DQo+ID4g
PiArDQo+ID4gPiArCWFzbSB2b2xhdGlsZSgNCj4gPiA+ICsJCSJ3cm1zclxuXHQiDQo+ID4gPiAr
CQk6ICI9YSIocmV0KQ0KPiA+ID4gKwkJOiAiYSIocGFkZHIpLCAiYyIoTVNSX0FNRDY0X1ZJUlRf
UFNNQVNIKQ0KPiA+ID4gKwkJOiAibWVtb3J5IiwgImNjIg0KPiA+ID4gKwkpOw0KPiA+ID4gKwly
ZXR1cm4gcmV0Ow0KPiA+ID4gK30NCj4gPg0KPiA+IEZyb20gY2hlY2tpbmcgdGhlIEFNRCBzcGVj
LCBJIGNhbiBzZWUgdGhhdCB0aGUgYWJvdmUgdXNlDQo+ID4gb2Ygd3Jtc3IgaXMgbm9uLWNvbnZl
bnRpb25hbC4gIENvdWxkIHlvdSBjYXB0dXJlIHRoZSBiYXNpY3MNCj4gPiBvZiB0aGUgdXNhZ2Ug
cGFyYWRpZ20gaW4gYSBjb21tZW50PyAgSS5lLiwgdGhlIGV4cGVjdGVkDQo+ID4gaW5wdXRzIGFu
ZCBvdXRwdXRzLCBhbmQgdGhlIGNvcmUgYXNzdW1wdGlvbiB0aGF0IHRoZQ0KPiA+IE1TUiBpc24n
dCBpbXBsZW1lbnRlZCBpbiBoYXJkd2FyZSwgYnV0IG11c3QgdHJhcA0KPiA+IHRvIHRoZSBoeXBl
cnZpc29yLg0KPiANCj4gb2ssIGhvdyBkb2VzIHRoaXMgc291bmQ6DQo+IA0KPiAvKg0KPiAgKiBU
aGlzIHZlcnNpb24gb2Ygcm1wdXBkYXRlIGlzIG5vdCBpbXBsZW1lbnRlZCBpbiBoYXJkd2FyZSBi
dXQgYWx3YXlzDQo+ICAqIHRyYXBzIHRvIEwwIGh5cGVydmlzb3IuIEl0IGRvZXNuJ3QgZm9sbG93
IHVzdWFsIHdybXNyIGNvbnZlbnRpb25zLg0KPiAgKiBJbnB1dHM6DQo+ICAqICAgcmF4OiA0S0Ig
YWxpZ25lZCBHUEENCj4gICogICByZHg6IGJ5dGVzIDc6MCBvZiBuZXcgcm1wIGVudHJ5DQo+ICAq
ICAgcjg6ICBieXRlcyAxNTo4IG9mIG5ldyBybXAgZW50cnkNCj4gICogT3V0cHV0czoNCj4gICog
ICByYXg6IHJtcHVwZGF0ZSByZXR1cm4gY29kZQ0KPiAgKi8NCj4gDQo+IGFuZCBzaW1pbGFyIGZv
ciBwc21hc2guDQo+IA0KDQpZZXMsIHRoYXQgd29ya3MgZm9yIG1lLg0KDQpNaWNoYWVsDQoNCg==
