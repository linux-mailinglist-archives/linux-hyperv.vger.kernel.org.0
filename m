Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DCB4DE298
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Mar 2022 21:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238926AbiCRUjA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 18 Mar 2022 16:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbiCRUi7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 18 Mar 2022 16:38:59 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021014.outbound.protection.outlook.com [52.101.62.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD2219530D;
        Fri, 18 Mar 2022 13:37:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJVvTnYL1CJL6ojOEU/2ENGD+9I/SqeOwfOfLgq4PyBOyegEXVfnJqH89Blo+FzJVolLitTlPHoDaV/nq3ONqIuSLt/3S4lMBAQPL2f/1f2LKA9JpJ+VOGmHriCbTRcuwFd/nqLlaZ7JQfbsNGP66pnlbCsYdQVHuRzh7Nq6WJGufVycCz4uCrhVaOzgFqSKQIj3V68685/IOgIsSLLmtICeSxjwt1lsZOGyET6UMUdz2vut/FoeOBQpZSgIMjHXge4Tl0HpuASskWQIMmYtXL3PY+1KEG/wH6p4H5D4fKFrBmw1u4OnC5dYukb4QAG6U36xZZWjgOmf/9i6pQrzNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7a4qEFmgyjG4iR0Il0t6JkyxJy0JBHt0iUNKI4YP/Wk=;
 b=l1Nr6LKYWXJJsNyz6bSYO2yMRgTwdhXCt/xBu310wG+6qijIGg5MKJ5TIEp8vo4s7Su8YQ25EMlMe2JLkcVSf9WRWDBllcuNFliZ/9Xu0/Cju+KjIZFxjGApEx9xbVspdHNWa5FI1QLsSl6v9GewHSla7fGyU93ZyMU4zT24yVto/ttLdJM0Q+UlGuCmRpMyUY4twUYtH+HX+dZs3xFMduM67Ut1zTMEmhuLU5UDdPLi5k5mMlGLMF3uc+FjRH6C3Ji0kwTNf2Syg5qsEWUoND4Y9Y0kECzsjmwt3ARK1aSo+ygCHO3Ygp7aI3DbdOdiCk9R2i8ZaWRxE1OuhhvWDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7a4qEFmgyjG4iR0Il0t6JkyxJy0JBHt0iUNKI4YP/Wk=;
 b=iohgPQeUTLjlSQ7+ij/07TX7ssImMdY3wlCNsVwwdRwR4GdDfXYRBBG9BstWkSosqE5c7STUOWX8q8RmGHl2fGyy7vrRoUjvcC7GFh4t5LprJQq5VpGGnbV9clMrrul95MGM7DLXonz3F/+aQhqBmi/MZt7S4l7UxJnGbAVrguc=
Received: from BY3PR21MB3033.namprd21.prod.outlook.com (2603:10b6:a03:3b3::5)
 by SJ0PR21MB1295.namprd21.prod.outlook.com (2603:10b6:a03:3fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.8; Fri, 18 Mar
 2022 20:37:37 +0000
Received: from BY3PR21MB3033.namprd21.prod.outlook.com
 ([fe80::ed64:ab10:6089:b736]) by BY3PR21MB3033.namprd21.prod.outlook.com
 ([fe80::ed64:ab10:6089:b736%3]) with mapi id 15.20.5102.011; Fri, 18 Mar 2022
 20:37:37 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH 2/4 RESEND] dma-mapping: Add wrapper function to set
 dma_coherent
Thread-Topic: [PATCH 2/4 RESEND] dma-mapping: Add wrapper function to set
 dma_coherent
Thread-Index: AQHYOhun4uC65iF9N0WLjvFVH12YmqzD0iIAgAAbKECAAQ89AIAAnxpw
Date:   Fri, 18 Mar 2022 20:37:37 +0000
Message-ID: <BY3PR21MB3033AE8398AEDD0FA510D9B4D7139@BY3PR21MB3033.namprd21.prod.outlook.com>
References: <1647534311-2349-1-git-send-email-mikelley@microsoft.com>
 <1647534311-2349-3-git-send-email-mikelley@microsoft.com>
 <d480c8ea-f047-2854-b1cf-041475b451db@arm.com>
 <PH0PR21MB30252951848A6328E11385A4D7129@PH0PR21MB3025.namprd21.prod.outlook.com>
 <249e5876-f8c6-0236-16fa-a611a9f9e0b2@arm.com>
In-Reply-To: <249e5876-f8c6-0236-16fa-a611a9f9e0b2@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=94f7cd16-b3a5-476e-9f8d-ed225961c845;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-18T20:37:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e233f69d-d6f6-4dcb-7304-08da091f23cf
x-ms-traffictypediagnostic: SJ0PR21MB1295:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <SJ0PR21MB1295108BA0BA4CBB864B0AA2D7139@SJ0PR21MB1295.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FEOukt34hA41tfoz6mIGI0m2u7K4SD6sCphCFfQUVIadcNUbnm1f+xcgba2ZLcFFUvIlMKb2WyduFRHNl8TmNmvx+AFHwsJai0wTHolB9mEoGKYKmledgVS/ht+LG2fJJCVYpoCJdQqrn14X4aUVRO1CV6ln3QyEnqzkF3Xzx+8yreog1jc94zJ5dm589OSTHj0nvGfg07iUn2eoMhNMMEl34vcKsII0Tso5X++uwNPzjxCM7OAn0Mnvnw962VD2i/9humaCv+qh+CnUPLCM+alaPbKLi9dJmaWEHz4fhj1nX4K+KkEAaQA/mU0kTPdE7OJqrM2eMlmLX3a1ksg9Y1RxI1Y6ceAU8rHgtL2oimTmKsoHjn8oUKuBJcCj4iXCmFnOLmHwISHyZlnXJ1pL59sgNW0h0z+gNjiuBmZImbHoHii0cVx/zX00cBv2S9Njufm8gSuqIExXYjatNmdIq/rKSnMo/asPRmDryF8fg1rd8XCHS5pS1IuJ153uOj4/8Tq2pwkxytzKcTN8J4ckARsFbPFNbsMYYEbTHLh4uOTxlVQO2pawagm+OcKKvZoc/2wnb4UkhqEVOHQVKEwyKqC86RRGMstNmpMSnEROK72xSWxcbSteTnczFXuYJTU3ajWNm5GRT7G1tu8jSMwEu7vaZMlrCxVos5oyhHk++dES3ae8u/Xc3x+X0ZSKkduBanxpFIV1rVYP1Sl5BN40qmUPpazAvvVbDMFRkgBkmKcNbc3YwO4TCjIQTpRCo/A0Ha7ld9SXE4TYNCrm8yJ/Ew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR21MB3033.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(8936002)(66476007)(38070700005)(66446008)(66556008)(71200400001)(76116006)(8990500004)(53546011)(6506007)(7696005)(64756008)(55016003)(110136005)(86362001)(316002)(66946007)(8676002)(9686003)(26005)(52536014)(921005)(38100700002)(82960400001)(10290500003)(82950400001)(508600001)(33656002)(5660300002)(83380400001)(122000001)(7416002)(186003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnRsZW9TWmluWkFFUkMwM1BvYWFwM1RZU1VzNHFiV29CYXVGRDZ1MXdoRHN1?=
 =?utf-8?B?UDY2VFFOMTBoUkhmeVJEY0pqU2Z3LzZyWW4zQkxYNFU3cWZCU1BpZTMzS3hu?=
 =?utf-8?B?SUF4VW5XWVhndHdJYkt1czhMUkJlNzBWWWgrbEtZdHdIYjVWTWZHVDNkaTVF?=
 =?utf-8?B?d1NpOEdjQmRYYXovR0J5ODdmQTAxTGNwRklXbm16azB1ZWpTRHNvbHBrQXZj?=
 =?utf-8?B?VEdWK25NSTNoMDNUSXhJdmcvbnltUkpCRGNvMkFUdDQ5UDVocjZtOU1xMkRx?=
 =?utf-8?B?V3dWeGRKQ1J6RmtOVmI2RlU1dGlLZ3JzNXVmMExzMkZJWDZYYjdoZExTU0hB?=
 =?utf-8?B?S3lrazRnWXFZNHRnaDA4ZU4xME1IQU5TZ1dJZDRiNnBjNzUwZi9JVEJTSzF4?=
 =?utf-8?B?YWdmMjdoMnZrb2dxbk5UbjJuY1VMNCs0MDJ6YXFPZEYyY2czb3RFOGdwTzND?=
 =?utf-8?B?NHV1eTF0ajAvMXh1TGZEMzlpWlpDdEFvUUpWcmdYRlg1dEZvMUwxTDIvRnlF?=
 =?utf-8?B?UmRmNnhlY05jSDZtYVhMQlhTUGxZQTBqOGNQdUIrakNkM3dSaE5HU05aREJt?=
 =?utf-8?B?dWNrd1ErR1ZiczViK0NCVE1mNHA3aXFaaHJ4M25aUDNXeVdBSENLS3RVMkoz?=
 =?utf-8?B?M2JDME5tYWNGV05BVVBGaFZDZWFpb0xyWnlkZ0ZxWXUvdDB3YVRyY3pieHBS?=
 =?utf-8?B?S0o2Rkc3Y1ltYmZ3djVBSlc1ZWI0eXNjeFFLbUpwWDhlWnEwUWUzZnMzSmN2?=
 =?utf-8?B?eFB2Yy9jUzFXQVVEMXlTa09CVW1NdjJQcE9yUXg5ZmRMNUYwOUVWcEJseEww?=
 =?utf-8?B?Y000WXN3dnhzRFNKK1ZFSVZoOWZQakZYZjFnKzFWaEtQNVFqN3d6THFSSXNZ?=
 =?utf-8?B?eDBzOXkvWXl5VjJRWFVHQWdVcWppS1pVUnEwQ21FM1BjeHkvTmpCU2FqTENj?=
 =?utf-8?B?eVJ5NE15cnBMaDBsTCtYSXZycnlpaFVha3NXTUVvbE85SW5FNDh3L2Jrc1RZ?=
 =?utf-8?B?M0pjcXVmUVN6dkRUQjNQRm1oMzExZldqMU5jdUVXWFVzRks0VUxwVzZwa0Nx?=
 =?utf-8?B?MXVBQ1I1TUkwMUVDWWZOUlR2Nk1LMWVhbHlxYkhXckNiOTQwLzBDV3p0S1Yw?=
 =?utf-8?B?RVZJcmZNZWJRdzZWNGtCaVJVaUpXTUtiUE1Md2I5cXpKNDkwVHR3cnFNQ2pq?=
 =?utf-8?B?SVRwTUtwNmFVMWZpanRabThxeGJvWEE4VDVnbnJ1MTYxQXl4dVFhMjIvakM0?=
 =?utf-8?B?T3owZElPNGlldGJWeXpOQnBlRmt0STVlVHNob0RXTldKSU1zSTZmZUtPSS9F?=
 =?utf-8?B?ZjJRQjFVOU9mcmpiREZlTjV3Nnl6RTM3elNzTVYwY0k3RFh6bzV3Y1Y2dmt6?=
 =?utf-8?B?R1BpUHNjUnBLd1FqNXpPbVV1UTl0WFROUXBuOXc4NTEydjhnWEJMWGROc0ow?=
 =?utf-8?B?VEhtWHBXZ2hxSFZiWm0rMXN0NUE4V0NTTjBTU3lVcGJwVUpTZE1BN0ZQUU1h?=
 =?utf-8?B?T3dheEVxUE9ZR2lUbDJxNTF6Y3VGdWpnL2lHcUdNZGtYV1Y5YXFzVm9XazYr?=
 =?utf-8?B?QTJORXJXcnVXSDdBTXNUN2k0VDdlUFNwUGNRL3BkS2p1WVNNOTlHeVRsZThU?=
 =?utf-8?B?N3BuOTlQcXNZYTBlODc2L2RkV1BscE1nVVllYmdsSzRvelNYSm0wUmxuTmFm?=
 =?utf-8?B?UkhDVThRRmd0WmJCY2gyeFE4eS8vbi9IV2VHcndSM1NvN3ozMnRQdVRxMm5U?=
 =?utf-8?B?UE9ETTdDQ1VqaUU2MVh5L3lkSXVqU2ZlS3U1LzlWbk9Odlh2UDZVT0hFMmRF?=
 =?utf-8?B?TGdMQ0VkY1JJSTljVHYrcEp2eWtmOWczSGd4N3hNOS9wMjZTVmNjWFdpTUpw?=
 =?utf-8?B?RjYxaGJIdjRpTVF2bUY5eCtZYUVDbmpmL2NFOXJwNHFLOEJCNUhKRmdqY2tv?=
 =?utf-8?B?dDFialdvTysxeHlqSGlMMVdsREovSlJNS21HMUZuNnNiZGdmR242ajVvblpj?=
 =?utf-8?B?SGN0cEhXUzVnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR21MB3033.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e233f69d-d6f6-4dcb-7304-08da091f23cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 20:37:37.4280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RL2ysU7CBGrhj3aJN620R9DIY1ijFghVdOubSzis5Xhhd1pT6OZo+uYT6+hRLt1AqBcaHRwCGO0pYTfy+boLI0Qd5PRGiFD0OtGgtDLpz8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1295
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4gU2VudDogRnJpZGF5LCBN
YXJjaCAxOCwgMjAyMiA0OjA4IEFNDQo+IA0KPiBPbiAyMDIyLTAzLTE3IDE5OjEzLCBNaWNoYWVs
IEtlbGxleSAoTElOVVgpIHdyb3RlOg0KPiA+IEZyb206IFJvYmluIE11cnBoeSA8cm9iaW4ubXVy
cGh5QGFybS5jb20+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAxNywgMjAyMg0KPiAxMDoyMCBBTQ0K
PiA+Pg0KPiA+PiBPbiAyMDIyLTAzLTE3IDE2OjI1LCBNaWNoYWVsIEtlbGxleSB2aWEgaW9tbXUg
d3JvdGU6DQo+ID4+PiBBZGQgYSB3cmFwcGVyIGZ1bmN0aW9uIHRvIHNldCBkbWFfY29oZXJlbnQs
IGF2b2lkaW5nIHRoZSBuZWVkIGZvcg0KPiA+Pj4gY29tcGxleCAjaWZkZWYncyB3aGVuIHNldHRp
bmcgaXQgaW4gYXJjaGl0ZWN0dXJlIGluZGVwZW5kZW50IGNvZGUuDQo+ID4+DQo+ID4+IE5vLiBJ
dCBtaWdodCBoYXBwZW4gdG8gd29yayBvdXQgb24gdGhlIGFyY2hpdGVjdHVyZXMgeW91J3JlIGxv
b2tpbmcgYXQsDQo+ID4+IGJ1dCBpZiBIeXBlci1WIHdlcmUgZXZlciB0byBzdXBwb3J0LCBzYXks
IEFBcmNoMzIgVk1zIHlvdSBtaWdodCBzZWUgdGhlDQo+ID4+IHByb2JsZW0uIGFyY2hfc2V0dXBf
ZG1hX29wcygpIGlzIHRoZSB0b29sIGZvciB0aGlzIGpvYi4NCj4gPj4NCj4gPg0KPiA+IE9LLiAg
IFRoZXJlJ3MgY3VycmVudGx5IG5vIHZJT01NVSBpbiBhIEh5cGVyLVYgZ3Vlc3QsIHNvIHByZXN1
bWFibHkgdGhlDQo+ID4gY29kZSB3b3VsZCBjYWxsIGFyY2hfc2V0dXBfZG1hX29wcygpIHdpdGgg
dGhlIGRtYV9iYXNlLCBzaXplLCBhbmQgaW9tbXUNCj4gPiBwYXJhbWV0ZXJzIHNldCB0byAwIGFu
ZCBOVUxMLiAgVGhpcyBjYWxsIGNhbiB0aGVuIGJlIHVzZWQgaW4gUGF0Y2ggMyBpbnN0ZWFkDQo+
ID4gb2YgYWNwaV9kbWFfY29uZmlndXJlKCksIGFuZCBpbiB0aGUgUGF0Y2ggNCBodl9kbWFfY29u
ZmlndXJlKCkgZnVuY3Rpb24NCj4gPiBhcyB5b3Ugc3VnZ2VzdGVkLiAgYXJjaF9zZXR1cF9kbWFf
b3BzKCkgaXMgbm90IGV4cG9ydGVkLCBzbyBJJ2QgbmVlZCB0bw0KPiA+IHdyYXAgaXQgaW4gYSBI
eXBlci1WIHNwZWNpZmljIGZ1bmN0aW9uIGluIGJ1aWx0LWluIGNvZGUgdGhhdCBpcyBleHBvcnRl
ZC4NCj4gPg0KPiA+IEJ1dCBhdCBzb21lIHBvaW50IGluIHRoZSBmdXR1cmUgaWYgdGhlcmUncyBh
IHZJT01NVSBpbiBIeXBlci1WIGd1ZXN0cywNCj4gPiB0aGlzIGFwcHJvYWNoIHdpbGwgbmVlZCBz
b21lIHJld29yay4NCj4gPg0KPiA+IERvZXMgdGhhdCBtYWtlIHNlbnNlPyAgVGhhbmtzIGZvciB5
b3VyIGlucHV0IGFuZCBzdWdnZXN0aW9ucyAuLi4NCj4gDQo+IFllcywgdGhhdCdzIGVzc2VudGlh
bGx5IHdoYXQgSSBoYWQgaW4gbWluZC4gSWYgeW91IGRpZCBwcmVzZW50IGEgdklPTU1VDQo+IHRv
IHRoZSBndWVzdCwgcHJlc3VtYWJseSB5b3UnZCBlaXRoZXIgaGF2ZSB0byBjb25zdHJ1Y3QgYSBy
ZWd1bGFyDQo+IElPUlQvVklPVCwgYW5kIHRodXMgZW5kIHVwIGFkZGluZyB0aGUgcm9vdCBjb21w
bGV4IHRvIHRoZSBBQ1BJIG5hbWVzcGFjZQ0KPiB0b28gc28gaXQgY2FuIGJlIHJlZmVyZW5jZWQs
IGF0IHdoaWNoIHBvaW50IGl0IHdvdWxkIGFsbCBnZXQgcGlja2VkIHVwDQo+IGJ5IHRoZSBzdGFu
ZGFyZCBtYWNoaW5lcnksIG9yIGNvbWUgdXAgd2l0aCBzb21lIG1hZ2ljIFZNQnVzIG1lY2hhbmlz
bQ0KPiB0aGF0IHdvdWxkIG5lZWQgYSB3aG9sZSBsb2FkIG9mIHdvcmsgdG8gd2lyZSB1cCBpbiBh
bGwgdGhlIHJlbGV2YW50DQo+IHBsYWNlcyBhbnl3YXkuDQo+IA0KPiAoQnV0IHBsZWFzZSBsZWFu
IGV4dHJlbWVseSBoZWF2aWx5IHRvd2FyZHMgdGhlIGZvcm1lciBvcHRpb24hKQ0KDQpBZ3JlZWQh
DQoNCj4gDQo+IFRoYW5rcywNCj4gUm9iaW4uDQo=
