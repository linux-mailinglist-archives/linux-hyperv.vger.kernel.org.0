Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD987744140
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jun 2023 19:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjF3Rby (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 30 Jun 2023 13:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjF3Rbx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 30 Jun 2023 13:31:53 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2099.outbound.protection.outlook.com [40.107.93.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044F5E6C;
        Fri, 30 Jun 2023 10:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1s1duFrvudNEvXldN9pDjeWUTlyao+RcfqLDoRFj82Pc7Y6wEKYDmllFZ2JtueShnfcrHb3ADSFd8mY4Kb9RwDguE45s+iHNaLgm9f8L0OOnaqXUx2vRyAra7GBm/heP7+W0Hbmn+kcR/95orfTx9T7821kA0fdowNqRXIkpQvKsrUDsW28bbZZDh46QPG9w1CLzu1QaLlXWVFrGbxc/cndCpUXCNX1yuv4J88rlBUlg3bWwOfgIYveUqOlzYXi7yci1iHzlegSZJgOcW7saqgH6AVk3FSOdyrdwMPPs+6CNEPavwFWpGz91hWWolg+nS1cawrCz1bIYk6WWzP15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihsm2Fl4pzStFYVMW8j2ScVeO41/kZ3SIWR5Yvg/Ilc=;
 b=fYkbWBky8fk7PR8eAVDm5L1MXZk3Ts/PahGnNGEVH89C+ZxKoe3h54NveERs3cPmNBLUUnwMNAWw33tkc5r+RQjf20fP6pRejq2CzDYLyF/22cAYZSPENOD74P+A54IzaHZ+UrrSEQhfw8vV5yLtGVGtsmrrUIl2h0MAn48b3dINyRKzsJoWjBUl07kZU+VzOjqEJSCL0vjVo1sD+XTGLJDmUv5j/JCA76t4mgBLdM0aW5v/SwItkFz7wrh3ItZvnlb3+rLSeLfDsMcrQt6or9Vky2lyy07g98PRWoydzvSVBwkYv2AZFItF3Gi2vmjrc+KJSfWQOtjWKlUXsA1n3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihsm2Fl4pzStFYVMW8j2ScVeO41/kZ3SIWR5Yvg/Ilc=;
 b=PxF7Akofgpd67PnDFO9L1JoI1T5bF7RGz+udzfNnBoNgH9VMMLuFG8HuSW5Y6lK7dHaLeoGPU9X6i5QOTtmC3v9Vk5T01AFyocWqAcUpUVeQr+ESBvcWMDrf9InT3q+ycXD6FmWI4Ih1C30bxbXD8TAfWuPgpS6P8GS2ULHOpJw=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by SJ1PR21MB3650.namprd21.prod.outlook.com (2603:10b6:a03:452::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.8; Fri, 30 Jun
 2023 17:31:48 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::eee5:34cd:7c3b:9374]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::eee5:34cd:7c3b:9374%5]) with mapi id 15.20.6544.002; Fri, 30 Jun 2023
 17:31:48 +0000
From:   Long Li <longli@microsoft.com>
To:     Paolo Abeni <pabeni@redhat.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Patch v3] net: mana: Batch ringing RX queue doorbell on
 receiving packets
Thread-Topic: [Patch v3] net: mana: Batch ringing RX queue doorbell on
 receiving packets
Thread-Index: AQHZqInuIa+OQxGM80ioo4gKQGwCLa+hejgAgACaBvCAARhFAIAAZi9A
Date:   Fri, 30 Jun 2023 17:31:48 +0000
Message-ID: <PH7PR21MB326330931CFDDA96E287E470CE2AA@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1687823827-15850-1-git-send-email-longli@linuxonhyperv.com>
         <36c95dd6babb2202f70594d5dde13493af62dcad.camel@redhat.com>
         <PH7PR21MB3263B266E381BA15DCE45820CE25A@PH7PR21MB3263.namprd21.prod.outlook.com>
 <e5c3e5e5033290c2228bbad0307334a964eb065e.camel@redhat.com>
