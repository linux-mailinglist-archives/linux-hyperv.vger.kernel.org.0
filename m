Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5718C6D73A2
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Apr 2023 07:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbjDEFLt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Apr 2023 01:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjDEFLs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Apr 2023 01:11:48 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020027.outbound.protection.outlook.com [52.101.56.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7893A8E;
        Tue,  4 Apr 2023 22:11:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyfmPxIJLesU8Ec9fz4m+TqfIGDsuN5C9Xpc8RwTkKcZ8geBzZfP0jvz30oGsqP3rQyHS4k62nxOxiy0MC6S4DL+FDzCqEwFKvv++LDJavwkmXFy1Se1YuVS+9W01jXQhqW7sWquAbvArM+OMujGQkV6RzzACgXMaGTik2Vj+5GHc0u/Aks1/+zeXZ2S8nC3DOUDPU/7DfmJFD8gin75k4hEWKbxdmgIzoqB5jFl7WaMtUZUu2OhHHxm6pyjKgj1pXnCR5uG989S0/aZgfReOQVc8N96+81xC3grKwUQyBotookusuD00ijqRXGTTarwAtKdxfIRbX3R1w372Dd22w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZDEYv2JFbN8l0oHqSUG5R85TeNpRb9dQL3XvccmJZs=;
 b=MVuAwpidwC0ltPOo9cwJfNI8DG5hmd6sHC+b6pwZ75wjG4g0rJ6vZsRZSs8BS8CgW4znJ7ky2X9blJXGswSxGP5NXcHeixYhxsf+dHAXAOukmy281/8cLOYgqgheWodGBkShQEFq8Dz6Hwy+sy7+mNBMBn9ZYBLLNkvoNXAPb4WQoJVsGAL+gFagdOLM6kzQe1JBuM3QtolthJHzjSmcfyAftc1smmxarcYQ5BCcJuSuCfzurW7vSRmct2Zw4yQuIFel8wi2x76NTUgDwNUUhGn3QcGduzUjfdvKDIgpeUAhs5XkQzXkF4uDc0eDZacBZdFeLnOs1Si2/rAAiYgdNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZDEYv2JFbN8l0oHqSUG5R85TeNpRb9dQL3XvccmJZs=;
 b=QOc3VSoNQXcJBulwSq9uqrGVJDd+UwRodgd7PBSDejgJJpspD43rB/7BwuU0O1bdnX0qweOQPOGiwa4WDpSwKnTyVIRTN19kVjkX8hC9xnFheCvdSWrALBtVZ7C1LZGPW/9qRAJDptOchte3RBBKsz6oV/hWxr4j1fAfIgx6PgM=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by BYAPR21MB1334.namprd21.prod.outlook.com (2603:10b6:a03:115::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.14; Wed, 5 Apr
 2023 05:11:42 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::2e52:d6aa:9a99:500a]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::2e52:d6aa:9a99:500a%5]) with mapi id 15.20.6298.014; Wed, 5 Apr 2023
 05:11:42 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     =?utf-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
CC:     Dexuan-Linux Cui <dexuan.linux@gmail.com>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jianxiong Gao <jxgao@google.com>,
        David Stevens <stevensd@chromium.org>,
        Joerg Roedel <jroedel@suse.de>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] swiotlb: Fix slot alignment checks
Thread-Topic: [PATCH v1 2/2] swiotlb: Fix slot alignment checks
Thread-Index: AQHZZy9yhTeXGQzb+UuJvAtlASQcDK8blAYAgACPDoCAAAMzcA==
Date:   Wed, 5 Apr 2023 05:11:42 +0000
Message-ID: <SA1PR21MB1335C5F774195F2C3431BF93BF909@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <cover.1679382779.git.petr.tesarik.ext@huawei.com>
        <c90887e4d75344abe219cc5e12f7c6dab980cfce.1679382779.git.petr.tesarik.ext@huawei.com>
        <CAA42JLa1y9jJ7BgQvXeUYQh-K2mDNHd2BYZ4iZUz33r5zY7oAQ@mail.gmail.com>
        <CO1PR21MB13320305E02BA121623213DABF939@CO1PR21MB1332.namprd21.prod.outlook.com>
 <20230405064019.6258ebb3@meshulam.tesarici.cz>
