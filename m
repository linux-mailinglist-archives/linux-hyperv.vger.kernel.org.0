Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42F0616D96
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Nov 2022 20:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiKBTON (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Nov 2022 15:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiKBTNn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Nov 2022 15:13:43 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11022024.outbound.protection.outlook.com [40.93.200.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D85FE8;
        Wed,  2 Nov 2022 12:13:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZ7B0wtJufszPHQR9zGSqWktv/qO6Pe97Dj4pb+WeEZhLRSC1c0sqMRf3dQI+gtsoruk31/eULenD10B7y+d6JZaeDEvn7Sm1q173a6UgIyFSxf4QWJxElTuW1gbPxtkgzzVZ4qMU+tl01HW7PCtyLVtFlpPgwka9oO9lFPQ0Z33Chmf/Rr29UB/+5BUKsJ32iO+70MO6b88hACJWr9vCzAoU01T6Z1sznyAujPwMHrTODQqfq4ur7YhQUtRnndkJ42P4kAIQjGN5PJ8Hcv7vPij2D3OvZYNG7BXq1mOAP5FfqpuzPz3d0aFUIbnHwHVl2wdqc3iHa7QS9RGA1+cfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoTJDTKcc7AOMRae2hldiv4yK7IGtfd/0VbUZ5xzXCM=;
 b=mrNMZTtdGM1/WtL6gyN3qHOOVD1ozhvLM+6dWijf/smYxYpHPlvfmnLn+YWcp1zGOqI1b/4rlQxKbMXBewMdUGtiq4gIseZICcLwgGNzChHuMcC9XL68P4DY/TfjZOelVConuVARmIzoCvb4/U2+XynDs3LwuDqQDdb+xRjmiMrbJS45fIS1dGj42NBfU2t0QSgl2fUKSzMLLKJuw2ui7n9xt/jYAOQf33rtLfKK1V1v7BR5R8A2n/Ffb0dpdQ0qhN81d09LNFqzAT+Qc35e9RmgGYAB/L0LRDwseyb7AvMKmGuyraYRiZxEHH8xJN7TBVY3slshFqGTDPr1Ii79Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoTJDTKcc7AOMRae2hldiv4yK7IGtfd/0VbUZ5xzXCM=;
 b=VpwlKh3caerZN+HygmG18CBN2yiYkbZ3SGXM/5cJ/3XdJ0ZOxYGOyB5bvTiRVgPa+2/4SXEiY8VHvc3UX7nQOVzgI4e7Uklg13w3E0WF+aPuCbrMSjWwjXp415SccOVDbEscwO4ziitSKME5EC48/DG32c26rMk22Oi4aILKofs=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3484.namprd21.prod.outlook.com (2603:10b6:208:3d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.7; Wed, 2 Nov
 2022 19:13:40 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.004; Wed, 2 Nov 2022
 19:13:39 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC:     Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/4] drivers/clocksource/hyper-v: Add TSC page support for
 root partition
Thread-Topic: [PATCH 4/4] drivers/clocksource/hyper-v: Add TSC page support
 for root partition
Thread-Index: AQHY7hfSMoidipHddUioCmk+G8O0BK4sALDw
Date:   Wed, 2 Nov 2022 19:13:39 +0000
Message-ID: <BYAPR21MB16888951E2D611314B9326F0D7399@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <166732356767.9827.4925884794177179249.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <166732388036.9827.17503191387873469301.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: <166732388036.9827.17503191387873469301.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c4583f9c-d016-4907-9c7d-70bbf9c69600;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-02T19:08:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3484:EE_
x-ms-office365-filtering-correlation-id: 87d7be70-152f-4836-c440-08dabd065938
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ioJf1Q0QgYBvhSmLby7bxAzXnGQt+wQ5bSScSzdsQqZbZ+CBF8YdSSVLBfZuq2AlH1SHu9oGcasLeLAAeiBQtv0J382AJM6k04gIYO8PMnmQifY86MfH1XgE89OHO1Q8+TJ+S75/jidvZdWXv95csCUh9RG6xf9fViqizp2cD8jtn7QkoYPVrkBGeSiHYqv015GsgMGKcTPzYULYAyuzT6MUOAC8JVAPPrsAW/7Pc+IG86g+ON/LcZolfUgF7R8LYGfuZPBJ2RVovWnur1I4Ud93v1ueH5DNF76Kb1+m88FYXm8eXUJ7QtlxmgpiBhDoWHYu3sPpIFH2fX+IAfWGfNhYmfRgZ5vC9mMh4q+d4ToqFOnXu8S2+kiC1LNXHdeaJcpPTiv0QVRNMJ6skxST9iM4LVoIyVH2nbODL3roprUBHRMPqLdL087DDC2iqvTltApu9a/B6ttPjMfY5w85PPOBlSqvjCsbH8FKDzWJwHSpFkzqnbr8wjUVFotNGhSL0Hu+yu5irxMgjF9+PCvqSN/Le+YHBRpTwS07qp1FIf4LkoYse7cSdjFE/Vm6myBHbm1EG67bGvFv0bhXJwUyBGp+yuJ7HynHBeBqRmzeOkRyIQSMakyUxh9vm6WIHNmK4R7zAMn0jOf6T5EQpUcSjqM2bDelPHKWftHOuJXMGUlY+AmWExKh1Z+AANwCKIGL8UwDfoRRAwhaO7SWhioLaAJZXh8o9zfT8aHDTrygsn36VnBwGcuk4v3vdDQPAomCsiAIPppqQjJ9lyNGZZZ5awjzGWo/V5zJTNNMWBMioyHv5nBhZVw3yRLd+BL6JMGX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199015)(8936002)(6862004)(66899015)(52536014)(5660300002)(7416002)(86362001)(478600001)(4326008)(83380400001)(64756008)(66446008)(8676002)(66476007)(8990500004)(66946007)(66556008)(76116006)(41300700001)(33656002)(316002)(38070700005)(55016003)(122000001)(10290500003)(2906002)(26005)(71200400001)(7696005)(6506007)(9686003)(54906003)(82950400001)(82960400001)(38100700002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXdnNU9Wc0doZi9BR3pwcHFwSEhWbTczR3FPSzEzN0VVMXVubFkvVS85NVlC?=
 =?utf-8?B?Q2FBbnhzc3laVVNPbm5OQW1VTEF0T3NIK1BMWEZQaHZRMzZ3TW5ORkdMejNQ?=
 =?utf-8?B?dG95UkdoRlRsamNHemc4d0h2U0NETlM0Q2h4L1p2RWRlY1B3dVJlMlRxV1po?=
 =?utf-8?B?RUtnRitiTkV3UWFTM0pWZVdSMFVjOFhKMWZJNjdueFB6d2VwVzR5RVBISFND?=
 =?utf-8?B?bm1IdEdzY2JqOFh2Q3FybUVhMjdUQ3haZ1ZyM0llb25uWVBOQVFLVXluZzhL?=
 =?utf-8?B?MGNkZXlURW1UQUhpYU96WU9sRzE1QzFaSGpLK2Z3b2J2Z2J0b05tZkZ3WTlI?=
 =?utf-8?B?WlBCbVdyaEZMTmN3VStOaUM0N0dwSkxHRmVGL1ZTdCs5dUhValVrSFlUWHBW?=
 =?utf-8?B?UmIzUU9BWWNBd3ZXR0FnTEJUSWFMa3NqVG9qdU55Mjd6SUMvTmE2MHk1SEJr?=
 =?utf-8?B?U1ltU05zWUkzUGhNdFF1NzhtVkU5alJWY2pTWU1jcXA0Y1IvUkNhOEh0M1A0?=
 =?utf-8?B?cmtYeE4wVlBINld6VVNTcUd0cmpTeGdreFl3RllsdlZEVkZPd0p6LzBSZWti?=
 =?utf-8?B?dmFIQVFMUnV1cS9xeVR1VEZ3Nkx1dDd6N0pLU3o5N1p5Y3ZzWnhxMmxoUkpv?=
 =?utf-8?B?RkJJOWhHRDRiTVM0V1p3N3c3bnRRSmxMREhvVEl6aHpJVXR0TlpkaURiOUlR?=
 =?utf-8?B?ZDR5VkY1STF4TGpBdndDSTI4UXZLM0lCZXNMWXNqNXRmclZ4RlFWTjlnd2ht?=
 =?utf-8?B?cnVLSEFYaFJ4YXk0TVUzN0dqSmdBVWxOOVVkdTlNaDZJenFKSGF6WmJtd1BO?=
 =?utf-8?B?aktRcFNSU1dIQVA4SkszNXBmd1dFL3hqOUZJSHAzNzNMUTJNeWJISnRKSm1I?=
 =?utf-8?B?eHlYbnpRMEQ4QnAxNDA3OU95aHRnajhpY3g4L1JodDc1UXlRVUZDcForSTZN?=
 =?utf-8?B?VnY5cUd6UE05WElpOWpPR3ROckRqaVdhS2dXd2FFYThuS0hCakVNY0I1YnFE?=
 =?utf-8?B?UktmNCtweUJVZzcrdk1ramd2cFFkV1liQjNiUFh4VkRudFNPdmoxK3VFMHhT?=
 =?utf-8?B?UHUvWHJPaWF5dkEydWpLQnJ5S08wYWdtNDNBQzFGL1hVMG53WjVLTk11ci9L?=
 =?utf-8?B?Q1ZBaDd6M28vd1pwcm9oUlE2NnZBOG9hNEVPQzRwWTcrMXA1VmpuZTVZd0d6?=
 =?utf-8?B?Nmg3VnRzSE4ydVU4eThDbmRwM0kycWI3NzNWMmovU2E3bitFK3hnMWZpTU1T?=
 =?utf-8?B?UkdXK2hGcWFoNi9PTFloTFdtd3k1b2FlREtPTE5iTHlUZ29ER1VPVDVhRVp5?=
 =?utf-8?B?enIvRWgrdkNTeXNMZm42YnF0R0FkT3lhVmIvaTF5VkhGaDlFSld6dVA1d0pL?=
 =?utf-8?B?MDBnMFJDL2RWRllwZGVMdi9JY1VBSUhXQTBucGFESEZnMVlxSEF0K1VqQ08y?=
 =?utf-8?B?VXRoejd6Q2dEM3hEVDd3VHJEYlVUMExtbDcrS05NR3NWRFNlb1pzMy91MnB6?=
 =?utf-8?B?WHp0QS9xcTFXS3daZm1IN2RwSmM5WlM4cmdiZzNRQXB5Wm9yc3BpZTBMMit2?=
 =?utf-8?B?dVg2YUxQSCtNWHJFSWNMK2huQ3B2T3NpZFkwK1kwcTBFNGdUUVRsY0ZTQ1Rw?=
 =?utf-8?B?Ni9jTS90MWhVNHk4eHFsS1hQZ3d3L1NsanVpdnFpek5HZ1dZSDMzQ3RmZXA2?=
 =?utf-8?B?bW1NaUJsNXBIaWlvQ2NKQTFTTDFwRUJWbnhDSXRGemJlYmozYWpZZHZZQm1V?=
 =?utf-8?B?UG5Bb1NjZmlmV3M4U2loTU45eGNaWVFpK2hMM1FRUHFYd2l1aFZsMytkLzZl?=
 =?utf-8?B?MDRyRURydUYxcTBqN1BpYWJUSXRhZmE1M2xZblhxOVZ1U0R6aVJDc2NUc1dy?=
 =?utf-8?B?dnhvR0l6eS8zRWJES0xzKzJVMFNYdXlzMm1KVUtIb3NJcElSajhEN1FnejBj?=
 =?utf-8?B?S3VQczM4WWRBd2xucjFLV3lHT1dvN0NVUjBJNGVXUFhQU2lOdHNyZ29QYUtV?=
 =?utf-8?B?cmVYL1BsNmMxT2xabzFRd0tCTXZNb2RLck8vZ0dUcGRLTm1WWE5oMGtiUHJG?=
 =?utf-8?B?aHdXbmlFTUw4T1Q1aGZkRHB4WjRidmZVZDM2ZEhuTlhZemJyWG5tTnQvbGQ0?=
 =?utf-8?B?RUhlQkNuc1dVakJsYWY5WU5zUGMxMklSMVJYck1oT2NVb0JTZGRYbys2TTRn?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d7be70-152f-4836-c440-08dabd065938
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 19:13:39.0379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zLz4H0LEodXGI7GC+vKRbeXFB+XbraSAynwo0nVhQsFbPCWlPq7RapaPQFEKOyh7ms+cqKo8C5riKuvl5SH2ljXpeoFmAJVWLfC0Xug26Oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3484
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMSwgMjAyMiAxMDozMSBBTQ0KPiANCj4gSXQg
aHlwZXItdiByb290IHBhcnRpdGlvbiBndWVzdCBoYXMgdG8gbWFwIHRoZSBwYWdlLCBzcGVjaWZp
ZWQgYnkgdGhlDQo+IGh5cGVydmlzb3IgKGluc3RlYWQgb2YgcHJvdmlkaW5nIHRoZSBwYWdlIHRv
IHRoZSBoeXBlcnZpc29yIGxpa2UgaXQncyBkb25lIGluDQo+IHRoZSBndWVzdCBwYXJ0aXRpb25z
KS4NCj4gSG93ZXZlciwgaXQncyB0b28gZWFybHkgdG8gbWFwIHRoZSBwYWdlIHdoZW4gdGhlIGNs
b2NrIGlzIGluaXRpYWxpemVkLCBzbywgdGhlDQo+IGFjdHVhbCBtYXBwaW5nIGlzIGhhcHBlbmlu
ZyBsYXRlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFN0YW5pc2xhdiBLaW5zYnVyc2tpeSA8c3Rh
bmlzbGF2LmtpbnNidXJza2l5QGdtYWlsLmNvbT4NCj4gQ0M6ICJLLiBZLiBTcmluaXZhc2FuIiA8
a3lzQG1pY3Jvc29mdC5jb20+DQo+IENDOiBIYWl5YW5nIFpoYW5nIDxoYWl5YW5nekBtaWNyb3Nv
ZnQuY29tPg0KPiBDQzogV2VpIExpdSA8d2VpLmxpdUBrZXJuZWwub3JnPg0KPiBDQzogRGV4dWFu
IEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4NCj4gQ0M6IFRob21hcyBHbGVpeG5lciA8dGdseEBs
aW51dHJvbml4LmRlPg0KPiBDQzogSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+DQo+IEND
OiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4gQ0M6IERhdmUgSGFuc2VuIDxkYXZl
LmhhbnNlbkBsaW51eC5pbnRlbC5jb20+DQo+IENDOiB4ODZAa2VybmVsLm9yZw0KPiBDQzogIkgu
IFBldGVyIEFudmluIiA8aHBhQHp5dG9yLmNvbT4NCj4gQ0M6IERhbmllbCBMZXpjYW5vIDxkYW5p
ZWwubGV6Y2Fub0BsaW5hcm8ub3JnPg0KPiBDQzogbGludXgtaHlwZXJ2QHZnZXIua2VybmVsLm9y
Zw0KPiBDQzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiAtLS0NCj4gIGFyY2gveDg2
L2h5cGVydi9odl9pbml0LmMgICAgICAgICAgfCAgICAyICsrDQo+ICBkcml2ZXJzL2Nsb2Nrc291
cmNlL2h5cGVydl90aW1lci5jIHwgICAzNCArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tDQo+ICBpbmNsdWRlL2Nsb2Nrc291cmNlL2h5cGVydl90aW1lci5oIHwgICAgMSArDQo+ICAz
IGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYvaHlwZXJ2L2h2X2luaXQuYyBiL2FyY2gveDg2L2h5cGVydi9o
dl9pbml0LmMNCj4gaW5kZXggZjQ5YmMzZWM3NmU2Li44OTk1NDQ5MGFmOTMgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gveDg2L2h5cGVydi9odl9pbml0LmMNCj4gKysrIGIvYXJjaC94ODYvaHlwZXJ2L2h2
X2luaXQuYw0KPiBAQCAtNDY0LDYgKzQ2NCw4IEBAIHZvaWQgX19pbml0IGh5cGVydl9pbml0KHZv
aWQpDQo+ICAJCUJVR19PTighc3JjKTsNCj4gIAkJbWVtY3B5X3RvX3BhZ2UocGcsIDAsIHNyYywg
SFZfSFlQX1BBR0VfU0laRSk7DQo+ICAJCW1lbXVubWFwKHNyYyk7DQo+ICsNCj4gKwkJaHZfcmVt
YXBfdHNjX2Nsb2Nrc291cmNlKCk7DQo+ICAJfSBlbHNlIHsNCj4gIAkJaHlwZXJjYWxsX21zci5n
dWVzdF9waHlzaWNhbF9hZGRyZXNzID0NCj4gdm1hbGxvY190b19wZm4oaHZfaHlwZXJjYWxsX3Bn
KTsNCj4gIAkJd3Jtc3JsKEhWX1g2NF9NU1JfSFlQRVJDQUxMLCBoeXBlcmNhbGxfbXNyLmFzX3Vp
bnQ2NCk7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsb2Nrc291cmNlL2h5cGVydl90aW1lci5j
IGIvZHJpdmVycy9jbG9ja3NvdXJjZS9oeXBlcnZfdGltZXIuYw0KPiBpbmRleCA2MzVjMTRjMWUz
YmYuLjQxMThlNGJjOTE5NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbG9ja3NvdXJjZS9oeXBl
cnZfdGltZXIuYw0KPiArKysgYi9kcml2ZXJzL2Nsb2Nrc291cmNlL2h5cGVydl90aW1lci5jDQo+
IEBAIC01MDgsOSArNTA4LDYgQEAgc3RhdGljIGJvb2wgX19pbml0IGh2X2luaXRfdHNjX2Nsb2Nr
c291cmNlKHZvaWQpDQo+ICAJaWYgKCEobXNfaHlwZXJ2LmZlYXR1cmVzICYgSFZfTVNSX1JFRkVS
RU5DRV9UU0NfQVZBSUxBQkxFKSkNCj4gIAkJcmV0dXJuIGZhbHNlOw0KPiANCj4gLQlpZiAoaHZf
cm9vdF9wYXJ0aXRpb24pDQo+IC0JCXJldHVybiBmYWxzZTsNCj4gLQ0KPiAgCS8qDQo+ICAJICog
SWYgSHlwZXItViBvZmZlcnMgVFNDX0lOVkFSSUFOVCwgdGhlbiB0aGUgdmlydHVhbGl6ZWQgVFND
IGNvcnJlY3RseQ0KPiAgCSAqIGhhbmRsZXMgZnJlcXVlbmN5IGFuZCBvZmZzZXQgY2hhbmdlcyBk
dWUgdG8gbGl2ZSBtaWdyYXRpb24sDQo+IEBAIC01MjgsMTYgKzUyNSwyMiBAQCBzdGF0aWMgYm9v
bCBfX2luaXQgaHZfaW5pdF90c2NfY2xvY2tzb3VyY2Uodm9pZCkNCj4gIAl9DQo+IA0KPiAgCWh2
X3JlYWRfcmVmZXJlbmNlX2NvdW50ZXIgPSByZWFkX2h2X2Nsb2NrX3RzYzsNCj4gLQl0c2NfcGZu
ID0gX19waHlzX3RvX3Bmbih2aXJ0X3RvX3BoeXModHNjX3BhZ2UpKTsNCj4gDQo+ICAJLyoNCj4g
LQkgKiBUaGUgSHlwZXItViBUTEZTIHNwZWNpZmllcyB0byBwcmVzZXJ2ZSB0aGUgdmFsdWUgb2Yg
cmVzZXJ2ZWQNCj4gLQkgKiBiaXRzIGluIHJlZ2lzdGVycy4gU28gcmVhZCB0aGUgZXhpc3Rpbmcg
dmFsdWUsIHByZXNlcnZlIHRoZQ0KPiAtCSAqIGxvdyBvcmRlciAxMiBiaXRzLCBhbmQgYWRkIGlu
IHRoZSBndWVzdCBwaHlzaWNhbCBhZGRyZXNzDQo+IC0JICogKHdoaWNoIGFscmVhZHkgaGFzIGF0
IGxlYXN0IHRoZSBsb3cgMTIgYml0cyBzZXQgdG8gemVybyBzaW5jZQ0KPiAtCSAqIGl0IGlzIHBh
Z2UgYWxpZ25lZCkuIEFsc28gc2V0IHRoZSAiZW5hYmxlIiBiaXQsIHdoaWNoIGlzIGJpdCAwLg0K
PiArCSAqIFRTQyBwYWdlIG1hcHBpbmcgd29ya3MgZGlmZmVyZW50bHkgaW4gcm9vdCBhbmQgZ3Vl
c3QgcGFydGl0aW9ucy4NCj4gKwkgKiAtIEluIGd1ZXN0IHBhcnRpdGlvbiB0aGUgZ3Vlc3QgUEZO
IGhhcyB0byBiZSBwYXNzZWQgdG8gdGhlDQo+ICsJICogICBoeXBlcnZpc29yLg0KPiArCSAqIC0g
SW4gcm9vdCBwYXJ0aXRpb24gaXQncyBvdGhlciB3YXkgYXJvdW5kOiB0aGUgZ3Vlc3QgaGFzIHRv
IG1hcCB0aGUNCj4gKwkgKiAgIFBGTiwgcHJvdmlkZWQgYnkgdGhlIGh5cGVydmlzb3IuDQo+ICsJ
ICogICBCdXQgaXQgY2FuJ3QgYmUgbWFwcGVkIHJpZ2h0IGhlcmUgYXMgaXQncyB0b28gZWFybHkg
YW5kIE1NVSBpc24ndA0KPiArCSAqICAgcmVhZHkgeWV0LiBTbywgd2Ugb25seSBzZXQgdGhlIGVu
YWJsZSBiaXQgaGVyZSBhbmQgd2lsbCByZW1hcCB0aGUNCj4gKwkgKiAgIHBhZ2UgbGF0ZXIgaW4g
aHZfcmVtYXBfdHNjX2Nsb2Nrc291cmNlKCkuDQo+ICAJICovDQo+ICAJdHNjX21zci5hc191aW50
NjQgPSBodl9nZXRfcmVnaXN0ZXIoSFZfUkVHSVNURVJfUkVGRVJFTkNFX1RTQyk7DQo+ICsJaWYg
KGh2X3Jvb3RfcGFydGl0aW9uKQ0KPiArCQl0c2NfcGZuID0gdHNjX21zci5wZm47DQo+ICsJZWxz
ZQ0KPiArCQl0c2NfcGZuID0gX19waHlzX3RvX3Bmbih2aXJ0X3RvX3BoeXModHNjX3BhZ2UpKTsN
Cj4gIAl0c2NfbXNyLmVuYWJsZSA9IDE7DQo+ICAJdHNjX21zci5wZm4gPSB0c2NfcGZuOw0KPiAg
CWh2X3NldF9yZWdpc3RlcihIVl9SRUdJU1RFUl9SRUZFUkVOQ0VfVFNDLCB0c2NfbXNyLmFzX3Vp
bnQ2NCk7DQo+IEBAIC01NzIsMyArNTc1LDE2IEBAIHZvaWQgX19pbml0IGh2X2luaXRfY2xvY2tz
b3VyY2Uodm9pZCkNCj4gIAlodl9zY2hlZF9jbG9ja19vZmZzZXQgPSBodl9yZWFkX3JlZmVyZW5j
ZV9jb3VudGVyKCk7DQo+ICAJaHZfc2V0dXBfc2NoZWRfY2xvY2socmVhZF9odl9zY2hlZF9jbG9j
a19tc3IpOw0KPiAgfQ0KPiArDQo+ICt2b2lkIF9faW5pdCBodl9yZW1hcF90c2NfY2xvY2tzb3Vy
Y2Uodm9pZCkNCj4gK3sNCj4gKwlpZiAoIShtc19oeXBlcnYuZmVhdHVyZXMgJiBIVl9NU1JfUkVG
RVJFTkNFX1RTQ19BVkFJTEFCTEUpKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwlpZiAoIWh2X3Jv
b3RfcGFydGl0aW9uKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwl0c2NfcGFnZSA9IG1lbXJlbWFw
KF9fcGZuX3RvX3BoeXModHNjX3BmbiksIFBBR0VfU0laRSwgTUVNUkVNQVBfV0IpOw0KDQpJbnN0
ZWFkIG9mIGhhcmQtY29kaW5nIFBBR0VfU0laRSBoZXJlLCBjb3VsZCB0aGlzIGJlIHNpemVvZih1
bmlvbiB0c2NfcGcpPw0KSW4gdGhlIHBhc3Qgd2Ugc29ydGVkIG91dCBob3cgdG8gbWFrZSB0aGUg
bWVtb3J5IGFsbG9jYXRlZCBmb3IgdGhlIFRTQyBwYWdlIGJlDQphIGZ1bGwgZ3Vlc3QgcGFnZSAo
bm90IE1pY3Jvc29mdCBIeXBlcnZpc29yIHBhZ2UsIHdoaWNoIGNvdWxkIGJlIGRpZmZlcmVudCkg
c28gdGhhdA0KaXQgY2FuIGJlIG1hcHBlZCBpbnRvIHVzZXIgc3BhY2UgZm9yIHZEU08uICBTbyBp
dCBzZWVtcyBhcHByb3ByaWF0ZSB0byBwaWdneWJhY2sNCm9uIHRoYXQgdW5pb24gZGVmaW5pdGlv
biByYXRoZXIgdGhhbiBoYXJkY29kaW5nIFBBR0VfU0laRS4NCg0KPiArCWlmICghdHNjX3BhZ2Up
DQo+ICsJCXByX2VycigiRmFpbGVkIHRvIHJlbWFwIEh5cGVyLVYgVFNDIHBhZ2UuXG4iKTsNCj4g
K30NCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmgNCj4g
Yi9pbmNsdWRlL2Nsb2Nrc291cmNlL2h5cGVydl90aW1lci5oDQo+IGluZGV4IDMwNzhkMjNmYWFl
YS4uNzgzNzAxYTIxMDJkIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2Nsb2Nrc291cmNlL2h5cGVy
dl90aW1lci5oDQo+ICsrKyBiL2luY2x1ZGUvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmgNCj4g
QEAgLTMxLDYgKzMxLDcgQEAgZXh0ZXJuIHZvaWQgaHZfc3RpbWVyX2dsb2JhbF9jbGVhbnVwKHZv
aWQpOw0KPiAgZXh0ZXJuIHZvaWQgaHZfc3RpbWVyMF9pc3Iodm9pZCk7DQo+IA0KPiAgZXh0ZXJu
IHZvaWQgaHZfaW5pdF9jbG9ja3NvdXJjZSh2b2lkKTsNCj4gK2V4dGVybiB2b2lkIGh2X3JlbWFw
X3RzY19jbG9ja3NvdXJjZSh2b2lkKTsNCj4gDQo+ICBleHRlcm4gdW5zaWduZWQgbG9uZyBodl9n
ZXRfdHNjX3Bmbih2b2lkKTsNCj4gIGV4dGVybiBzdHJ1Y3QgbXNfaHlwZXJ2X3RzY19wYWdlICpo
dl9nZXRfdHNjX3BhZ2Uodm9pZCk7DQo+IA0KDQo=