In-Reply-To: <e5c3e5e5033290c2228bbad0307334a964eb065e.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d7f9d6c6-6fc9-44ee-a1f2-a35b2878af39;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-30T16:42:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|SJ1PR21MB3650:EE_
x-ms-office365-filtering-correlation-id: de9b29ae-ce18-47b8-290a-08db798fe21f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yoBk+S9Pd04yxbIFsgS6F/ei8L8/CLBAbU4qD9QQsPvTRIMPFQYHDMUgTFohJroC4gYO8fkFOYe9PbaoLJz6m+UuJNKJY/c8PyB+PdW+eehaLy1C0cOBHzP+fIJSLnf2SYSBBzn7X6faTiPOq4N75QR5rmbWPsTPoYxc1gQdgiLymUswD7TweATa4BKMML3yyF1B8Me7esQOrxH/hjzWxzRgePwdl5CuW1iC+Ohaqvu7WMNXx9LjULWXdqG75R9XCEdfmeUaWSqGFTP6oagwHRPMCeRNYueDFZtJlCseD56Z9T5z52caW6SkPzWOd4YArHlmLCnl82smIJPX4KtW1eN/bSr+oXioSIHI6snBsMh47sxmVl86CfVLcFnbP/xvd3sLcoVnafzGT5MQA7vOdnjgXMT+uIaL6AVmUAfIJzOKPzxPVp1QmdWOUervi6zGwIWpxsDT2wqkyU2vs6AptX94cz3blvuHtHFbwBPb/Wo9++zQ51yR4OEG5ucdse2/qE0agnyB0PNJmUHpGy0hahRWEbgpO/V5UxA0UjFw16Z3HlPABEI3uoUJ+llOJyACKEid+QT54XlGMVN7T7td7PuI9UozniFE320+/flYhE8FwTyG8nmPcdY+AaDPt78XERoGYv7IQxrERP0fzfZ+MZJ55kGjYVpGjOwVvCM37/n1INkHs7Fcqblbdyn8+5XX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(52536014)(86362001)(54906003)(71200400001)(8936002)(8676002)(5660300002)(110136005)(7416002)(26005)(10290500003)(9686003)(6506007)(33656002)(7696005)(478600001)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(41300700001)(76116006)(316002)(186003)(38070700005)(2906002)(83380400001)(8990500004)(55016003)(921005)(82960400001)(82950400001)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHRub3NWckt2bFpVMlRMZTJ6ZVNMM0ZuRFFsT0gzK0lVcDJZUWhEK1dGVzNr?=
 =?utf-8?B?bkNtdzJnTVhMeW90Wmpna3VTNURrQzhLYXFqTDY4NWY1SlZqTk9ES2JObkNF?=
 =?utf-8?B?RXpkdmZWN1FxTExweHI3azNab0xPcFluVDRpUkdKQUFLTy9qWmtoVk5BZ245?=
 =?utf-8?B?Yk9nWGhLTHdRb1VYS3JQejN4bU4xeXFFTlZubjBQa200VUR5OG5YZXBFS2lY?=
 =?utf-8?B?bzV2OEJwelI3d1pjenhvd3BkK2E5TWhhZzl1ZUlzQUhJZzdGcXF0QWNuOFQw?=
 =?utf-8?B?c0hieDE0bUlOSmJEVmlocEFpeHNuOUcrdXBhYWd3dTJsNkVNMlA1ZGR5TkFT?=
 =?utf-8?B?K1BSK0VTNThoS29xWi9lWW5BOWNqRXVzYlZJZW93S3kzUlF4REZua3V6MDkv?=
 =?utf-8?B?VEE5S1lzaWwxV1ZnZnhxVHBKQTBmYnptbjRwY2pBMVlnQWhCdXlkTFdUN082?=
 =?utf-8?B?N044OHNNUW51N1F3NzdycXVub3NJdnd2dDV5ako5L0k0MktvN3RsdFBsanBJ?=
 =?utf-8?B?UVZPcjBNUHhERkkwYk5TZ0dxRU81VXJGKzkrdXNqK0lZYUFvb2s4K2l1cEwz?=
 =?utf-8?B?QnJTYlRzQnAyZ2pHQ1orZ0lvdHI4ekxnN0IvbWJ1WGhSMTZsTGRyMFVIQUR4?=
 =?utf-8?B?MDJOZGxsak9MWTJ2U1NldjJEM2NNZExMV21VZDlVWjBZU3hkZ2ZUU25UTDJ2?=
 =?utf-8?B?SGlKOG4vanlKekVrVk94ZVM3b280VFlCb1ZtTElQd3ozbGRKTDREOXgvZHpU?=
 =?utf-8?B?Mm1rYW5HRXFhTWVGZjErdW9VMnZvdFkrM0hzYVpQbnlWWmRlenlXYTYySVdJ?=
 =?utf-8?B?ZGNDMXY2cEF5OVJzNkdLV2NVRE5hcExZSUdwR3hjWTJObjdpRVF5d3pKYmZN?=
 =?utf-8?B?M3NmZ0pSTENWRGZIWTluR250UjlENWpiMWZOdG1uNGRxTEZXUjloRU0wUTBv?=
 =?utf-8?B?WHRtblZQWGZmUmtsYnFkbVExNzVZSTFZelN1TncvbUZ5TTFtT3FOaWV5YkJk?=
 =?utf-8?B?MHE5bFcvMVVKM2Zsb2RQdVRJQTJxQ2xIZ0h4ak5Db3Mrak1NaktiYVNKWld4?=
 =?utf-8?B?YVV4WDFVZU5OSTVrVVFlZ2NjdTN5WGZHWWJFenBsS2QwbzhkN0NleWZ4ekRS?=
 =?utf-8?B?WlNRME5BdFpwY1lFTjIzYnNnM0wweTZ0cDJNL0pITGFlcmJGOE1oS05GWXZy?=
 =?utf-8?B?SGtIL2pEU0VjdE9Va0RUK2FtcXh0bjR3ZVk1MGpnc3lFaFV5Nnl3eFNQNzly?=
 =?utf-8?B?UzA4TFNXeEhuaUZzS2NPdFVDUk05eldGYzY2c0V5QU0wNzFiRzkrT2JZRWdk?=
 =?utf-8?B?dXZFOWVtTUNLeXIzZEdNYjY1RXN5bUNTbzFjbWRpY295Mk4xbkVJbEQyZ0dU?=
 =?utf-8?B?eHgwMXhZKzNXak1RbTNKSWUwMjlYK3pEak5hSm5uQzBQS3RSOW9UbVhJUXFa?=
 =?utf-8?B?eTN4R2k4SVpWZ2U4bkp0NVMxYk14NWMvLzd2VWRKV3lJOTdnajFoQUExTDlk?=
 =?utf-8?B?bTlqL0M5WHhVeVAxREZQbkdvbGEwMEJVVGdaSStHaTBkTFJjM1RUUUljVmdX?=
 =?utf-8?B?SVE5eURJUGpsWVNDWkYrdGNuUnZTRGg3V1pHaDk3cVpUR1ZxazhDVWVybnBO?=
 =?utf-8?B?YjFKaXRjY2hKd0FsdHhhWEpmNTZIQ1lnWEQyRHpIbGZXR1dyY3NmUGJpbTQ0?=
 =?utf-8?B?SndWRWpkTTZiVDdwSXN4UjNqVDFtdkNOUzg4aGtxTVVaeXE0Y21rby9xWXJr?=
 =?utf-8?B?akUxN1ZyVjluMVc5a2lMT0hqbWM4bmpRdkQ3NEtlNWFwRXNmTjBwKzhuajRD?=
 =?utf-8?B?dDVjOFBnQy9PaGRJajBBN1U3NlhQL2R3QVJUZmtNckxaVnliQ0hyYVJFbzBh?=
 =?utf-8?B?c1diVE94TmlyZmVvY3pRazRHdVdiT0kxZlJSdkdLTDlzYlRDMHpJaG5xODVt?=
 =?utf-8?B?Um5iM0lyUTlYMVdjbmZHVm5KaWxBbStCRmdiaWNTMndlUEpVdnZ3ZEg1UVR4?=
 =?utf-8?B?eW0yejMyOXJlbE4zN2JnVUs0ZHlNWDg2c1dKK0Z3cjhsRFM3ZUtuNXdIc1ll?=
 =?utf-8?B?WDl0d0Uxc3VQM1pMb0VvMlNOQTJiL0d2TGxoaFVqRWF0VFlYVTAwdi9wYmlV?=
 =?utf-8?Q?lAssl2dkHrihewIsgDRCWYmOO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de9b29ae-ce18-47b8-290a-08db798fe21f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 17:31:48.3591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4CZLan14qMjTz1wT0oy3vc3ibY7JZ0z/QLPnAKH1JeW8D6y8U8MpVRJUGVMUb/YiCXNWLaPxnhoJ3rsdO/YZJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3650
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BhdGNoIHYzXSBuZXQ6IG1hbmE6IEJhdGNoIHJpbmdpbmcgUlggcXVl
dWUgZG9vcmJlbGwgb24NCj4gcmVjZWl2aW5nIHBhY2tldHMNCj4gDQo+IE9uIFRodSwgMjAyMy0w
Ni0yOSBhdCAxODoxOCArMDAwMCwgTG9uZyBMaSB3cm90ZToNCj4gPiA+IFN1YmplY3Q6IFJlOiBb
UGF0Y2ggdjNdIG5ldDogbWFuYTogQmF0Y2ggcmluZ2luZyBSWCBxdWV1ZSBkb29yYmVsbA0KPiA+
ID4gb24gcmVjZWl2aW5nIHBhY2tldHMNCj4gPiA+DQo+ID4gPiBPbiBNb24sIDIwMjMtMDYtMjYg
YXQgMTY6NTcgLTA3MDAsIGxvbmdsaUBsaW51eG9uaHlwZXJ2LmNvbSB3cm90ZToNCj4gPiA+ID4g
RnJvbTogTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+DQo+ID4gPiA+DQo+ID4gPiA+IEl0
J3MgaW5lZmZpY2llbnQgdG8gcmluZyB0aGUgZG9vcmJlbGwgcGFnZSBldmVyeSB0aW1lIGEgV1FF
IGlzDQo+ID4gPiA+IHBvc3RlZCB0byB0aGUgcmVjZWl2ZWQgcXVldWUuIEV4Y2Vzc2l2ZSBNTUlP
IHdyaXRlcyByZXN1bHQgaW4gQ1BVDQo+ID4gPiA+IHNwZW5kaW5nIG1vcmUgdGltZSB3YWl0aW5n
IG9uIExPQ0sgaW5zdHJ1Y3Rpb25zIChhdG9taWMNCj4gPiA+ID4gb3BlcmF0aW9ucyksIHJlc3Vs
dGluZyBpbiBwb29yIHNjYWxpbmcgcGVyZm9ybWFuY2UuDQo+ID4gPiA+DQo+ID4gPiA+IE1vdmUg
dGhlIGNvZGUgZm9yIHJpbmdpbmcgZG9vcmJlbGwgcGFnZSB0byB3aGVyZSBhZnRlciB3ZSBoYXZl
DQo+ID4gPiA+IHBvc3RlZCBhbGwgV1FFcyB0byB0aGUgcmVjZWl2ZSBxdWV1ZSBkdXJpbmcgYSBj
YWxsYmFjayBmcm9tDQo+ID4gPiA+IG5hcGlfcG9sbCgpLg0KPiA+ID4gPg0KPiA+ID4gPiBXaXRo
IHRoaXMgY2hhbmdlLCB0ZXN0cyBzaG93ZWQgYW4gaW1wcm92ZW1lbnQgZnJvbSAxMjBHL3MgdG8N
Cj4gPiA+ID4gMTYwRy9zIG9uIGEgMjAwRyBwaHlzaWNhbCBsaW5rLCB3aXRoIDE2IG9yIDMyIGhh
cmR3YXJlIHF1ZXVlcy4NCj4gPiA+ID4NCj4gPiA+ID4gVGVzdHMgc2hvd2VkIG5vIHJlZ3Jlc3Np
b24gaW4gbmV0d29yayBsYXRlbmN5IGJlbmNobWFya3Mgb24gc2luZ2xlDQo+ID4gPiA+IGNvbm5l
Y3Rpb24uDQo+ID4gPiA+DQo+ID4gPiA+IFdoaWxlIHdlIGFyZSBtYWtpbmcgY2hhbmdlcyBpbiB0
aGlzIGNvZGUgcGF0aCwgY2hhbmdlIHRoZSBjb2RlIGZvcg0KPiA+ID4gPiByaW5naW5nIGRvb3Ji
ZWxsIHRvIHNldCB0aGUgV1FFX0NPVU5UIHRvIDAgZm9yIFJlY2VpdmUgUXVldWUuIFRoZQ0KPiA+
ID4gPiBoYXJkd2FyZSBzcGVjaWZpY2F0aW9uIHNwZWNpZmllcyB0aGF0IGl0IHNob3VsZCBzZXQg
dG8gMC4NCj4gPiA+ID4gQWx0aG91Z2gNCj4gPiA+ID4gY3VycmVudGx5IHRoZSBoYXJkd2FyZSBk
b2Vzbid0IGVuZm9yY2UgdGhlIGNoZWNrLCBpbiB0aGUgZnV0dXJlDQo+ID4gPiA+IHJlbGVhc2Vz
IGl0IG1heSBkby4NCj4gPiA+ID4NCj4gPiA+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcN
Cj4gPiA+ID4gRml4ZXM6IGNhOWM1NGQyZDZhNSAoIm5ldDogbWFuYTogQWRkIGEgZHJpdmVyIGZv
ciBNaWNyb3NvZnQgQXp1cmUNCj4gPiA+ID4gTmV0d29yayBBZGFwdGVyIChNQU5BKSIpDQo+ID4g
Pg0KPiA+ID4gVWhtbW0uLi4gdGhpcyBsb29rcyBsaWtlIGEgcGVyZm9ybWFuY2UgaW1wcm92ZW1l
bnQgdG8gbWUsIG1vcmUNCj4gPiA+IHN1aXRhYmxlIGZvciB0aGUgbmV0LW5leHQgdHJlZSA/IT8g
KE5vdGUgdGhhdCBuZXQtbmV4dCBpcyBjbG9zZWQNCj4gPiA+IG5vdykuDQo+ID4NCj4gPiBUaGlz
IGlzc3VlIGlzIGEgYmxvY2tlciBmb3IgdXNhZ2Ugb24gMjAwRyBwaHlzaWNhbCBsaW5rLiBJIHRo
aW5rIGl0DQo+ID4gY2FuIGJlIGNhdGVnb3JpemVkIGFzIGEgZml4Lg0KPiANCj4gTGV0IG1lIGFz
ayB0aGUgcXVlc3Rpb24gdGhlIG90aGVyIHdheSBhcm91bmQ6IGlzIHRoZXJlIGFueSBzcGVjaWZp
YyByZWFzb24gdG8NCj4gaGF2ZSB0aGlzIGZpeCBpbnRvIDYuNSBhbmQgYWxsIHRoZSB3YXkgYmFj
ayB0byA1LjEzPw0KPiBFc3BlY2lhbGx5IHRoZSBsYXRlc3QgYml0IChDQy1pbmcgc3RhYmxlKSBs
b29rcyBhdCBsZWFzdCBkZWJhdGFibGUuDQoNClRoZXJlIGFyZSBtYW55IGRlcGxveWVkIExpbnV4
IGRpc3RyaWJ1dGlvbnMgd2l0aCBNQU5BIGRyaXZlciBvbiBrZXJuZWwgNS4xNSBhbmQga2VybmVs
IDYuMS4gKHRob3NlIGtlcm5lbHMgYXJlIGxvbmd0ZXJtKSBUaGV5IG5lZWQgdGhpcyBmaXggdG8g
YWNoaWV2ZSB0aGUgcGVyZm9ybWFuY2UgdGFyZ2V0Lg0KDQpUaGFua3MsDQoNCkxvbmcNCg==
