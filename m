Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F65C279D21
	for <lists+linux-hyperv@lfdr.de>; Sun, 27 Sep 2020 02:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgI0ARA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 26 Sep 2020 20:17:00 -0400
Received: from mail-eopbgr750117.outbound.protection.outlook.com ([40.107.75.117]:32736
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726840AbgI0ARA (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 26 Sep 2020 20:17:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ih/pzMy62gRnpJo7EUBsojeL01U4sGSpYvYars61KRAXXFkzIjIFaB6aOmLMNRIWy0nMjkaOj58lo/Cb8caJ2x4/B2qDaQB27ur8o1v+WlfHa9OyQUpHeZrqlv+2pkFoRX5cMHVUl1n19rsMhVqp/rOG5uLAOZABlyMnw7ITIe8zjyVeWJvY16RVT0ON/N1WNqad5x6bvXHO/hp6k8QJWwUwiXt6pmesdMQlh9aPOiqqqipEXEyZnyWtM/Chp9M5srRX+y8W3Bkz830hkx9hd+18qtX4BWXC7dyYPyB8T46rZRQqfZsXq+mPx3ghw4WuQ2BVsLguxlisOGADKEMnxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+n17WvREN0wOs9mLeYjQTH7xRpm04TV4/BDd/I/1t0=;
 b=LCCOkFTHF7/IRYhJyqWhX0jmuDIylzQBVwRa+UA027jqBj3zPIlJwLwAKAVingra8WkDroVygHWWEVbqjz7rjUZNg+JM3ugfFepSbscirYBNQJLqLILT/402+wvXX6Com9LORbmjKGDIfWO4uK8IWSgfboLpkkii96CA+nr6lFyyGTltsv1HIHO0YxryN194sSvDQXIkOS114VBs/oilBnRWKcyPryvtdz9toLFi9M98mMxz6xDpjshLnvVuTBcSGRDLbWZo/0V6yq5Bumsic4l+0BsJsPzHNxSwZ+5AixUbCZxUlVS5zFbnnuziMEKjDcgQqj1cg8hW16VX5jS26A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+n17WvREN0wOs9mLeYjQTH7xRpm04TV4/BDd/I/1t0=;
 b=PeArmjJaFiOsPtaaoJwcyZO+Me5Py37H5OaoGTY5XmbPMM7kOuNxkkyzuvSILnx6pnF3CfHtXsHHFQEd/PJnkGQOEBuqRaSi9yOSZfxNXdBb4fms66wo8Ov6I7An1DjV6qBUg5tefrHFqV+x7B886VfEBcxNVE7ro3tLjAridwk=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MWHPR2101MB0731.namprd21.prod.outlook.com (2603:10b6:301:81::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.18; Sun, 27 Sep
 2020 00:16:57 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d00b:3909:23b:83f1]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d00b:3909:23b:83f1%4]) with mapi id 15.20.3412.028; Sun, 27 Sep 2020
 00:16:57 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        KY Srinivasan <kys@microsoft.com>
CC:     Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Document missing hv_pci_protocol_negotiation()
 parameter
Thread-Topic: [PATCH] PCI: hv: Document missing hv_pci_protocol_negotiation()
 parameter
