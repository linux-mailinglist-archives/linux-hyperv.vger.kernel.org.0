Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D395223EC
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 May 2022 20:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245275AbiEJS1K (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 10 May 2022 14:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348882AbiEJS1H (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 10 May 2022 14:27:07 -0400
Received: from na01-obe.outbound.protection.outlook.com (unknown [52.101.56.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDF11B4377;
        Tue, 10 May 2022 11:27:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgSDOmfypBQYCJpRnOQNq/y55TqPHIfYht/ctECjUECDnQcGYZouZN0nGhrVWxv65xjlMDj6puo4s5B936lEmoQQNRF/Nf4iMfJr6EJIyEMe0PiPLeQGeVhD/0eGhvcFxvEM3ec6/eJmJJFd89lZYoDlvRt/WuR5kuNdzVcFiJSymuaSyPEaQ80LMmC+TKm7AWFiWQb49NtHcLbdeh1mIbAuzvGZddGT9MH3BQ8PGUH28lQsx7GEcxXb7L3HYgeUQpwxE9tREwAcEvbm1mJu3QDdVA+kaZyBzqhpxqib/oKiaAeKyOF9roVcz9PAQ8c3yut/uEBx26dqtJMpUxu2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtNq7ZKtBQ2nTqGkM5H7flWseKzCEAe0LfAXnQM97gM=;
 b=L94Br1xZmJL1eJDd3iy+Lak9lSSOPstOwMI0p9vBBt1SY/kjTBGHwwE6N2CZ8Ts3xv1utwhZESJ1fvtdDUjpPEeknMmGrAGLshqLFs4zKnp6dYxVJcrFr++cj1FO4Cj52Lzmxz41trkxFevcNBi3RULfpDFKxEJxYKPSi+H/P9yyZqI3TMoWPfHDpGpVACGHaCMytLH5SFCvXzRs2/kctS7ZoU3ymcRFj6Rzs9jenKZQgAOxHI3nhjjCpdWwyAVmPDJcP7CPq5jwBR3d7RUhj0VQ3YhQ6DTi64r3rS8NArDV+svpf1gpM5uUucFoTq0ZR43r1DOpDPl7sjQbkYCVQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtNq7ZKtBQ2nTqGkM5H7flWseKzCEAe0LfAXnQM97gM=;
 b=DgymNlJgSGohlb9gBL9+bbZk75dJWrVSisXo07F7oQ6rmaIU6ahVKn1akEufTaV8QQ1JczmhFgxOsUv5OxDX7YNas5/cAamUPg8oGbhtenXGq+1jx0yKNZ5ScihIUB5xHqU7Cq6tbJ7+6R3QGjMSnrjUS9Qge7XcGxtjxn5u3wY=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by MW2PR2101MB1050.namprd21.prod.outlook.com (2603:10b6:302:4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.10; Tue, 10 May
 2022 18:26:55 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::dd77:2d4d:329e:87df]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::dd77:2d4d:329e:87df%7]) with mapi id 15.20.5273.004; Tue, 10 May 2022
 18:26:55 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "hch@lst.de" <hch@lst.de>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>
Subject: RE: [PATCH] swiotlb: Max mapping size takes min align mask into
 account
Thread-Topic: [PATCH] swiotlb: Max mapping size takes min align mask into
 account
Thread-Index: AQHYZHk5Q8VaDdWQFku6DdhrqUjTsa0YTo2AgAAb8uA=
Date:   Tue, 10 May 2022 18:26:55 +0000
Message-ID: <PH0PR21MB302530B081D6CE6470D5F9A4D7C99@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220510142109.777738-1-ltykernel@gmail.com>
 <cd64adcd-26fc-0452-754d-7ab0f5536142@arm.com>
In-Reply-To: <cd64adcd-26fc-0452-754d-7ab0f5536142@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ff24acbe-2d27-4e9d-8f5f-85357c5c966c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-10T18:14:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f07bf67-e487-42dc-af2d-08da32b2a948
x-ms-traffictypediagnostic: MW2PR2101MB1050:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB10509876C833182F3A268855D7C99@MW2PR2101MB1050.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9KO6x4/a3lk6zCw5Iv7uj6xYlI40lQLsOHU83l+yZWsdJ7sg0HtElU5HwQVxBCyZu3Qld+YljHUNBxiDAfq+oWP8+w1aKRKS0MDAM9+POOKqa0MrqKWaLJLOV6Rm1XtnKoW6FCznoepmP1fLK3l5lyevZpSN1geTCvwCgzBcYs+KPMObQAUUU5PUjr8MmYhmWj47rd0gxhNoiKfdoeCSh/ukiDyPHGT6LaHiPJ2h+HgTXtenzOnZW9V4FBz4Usy1wiKsp8+XrcOif1e1pkiKYW1feyH8mfmAemvuaYYN2FDMJuP+fLFebbDbZu6sfp7urYA/yQaRbPxBAFWwfvzTAdCilatB/wRVOqZVTeTWQthzLM2b6dbbLiM9i5Rz9nuia4aLKxcEAm5eLWoKO2fuDCzlr0EvEBHf2DU8oTeH4BbrAfyOW61hhXjSUfrCCW7IdOXcT0nyotz6eHG0JLk+hjXG0/z5smvFWn2EnupCfv47UzXmnPMaTsofa8y2JrGaL3r/CcS6JwJekQKQ6FbIzJebVbGH0d8n0zrcj5QkFd91WlwygX0j4SCEL8iImA0JLB+1jQMGpU9ctqXcagbXVBzJreVZnCJbhrz+CyA/tTSiFOlBupVVwHx2pA/fpmx57wz/Flu0c5l9cB5Ukx3VdZfV9ujPnimaOKM5zbxf77Mzoss1fYWTqOimHSjefPwNSfD3gFKbrg6SkGRuGWOnsPsFA7T2+OvXO+wcb67reOzfyR511ov8aHQWlJi/sReUREajHSph9xC08K+r/i5LQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(38100700002)(38070700005)(54906003)(7416002)(66946007)(9686003)(66446008)(8676002)(53546011)(55016003)(186003)(316002)(2906002)(15650500001)(33656002)(6506007)(5660300002)(508600001)(26005)(86362001)(8990500004)(83380400001)(8936002)(921005)(4326008)(64756008)(66556008)(66476007)(76116006)(7696005)(71200400001)(122000001)(110136005)(52536014)(82960400001)(10290500003)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1pObklEZ0RtRWxEUDRwai8vWit0RlB5RUFMeTVwMHNwVzZMNlR6dS9waTQ3?=
 =?utf-8?B?ZjFYN3FCdjhEU0xLaVZRalRxQzc4dnVlYzNIQS9IYlNhbktYTzIxcm8xSlhY?=
 =?utf-8?B?aXlpUmFhSGhlaXZHYi9UY1hHWEtLK0RCeE00Z0M2QzhwRjRVcDRodlVORkdP?=
 =?utf-8?B?OUc3VE5KeWRJMVk1dHZTMHFENEd3NnVlSmVJYUJzWVJINkZIQ1ZQdHhRVlQr?=
 =?utf-8?B?YVQwSEpXN2RLam5tSWVGUU5sQnhSRDFINEg4REVOK1Z6VHJ4bHhzbnRoZHF4?=
 =?utf-8?B?R00vSFRFTDBBcjJrMFR1Z1BZTVdUZ3EwdmtuR3p4VkZsSFI0SmZSZFppVU15?=
 =?utf-8?B?cnprQlVXTlRtWjN1NzR2WVp1MmtmU3ZXVEgvRTluTHNtRGd4RjRyZHVGdkdV?=
 =?utf-8?B?OUdxcnpabmV5NnhjQU9tY0RTOEx5aGZJc2NEdG1ncFVMdW5yNkJlUGJ5TmN6?=
 =?utf-8?B?Um1RMEp3eE54alVldS9uN1hFVk1VNGtVOWdOeHNtN3h3b0FjZ0JTMlFJL1Bk?=
 =?utf-8?B?dG5YVUVkL3VQSzdBVDI0b2xqWjluNHI2cmI3bXllbFU5NTNmM2NnbjVLWUJP?=
 =?utf-8?B?K2gxSk5VZFZQMGI1Vjk1RTRWcW9qaDBFdzlKdVlJa0xXSU9KQWk4SkRLY1Rh?=
 =?utf-8?B?VUcvTzBQeDRkdVNKSXBuUUNSeGtBMGk4VU5FM1I2SlFOM0JMKy85dFV6R0Ns?=
 =?utf-8?B?dWl2Ym14T3RDVUhHY2Q3dUtOMXRLSGJNWm5ZbzRhSURTYWpjZ0pIcFBqTktT?=
 =?utf-8?B?S3RrQ1pTQXgrOFFTUk5HeCtXTU1abUVEK25mejFIbUo5Q3IvNG1UdjlvWFBl?=
 =?utf-8?B?bHZyZlFtV2dGUHIvczRZUFIxcU1MUTI5SUtYcVhyTGNQU2E3NjBoSXl6UzZW?=
 =?utf-8?B?YmlVWDFmRWxUTEJ3L25ma0FuMndEYk9UUWczMnJVQmdmRWZETVNLclRsbGFY?=
 =?utf-8?B?cU1ZRXBlMHJTaUM4a1J1YnQzQ2gvdW8yQnZHNUxWYjgrOWpMNndSeUpJaHVv?=
 =?utf-8?B?Rmp2SmlTV0lqeGRFdHVyQ2pyRStYMi8ydHBBSHdseEJSeFBZdnZ1Q3ZCSzFy?=
 =?utf-8?B?WUxobmZyQU1kQVZtMVdMTXhuRSt3aGNHdTFmd3lJUzRiSXdSME5NTVJCL3hV?=
 =?utf-8?B?WXRQREZLRExuaEZMYng5YkJseUF2MDcwalJqMzhDblMxVUphNEZGVEJSU1lR?=
 =?utf-8?B?NVFBaWUzTm5Pci9CbTlFYWNBMUtXL1Zsd2s2a082ZFBmelFxVUJOenc4SHN1?=
 =?utf-8?B?U3dsQXg4b1VIbU0rcGVwZXIvWVc2QWhPT01ZSGNCSGhZRGxXek1xV2U3VDlB?=
 =?utf-8?B?eDY1SkVWK1dtSWgvbUtSQmJ0QjJqUENSMURFYTIwUUxUMzMrQ05YZ0ZNL0FH?=
 =?utf-8?B?ay9QMVNaNXFzUEU0REJCaW1QQlNPZ0RLVU1rRzJWR2xsb2RCVWY5R0FGNnlZ?=
 =?utf-8?B?NlgrYXJ6MGJYMUxtWHNRS1R0YzkycmljV0tQQnBxMStTU3Q2ODJaeGFQMEVm?=
 =?utf-8?B?Z2FsVWJZdkU0NjFMN3hyWFZkZmtLOFI1QW4xbUQ2RW1MU3FlR2Nnb2p6RnA4?=
 =?utf-8?B?ajhxbzdOY0c2emFUZVZPY1F1YXF4MFQzWjhkN3A4Q1NFVWs5RCtxNXplS3VB?=
 =?utf-8?B?Rkl4bU1qeGdsM09lemtRS1RxOWppSFgrMDM4NzdTa2hVZWl0dDludElkalNa?=
 =?utf-8?B?bEowYUgwaWtrbkc5TklYRTdSdk16bmUvL1lpMEJiYjIxYzl6V3dlR1VMVU1F?=
 =?utf-8?B?WDl3Umw4QjNCTlZyOHhYSno4RFhSYnphQWtSbDY1VmJOWVhyRExJOWNEOXFE?=
 =?utf-8?B?U0FHUUhSQlRDNkRmWWkrWXQyZUg1eXFxQUFxbk9CU1c4K01LWnBJdGg0UkJI?=
 =?utf-8?B?MEtGc0lLbkliSXBXVE8wOGdaYmVMWVM5Tzdoei9ueHhsVjZHZHF4ZEpDNm5G?=
 =?utf-8?B?bUVEMVgrNmJZdlYxV3BQbkhibGRDb213Qmw1UlJRNVdNTDFNSzdEOVduMytF?=
 =?utf-8?B?V2NJZlZCakJneWlsbFl0NXZFYzlHa2RUdXllZ3o2TkN2UUVqUjg2dXhnQ2Z6?=
 =?utf-8?B?dU9kNW5ib3JDRXZKQXB5NW90QjhBSGdnK0c3Rjg4MCtieHUwUlQ2bkMrWXh1?=
 =?utf-8?B?bEs0YlVWNXhvQVA0THFYZkU1SHMzdkFHZHRseFJUVm1Pb1U2REFBY0t6TmFO?=
 =?utf-8?B?TStGMklMdFdxUnI0emw0YzhzeUtXV1BaZ3lTWkF5R0Vnd1QwNVJyRWRFREhL?=
 =?utf-8?B?NVF6VmJzajgrbHV3bVphb0thQm9vZGhJM2xsK2dyaWZrNFJsWVVCRS9OdExR?=
 =?utf-8?B?RkFudmhrWCtrN0dtWFB1UnVRT0lIRzlKaW1OQjVWMHlONmJOSllFSzRYS0F4?=
 =?utf-8?Q?WROuqabBbUvErqOg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f07bf67-e487-42dc-af2d-08da32b2a948
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 18:26:55.1076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JombG1/SuA8q66+qpXVdqSiiUwzaSeWmfbrCaNc5utEoyBqgQ0c4IW0LnjL3D233yLU/i8OILUZNhfQyXSD6kqBAvifMFjBaGnr/kcX35AQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1050
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4gU2VudDogVHVlc2RheSwg
TWF5IDEwLCAyMDIyIDk6MzQgQU0NCj4gDQo+IE9uIDIwMjItMDUtMTAgMTU6MjEsIFRpYW55dSBM
YW4gd3JvdGU6DQo+ID4gRnJvbTogVGlhbnl1IExhbiA8VGlhbnl1LkxhbkBtaWNyb3NvZnQuY29t
Pg0KPiA+DQo+ID4gc3dpb3RsYl9maW5kX3Nsb3RzKCkgc2tpcHMgc2xvdHMgYWNjb3JkaW5nIHRv
IGlvIHRsYiBhbGlnbmVkIG1hc2sNCj4gPiBjYWxjdWxhdGVkIGZyb20gbWluIGFsaWduZWQgbWFz
ayBhbmQgb3JpZ2luYWwgcGh5c2ljYWwgYWRkcmVzcw0KPiA+IG9mZnNldC4gVGhpcyBhZmZlY3Rz
IG1heCBtYXBwaW5nIHNpemUuIFRoZSBtYXBwaW5nIHNpemUgY2FuJ3QNCj4gPiBhY2hpZXZlIHRo
ZSBJT19UTEJfU0VHU0laRSAqIElPX1RMQl9TSVpFIHdoZW4gb3JpZ2luYWwgb2Zmc2V0IGlzDQo+
ID4gbm9uLXplcm8uIFRoaXMgd2lsbCBjYXVzZSBzeXN0ZW0gYm9vdCB1cCBmYWlsdXJlIGluIEh5
cGVyLVYNCj4gPiBJc29sYXRpb24gVk0gd2hlcmUgc3dpb3RsYiBmb3JjZSBpcyBlbmFibGVkLiBT
Y3NpIGxheWVyIHVzZSByZXR1cm4NCj4gPiB2YWx1ZSBvZiBkbWFfbWF4X21hcHBpbmdfc2l6ZSgp
IHRvIHNldCBtYXggc2VnbWVudCBzaXplIGFuZCBpdA0KPiA+IGZpbmFsbHkgY2FsbHMgc3dpb3Rs
Yl9tYXhfbWFwcGluZ19zaXplKCkuIEh5cGVyLVYgc3RvcmFnZSBkcml2ZXINCj4gPiBzZXRzIG1p
biBhbGlnbiBtYXNrIHRvIDRrIC0gMS4gU2NzaSBsYXllciBtYXkgcGFzcyAyNTZrIGxlbmd0aCBv
Zg0KPiA+IHJlcXVlc3QgYnVmZmVyIHdpdGggMH40ayBvZmZzZXQgYW5kIEh5cGVyLVYgc3RvcmFn
ZSBkcml2ZXIgY2FuJ3QNCj4gPiBnZXQgc3dpb3RsYiBib3VuY2UgYnVmZmVyIHZpYSBETUEgQVBJ
LiBTd2lvdGxiX2ZpbmRfc2xvdHMoKSBjYW4ndA0KPiA+IGZpbmQgMjU2ayBsZW5ndGggYm91bmNl
IGJ1ZmZlciB3aXRoIG9mZnNldC4gTWFrZSBzd2lvdGxiX21heF9tYXBwaW5nDQo+ID4gX3NpemUo
KSB0YWtlIG1pbiBhbGlnbiBtYXNrIGludG8gYWNjb3VudC4NCj4gDQo+IEhtbSwgdGhpcyBzZWVt
cyBhIGJpdCBwZXNzaW1pc3RpYyAtIHRoZSBvZmZzZXQgY2FuIHZhcnkgcGVyIG1hcHBpbmcsIHNv
DQo+IGl0IGZlZWxzIHRvIG1lIGxpa2UgaXQgc2hvdWxkIHJlYWxseSBiZSB0aGUgY2FsbGVyJ3Mg
cmVzcG9uc2liaWxpdHkgdG8NCj4gYWNjb3VudCBmb3IgaXQgaWYgdGhleSdyZSBhbHJlYWR5IGlu
dm9sdmVkIGVub3VnaCB0byBjYXJlIGFib3V0IGJvdGgNCj4gY29uc3RyYWludHMuIEJ1dCBJJ20g
bm90IHN1cmUgaG93IHByYWN0aWNhbCB0aGF0IHdvdWxkIGJlLg0KDQpUaWFueXUgYW5kIEkgZGlz
Y3Vzc2VkIHRoaXMgcHJpb3IgdG8gaGlzIHN1Ym1pdHRpbmcgdGhlIHBhdGNoLg0KUHJlc3VtYWJs
eSBkbWFfbWF4X21hcHBpbmdfc2l6ZSgpIGV4aXN0cyBzbyB0aGF0IHRoZSBoaWdoZXINCmxldmVs
IGJsay1tcSBjb2RlIGNhbiBsaW1pdCB0aGUgc2l6ZSBvZiBJL08gcmVxdWVzdHMgdG8gc29tZXRo
aW5nDQp0aGF0IHdpbGwgImZpdCIgaW4gdGhlIHN3aW90bGIgd2hlbiBib3VuY2UgYnVmZmVyaW5n
IGlzIGVuYWJsZWQuDQpVbmZvcnR1bmF0ZWx5LCB0aGUgY3VycmVudCBjb2RlIGlzIGp1c3QgZ2l2
aW5nIHRoZSB3cm9uZyBhbnN3ZXINCndoZW4gdGhlIG9mZnNldCBpcyBub24temVyby4gIFRoZSBv
ZmZzZXQgd291bGQgYmUgbGVzcyB0aGFuDQpQQUdFX1NJWkUsIHNvIHRoZSBpbXBhY3Qgd291bGQg
YmUgZG1hX21heF9tYXBwaW5nX3NpemUoKQ0KcmV0dXJuaW5nIDI1MiBLYnl0ZXMgaW5zdGVhZCBv
ZiAyNTYgS2J5dGVzLCBidXQgb25seSBmb3IgZGV2aWNlcw0Kd2hlcmUgZG1hIG1pbiBhbGlnbiBt
YXNrIGlzIHNldC4gIEFuZCBhbnkgSS9PIHNpemVzIGxlc3MgdGhhbg0KMjUyIEtieXRlcyBhcmUg
dW5hZmZlY3RlZCBldmVuIHdoZW4gZG1hIG1pbiBhbGlnbiBtYXNrIGlzIHNldC4gDQpOZXQsIHRo
ZSBpbXBhY3Qgd291bGQgYmUgb25seSBpbiBhIGZhaXJseSByYXJlIGVkZ2UgY2FzZS4NCg0KRXZl
biBvbiBBUk02NCB3aXRoIGEgNjRLIHBhZ2Ugc2l6ZSwgdGhlIEh5cGVyLVYgc3RvcmFnZSBkcml2
ZXINCmlzIHNldHRpbmcgdGhlIGRtYSBtaW4gYWxpZ24gbWFzayB0byBvbmx5IDRLICh3aGljaCBp
cyBjb3JyZWN0IGJlY2F1c2UNCnRoZSBIeXBlci1WIGhvc3QgdXNlcyBhIDRLIHBhZ2Ugc2l6ZSBl
dmVuIGlmIHRoZSBndWVzdCBpcyB1c2luZw0Kc29tZXRoaW5nIGxhcmdlciksIHNvIGFnYWluIHRo
ZSBsaW1pdCBiZWNvbWVzIDI1MiBLYnl0ZXMgaW5zdGVhZA0Kb2YgMjU2IEtieXRlcywgYW5kIGFu
eSBpbXBhY3QgaXMgcmFyZS4NCg0KQXMgeW91IG1lbnRpb25lZCwgaG93IGVsc2Ugd291bGQgYSBj
YWxsZXIgaGFuZGxlIHRoaXMgc2l0dWF0aW9uPw0KDQpNaWNoYWVsDQoNCj4gDQo+IFJvYmluLg0K
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBUaWFueXUgTGFuIDxUaWFueXUuTGFuQG1pY3Jvc29mdC5j
b20+DQo+ID4gLS0tDQo+ID4gICBrZXJuZWwvZG1hL3N3aW90bGIuYyB8IDEzICsrKysrKysrKysr
Ky0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL2RtYS9zd2lvdGxiLmMgYi9rZXJuZWwvZG1h
L3N3aW90bGIuYw0KPiA+IGluZGV4IDczYTQxY2VjOWUzOC4uMGQ2Njg0Y2E3ZWFiIDEwMDY0NA0K
PiA+IC0tLSBhL2tlcm5lbC9kbWEvc3dpb3RsYi5jDQo+ID4gKysrIGIva2VybmVsL2RtYS9zd2lv
dGxiLmMNCj4gPiBAQCAtNzQzLDcgKzc0MywxOCBAQCBkbWFfYWRkcl90IHN3aW90bGJfbWFwKHN0
cnVjdCBkZXZpY2UgKmRldiwgcGh5c19hZGRyX3QNCj4gcGFkZHIsIHNpemVfdCBzaXplLA0KPiA+
DQo+ID4gICBzaXplX3Qgc3dpb3RsYl9tYXhfbWFwcGluZ19zaXplKHN0cnVjdCBkZXZpY2UgKmRl
dikNCj4gPiAgIHsNCj4gPiAtCXJldHVybiAoKHNpemVfdClJT19UTEJfU0laRSkgKiBJT19UTEJf
U0VHU0laRTsNCj4gPiArCWludCBtaW5fYWxpZ25fbWFzayA9IGRtYV9nZXRfbWluX2FsaWduX21h
c2soZGV2KTsNCj4gPiArCWludCBtaW5fYWxpZ24gPSAwOw0KPiA+ICsNCj4gPiArCS8qDQo+ID4g
KwkgKiBzd2lvdGxiX2ZpbmRfc2xvdHMoKSBza2lwcyBzbG90cyBhY2NvcmRpbmcgdG8NCj4gPiAr
CSAqIG1pbiBhbGlnbiBtYXNrLiBUaGlzIGFmZmVjdHMgbWF4IG1hcHBpbmcgc2l6ZS4NCj4gPiAr
CSAqIFRha2UgaXQgaW50byBhY291bnQgaGVyZS4NCj4gPiArCSAqLw0KPiA+ICsJaWYgKG1pbl9h
bGlnbl9tYXNrKQ0KPiA+ICsJCW1pbl9hbGlnbiA9IHJvdW5kdXAobWluX2FsaWduX21hc2ssIElP
X1RMQl9TSVpFKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gKChzaXplX3QpSU9fVExCX1NJWkUpICog
SU9fVExCX1NFR1NJWkUgLSBtaW5fYWxpZ247DQo+ID4gICB9DQo+ID4NCj4gPiAgIGJvb2wgaXNf
c3dpb3RsYl9hY3RpdmUoc3RydWN0IGRldmljZSAqZGV2KQ0K