In-Reply-To: <20230405064019.6258ebb3@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6911c7cf-2e41-4c4b-a11e-f58737e308cd;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-05T04:51:46Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|BYAPR21MB1334:EE_
x-ms-office365-filtering-correlation-id: f465f3b7-1643-4bf0-3f0c-08db35943e97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VjtOW3kYfvgtAyz+d0TWnYXrTawVgbn7tkwAHtVHHy1P0q4fTsnEFoa5KdGqKbM0p8DBPKKecq+P5n76qcPVtAprN31gEVrcHt/R7jFfHwb8dE2K95TCIzAhkot45Rgh2xHGyIxkvCaQ5v4TTX7WXbP2ntnFuCGh4JCvdbjBKnX+EgrYXCt3SD5jQ0bQ464brmaHZPtTECnTt/Ycgom7ouBMZ3eEFYvW8hfaO8yZYBnrPBbRgOH/NPmxmFDPB+hUeZhIiO/yqPQBnO/DN1iqd23XuOaOoa97TSPdFB3QahO2GIQLzaK2OQOJJl72zrZGPfgYNEV1dIqWdMqiFcKsHo4LOX79KaDGVxmkLCCl9AHXPNx+iMweAIQl6ThOIINFdhvGQz911OjPNluotF1irrDiyq8l62eOIPpbCooo9Ym89xP0A0srLNDfjWoCIlRihXOPBxcKS5b7Q5fv5dkuL4cJM5nolRVgM2qh4ov1lgQxtXDjOkZNC0476/Ooy+lNA0l3fLhpda0R65mTcZfgwLkKJAGAHrOgqG/yBrrStcnyhV8OsIxqUKBuLzkTL7d9SwwYehelQl1wRyeSAaoOSsfd7ze8rh1Zlq9Z0zlYFukLOSg8DK+mYJ2tAU5o4j9ZEmAP+NNHfseXfMsMW3tTlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199021)(83380400001)(966005)(10290500003)(478600001)(7696005)(71200400001)(186003)(316002)(26005)(54906003)(9686003)(6506007)(8990500004)(7416002)(52536014)(5660300002)(2906002)(33656002)(38100700002)(122000001)(66446008)(66476007)(66556008)(66946007)(76116006)(64756008)(82960400001)(82950400001)(4326008)(6916009)(41300700001)(86362001)(8676002)(8936002)(38070700005)(786003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEFEY1FVV0dHc0pqeVFuMmw5TSt5bVdqQmdUMFF0azB4WWxMTGUvUWZ5RWdy?=
 =?utf-8?B?T2RFaDdRUzFuWEJZMmpqU3d1K2xLdWJPUjBldE0zbTYzSFFqU0tFY1VVdTB0?=
 =?utf-8?B?MVRKblovMU1XWVpRNy9TNThFV1FwWTI2VU5Qbm93YXlReFM1eDgyV2J5d25Z?=
 =?utf-8?B?eHZ3ZzF4NHEyQ3F4QW4vNW8zZVVHV1hnalJWQjJ1QTBEd2FCUE9WNjIxTWxO?=
 =?utf-8?B?YjJMNDgyWlREbVNUN1ExOFQ1SmhFWlZTNEJVNWdaWlB2Q05UWWtsdmpsNmFQ?=
 =?utf-8?B?RHdJenYvQytRZ0tROTdPSjV2U21WZWkyQUFkVGpDbmhsY1NsdlNuMm94MWhG?=
 =?utf-8?B?UHFtZk14cDA5WmxDVDhZVjBIbkV2UTNYK0Nvd2VVM2FQOVM1dlRQOXV5bng5?=
 =?utf-8?B?M1h4ZjVhOXI3dVAwV295RWVjc3I4N0YvLzJFZGdGeWFpZ0dkbloxWnNUN1hU?=
 =?utf-8?B?OHdLY2dKTG5rWVE4YmRodUpKSHFwLzhaOHZwUENjYmZDdkhJcVNnVlNhKzFn?=
 =?utf-8?B?ay9JaVIxNjdIV1EwVVhuLzJxTkxBanhNR2xTb1JiamlHbEdxYUVWbFJsZjFH?=
 =?utf-8?B?WGVQZHZRSmZCb05Mb0FxRUZaZE5kWVd5SDdyVDlyY0hXc01Wb29oc2ZMcStn?=
 =?utf-8?B?K2ZNUFYzZFg2ekRpNXo0WUJiSjhxaWFMajRPdmZaQVlTV1pmVzQ2WnFPRTdP?=
 =?utf-8?B?YWFRWWtuYlBpbk5LMEtyQml0bVNoV1VqWkt0OEVGNXkveHdPVlo4WHp2TCti?=
 =?utf-8?B?WUZoL1g0N09qc09YRUFtRzVFOE5jZ2h5cWVEQU1TdlA0UTV2Qm1WNlNYSVFC?=
 =?utf-8?B?U05JaitubE9nTWNoV2VWSS9vditoUWdMRXNENkpkNm9aSFQ4UFJBSC93ZmEy?=
 =?utf-8?B?QS95U2R5WVJWNGpkWk9kTzBlZXdnemNKQlUwZFFpeUZEdFQ5Z1dMVHVtc0w1?=
 =?utf-8?B?bEJheGZGSDJCbFdWVlFwOWRaRXEyMlVxV2k4QVcvTkRIQUEwajZyelBhdnJy?=
 =?utf-8?B?YWlnU1QvMnhGczVNUDBYOE8zK0liUDc3ZmgrNnNhVHJpcmFvUWtRdVpidkUr?=
 =?utf-8?B?TXRQbU1FeStMY2QrQmpHRHlUbnVSNUk3TlRtTTRzMWFXNXU1b1JqeTFJd2tm?=
 =?utf-8?B?bXFUY0dsNjF5bFVkV2diWU5KcElpT1NDTzB0MWh0eWZsVHhHZ1ViTElVUU9h?=
 =?utf-8?B?VlhjNlFmdk03N0pPL0w5YVdnV3dERlZ4eTBhYXN2NWROUUpSLytnQ041d0tB?=
 =?utf-8?B?a1V2M01NbTFuSGZTYTRkOUVYQ1NCaXRsMHZKT2tHczZWelRuYWVQS1hmNEpa?=
 =?utf-8?B?NzU2Q1NGSHBoaUpzaDMzV3hlQ0JsWGM3eVVsTGpENUJLbXFlRTREMWtqU3Fv?=
 =?utf-8?B?b3BMNXJocWt1MVl6V1hXVUt4OFkzb3l5bExUMTFFVWVmbS9qb0JlV3JNeWZL?=
 =?utf-8?B?ZURCaEMvTVRuTkNiQUI0TVlYdXluaWVJc2tsRlhPK0Q0SndGRkhJellTdkUv?=
 =?utf-8?B?R2c0MjdUVmZINzdSOFh6MkVuVEJkbnM2RDBFZFg1Yy9uYWJaWmlhTzRsNmgy?=
 =?utf-8?B?eDZhdnRZM1hublNoOFhDd2RvaE1ndmVqOFgwNFhtUkE5TmMvcW12Y2hMK2Ns?=
 =?utf-8?B?VjVwQ2ROVFcyZ0MzaGpYQVUvTUQ2d2NpQ2l6Uk85cytKbEVUdWxSQUxRaVQw?=
 =?utf-8?B?QmtwU0FlNkR1bkViU1lZQ3RwQUsxVjJHbCtGa1BSVmxkRHpMSEFvUkNpYzk1?=
 =?utf-8?B?b05iajNXNXBPMVA0Vzl5cFpueW1YRHhXcDJRejZGZm1JQjB2TTdBeXMrZVlI?=
 =?utf-8?B?K0Zmd3REOFVwZFJrUWlSQkRyUi85eUYzTGNWZFFBUTdWQXJiTis5MUI4OGNi?=
 =?utf-8?B?SmtKdW9qRkUwMDErZHhOZU1rd2V0T2ptdGFlTlFTQVV5dHlTVWcwZ3BuYlpJ?=
 =?utf-8?B?Y3RqaHNJRHFMUTZvMWRxV3cvUXJGMjhXTzRTVjRPS0VSQkVIRDBENUVxSUhp?=
 =?utf-8?B?ekNBankwVVU4ZXhha3cwM0UzRWZYWlpJUWhVOGFxNXdkbVhhVDNXR3ZnU0g2?=
 =?utf-8?B?MEF3VHpNdkVBOXBkTHFIWXY1MXZnYWIvREd2S0RvazZUR2Z1ZHg2bW9CY0FW?=
 =?utf-8?Q?p2ILZI8fgjbkF4hP/Tz6cWhp4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f465f3b7-1643-4bf0-3f0c-08db35943e97
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 05:11:42.4213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wiOdN4MiS9ttFkyceeTChX+OpYlYt8MOc4o8ombZLMpN22GrrDtMbKVd62tff7q7oNKYWzXDA0YYMpuvxg4tRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1334
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBQZXRyIFRlc2HFmcOtayA8cGV0ckB0ZXNhcmljaS5jej4NCj4gU2VudDogVHVlc2Rh
eSwgQXByaWwgNCwgMjAyMyA5OjQwIFBNDQo+ID4gPiAuLi4NCj4gPiA+IEhpIFBldHIsIHRoaXMg
cGF0Y2ggaGFzIGdvbmUgaW50byB0aGUgbWFpbmxpbmU6DQo+ID4gPiAwZWVlNWFlMTAyNTYgKCJz
d2lvdGxiOiBmaXggc2xvdCBhbGlnbm1lbnQgY2hlY2tzIikNCj4gPiA+DQo+ID4gPiBTb21laG93
IGl0IGJyZWFrcyBMaW51eCBWTXMgb24gSHlwZXItVjogYSByZWd1bGFyIFZNIHdpdGgNCj4gPiA+
IHN3aW90bGI9Zm9yY2Ugb3IgYSBjb25maWRlbnRpYWwgVk0gKHdoaWNoIHVzZXMgc3dpb3RsYikg
ZmFpbHMgdG8gYm9vdC4NCj4gPiA+IElmIEkgcmV2ZXJ0IHRoaXMgcGF0Y2gsIGV2ZXJ5dGhpbmcg
d29ya3MgZmluZS4NCj4gPg0KPiA+IFRoZSBsb2cgaXMgcGFzdGVkIGJlbG93LiBMb29rcyBsaWtl
IHRoZSBTQ1NJIGRyaXZlciBodl9zdG9ydnNjIGZhaWxzIHRvDQo+ID4gZGV0ZWN0IHRoZSBkaXNr
IGNhcGFjaXR5Og0KPiANCj4gVGhlIGZpcnN0IHRoaW5nIEkgY2FuIGltYWdpbmUgaXMgdGhhdCB0
aGVyZSBhcmUgaW4gZmFjdCBubyAoZnJlZSkgc2xvdHMNCj4gaW4gdGhlIFNXSU9UTEIgd2hpY2gg
bWF0Y2ggdGhlIGFsaWdubWVudCBjb25zdHJhaW50cywgc28gdGhlIG1hcA0KPiBvcGVyYXRpb24g
ZmFpbHMuIEhvd2V2ZXIsIHRoaXMgd291bGQgcmVzdWx0IGluIGEgInN3aW90bGIgYnVmZmVyIGlz
DQo+IGZ1bGwiIG1lc3NhZ2UgaW4gdGhlIGxvZywgYW5kIEkgY2FuIHNlZSBubyBzdWNoIG1lc3Nh
Z2UgaW4gdGhlIGxvZw0KPiBleGNlcnB0IHlvdSBoYXZlIHBvc3RlZC4NCj4gDQo+IFBsZWFzZSwg
Y2FuIHlvdSBjaGVjayBpZiB0aGVyZSBhcmUgYW55ICJzd2lvdGxiIiBtZXNzYWdlcyBwcmVjZWRp
bmcgdGhlDQo+IGZpcnN0IGVycm9yIG1lc3NhZ2U/DQo+IA0KPiBQZXRyIFQNCg0KVGhlcmUgaXMg
bm8gInN3aW90bGIgYnVmZmVyIGlzIGZ1bGwiIGVycm9yLg0KDQpUaGUgaHZfc3RvcnZzYyBkcml2
ZXIgKGRyaXZlcnMvc2NzaS9zdG9ydnNjX2Rydi5jKSBjYWxscyBzY3NpX2RtYV9tYXAoKSwNCndo
aWNoIGRvZXNuJ3QgcmV0dXJuIC1FTk9NRU0gd2hlbiB0aGUgZmFpbHVyZSBoYXBwZW5zLg0KDQpC
VFcsIEtlbHNleSByZXBvcnRlZCB0aGUgc2FtZSBpc3N1ZSAoYWxzbyBubyAic3dpb3RsYiBidWZm
ZXIgaXMgZnVsbCIgZXJyb3IpOg0KaHR0cHM6Ly9sd24ubmV0L21sL2xpbnV4LWtlcm5lbC8yMDIz
MDQwNTAwMzU0OS5HQTIxMzI2QGxpbnV4b25oeXBlcnYzLmd1ajN5Y3R6Ym0xZXRmeHF4MnZvYjVo
c2VmLnh4LmludGVybmFsLmNsb3VkYXBwLm5ldC8NCg0KLS0gRGV4dWFuDQo=