Thread-Index: AQHWk5ZXeAPUQFnW5EqRVDrKDYzLkql7nz2Q
Date:   Sun, 27 Sep 2020 00:16:57 +0000
Message-ID: <MW2PR2101MB1052F5A4F74B560D8B6911F2D7340@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200925234753.1767227-1-kw@linux.com>
In-Reply-To: <20200925234753.1767227-1-kw@linux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-09-27T00:16:55Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cbbb124e-ee06-4f99-9572-8e70a4aebcff;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 931a588f-545c-4d07-520d-08d8627aa56b
x-ms-traffictypediagnostic: MWHPR2101MB0731:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR2101MB0731640DC9AA8E3E5600EEF4D7340@MWHPR2101MB0731.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: acBqmK/VZnjKrxeAzOy9NwcIZe2/Boej3cSwqcmVv1nA4MzrJIT6heTWz+Qt2H2HHsfDPjRkh05SMD5FUERT5sdyvpjMg6t8obPrF2MM4RT2QM5Xk77UEqWDDl5SEkelC2BGAlAnBr2iVUvkCpy8QdeTBLm0czBnX+ivmkaUkP1xrGKQiVVOC58HIErp2z+rdatdoc6+e/WYGpNNVxhJYP9t0HJy7HO+mCmwjjbb/bjZ6rJ1OBdQ+T+z6VudjkuP+MicPHcd4oKir6ctF9B1LllhQrfHsAbCSnfG6U3/jojxb//4wwTRkM+SfmuNwJhl0E2AHYtKM09gfQfkzcujtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(316002)(186003)(8990500004)(33656002)(66946007)(76116006)(110136005)(6506007)(54906003)(7696005)(71200400001)(66574015)(53546011)(82960400001)(82950400001)(83380400001)(8936002)(66446008)(2906002)(9686003)(478600001)(10290500003)(86362001)(6636002)(55016002)(5660300002)(26005)(52536014)(64756008)(66556008)(66476007)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 3SNunysRn4Vwf1LeChvhhng7guYbOKByNtr+6mBMDA/KSr1uzRozdY+Bo2UYj0jsjA20Iu/WH+XuE3gBcwhJqVr1RpfHJTQSB8FXSxkXeZoTKtUTBWxc1GNcXgPrAYhINozzsAi2lxFrMWgxxg6HFKmfWBSSQ1YgUl+Nz/J5Tu8CO/ZYQxrc7a+G3oFSyCqkPQ64HcGtYgpY/HNyf2NvpOJdN7ahKdgJBeWpWMn8I0VzaxzsbYLOx+nER7P4osJfCXxQJd+iN5dZsqmHfEHP1t6YMUGla7D/5Ply/Hq4lgXYsqCWz+/CMUfhPTpIerDe3XzI63Zb0oPyfD3VwMKN720HtGIbyTw0oiVPEVOkH3uxB0++BqllCUPxqmU0uOWFGJRPwDYZZoiLca67Cv8HkP88sjmzNyxkTj5eJMeRdIW3s5SRIhZCCyUQG7UEmS2HqhG5Dv4IedZOTxp5D5+XziAbqOniW8BRX5tcwy7mtl7AMx4OM36xO0rAyR3Jmj7dI727LaFm4h4hcFMuK93B/POo+qhFopOvtu1EHmizDYLD1iMbYwgaXj55ZXKQj+9iUv/4nugERnRIVy7h1bYWd3ywgdqKEgi0LCGClWZKRCwDYTO8Cx79g3swlPdHVvQkdfwNULmY+3IwbsCyWRm3hQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931a588f-545c-4d07-520d-08d8627aa56b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2020 00:16:57.2582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zBZikdSME9gtgs6/Y6RZ68EG4QLMfFkAoK2qNwUM+7eq6HCOtdoFKD5PMsSTFkO1Dus16QByhGhwCXnxi605KBJSx4deCcu04I2SsBAxDHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0731
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogS3J6eXN6dG9mIFdpbGN6ecWEc2tpIDxrd0BsaW51eC5jb20+IFNlbnQ6IEZyaWRheSwg
U2VwdGVtYmVyIDI1LCAyMDIwIDQ6NDggUE0NCj4gVG86IEtZIFNyaW5pdmFzYW4gPGt5c0BtaWNy
b3NvZnQuY29tPg0KPiBDYzogSGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT47
IFN0ZXBoZW4gSGVtbWluZ2VyDQo+IDxzdGhlbW1pbkBtaWNyb3NvZnQuY29tPjsgV2VpIExpdSA8
d2VpLmxpdUBrZXJuZWwub3JnPjsgQmpvcm4gSGVsZ2Fhcw0KPiA8YmhlbGdhYXNAZ29vZ2xlLmNv
bT47IGxpbnV4LWh5cGVydkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogW1BBVENIXSBQQ0k6IGh2OiBEb2N1bWVudCBtaXNzaW5nIGh2X3BjaV9w
cm90b2NvbF9uZWdvdGlhdGlvbigpIHBhcmFtZXRlcg0KPiANCj4gQWRkIG1pc3NpbmcgZG9jdW1l
bnRhdGlvbiBmb3IgdGhlIHBhcmFtZXRlciAidmVyc2lvbiIgYW5kICJudW1fdmVyc2lvbiINCj4g
b2YgdGhlIGh2X3BjaV9wcm90b2NvbF9uZWdvdGlhdGlvbigpIGZ1bmN0aW9uIGFuZCByZXNvbHZl
IGJ1aWxkIHRpbWUNCj4ga2VybmVsLWRvYyB3YXJuaW5nczoNCj4gDQo+ICAgZHJpdmVycy9wY2kv
Y29udHJvbGxlci9wY2ktaHlwZXJ2LmM6MjUzNTogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVy
DQo+ICAgb3IgbWVtYmVyICd2ZXJzaW9uJyBub3QgZGVzY3JpYmVkIGluICdodl9wY2lfcHJvdG9j
b2xfbmVnb3RpYXRpb24nDQo+IA0KPiAgIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVy
di5jOjI1MzU6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlcg0KPiAgIG9yIG1lbWJlciAnbnVt
X3ZlcnNpb24nIG5vdCBkZXNjcmliZWQgaW4gJ2h2X3BjaV9wcm90b2NvbF9uZWdvdGlhdGlvbicN
Cj4gDQo+IE5vIGNoYW5nZSB0byBmdW5jdGlvbmFsaXR5IGludGVuZGVkLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogS3J6eXN6dG9mIFdpbGN6ecWEc2tpIDxrd0BsaW51eC5jb20+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMgfCA1ICsrKystDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMgYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL3BjaS1oeXBlcnYuYw0KPiBpbmRleCBmYzRjM2ExNWU1NzAuLjYxMDIzMzBlMjdlMSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMNCj4gKysr
IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMNCj4gQEAgLTI1MTUsNyArMjUx
NSwxMCBAQCBzdGF0aWMgdm9pZCBodl9wY2lfb25jaGFubmVsY2FsbGJhY2sodm9pZCAqY29udGV4
dCkNCj4gDQo+ICAvKioNCj4gICAqIGh2X3BjaV9wcm90b2NvbF9uZWdvdGlhdGlvbigpIC0gU2V0
IHVwIHByb3RvY29sDQo+IC0gKiBAaGRldjoJVk1CdXMncyB0cmFja2luZyBzdHJ1Y3QgZm9yIHRo
aXMgcm9vdCBQQ0kgYnVzDQo+ICsgKiBAaGRldjoJCVZNQnVzJ3MgdHJhY2tpbmcgc3RydWN0IGZv
ciB0aGlzIHJvb3QgUENJIGJ1cy4NCj4gKyAqIEB2ZXJzaW9uOgkJQXJyYXkgb2Ygc3VwcG9ydGVk
IGNoYW5uZWwgcHJvdG9jb2wgdmVyc2lvbnMgaW4NCj4gKyAqCQkJdGhlIG9yZGVyIG9mIHByb2Jp
bmcgLSBoaWdoZXN0IGdvIGZpcnN0Lg0KPiArICogQG51bV92ZXJzaW9uOglOdW1iZXIgb2YgZWxl
bWVudHMgaW4gdGhlIHZlcnNpb24gYXJyYXkuDQo+ICAgKg0KPiAgICogVGhpcyBkcml2ZXIgaXMg
aW50ZW5kZWQgdG8gc3VwcG9ydCBydW5uaW5nIG9uIFdpbmRvd3MgMTANCj4gICAqIChzZXJ2ZXIp
IGFuZCBsYXRlciB2ZXJzaW9ucy4gSXQgd2lsbCBub3QgcnVuIG9uIGVhcmxpZXINCj4gLS0NCj4g
Mi4yOC4wDQoNClJldmlld2VkLWJ5OiAgTWljaGFlbCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29m
dC5jb20+DQo=
