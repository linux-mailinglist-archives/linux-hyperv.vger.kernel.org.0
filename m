Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E463F7D1C
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Aug 2021 22:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242604AbhHYUZ5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Aug 2021 16:25:57 -0400
Received: from mail-oln040093008004.outbound.protection.outlook.com ([40.93.8.4]:34028
        "EHLO outbound.mail.eo.outlook.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242592AbhHYUZv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Aug 2021 16:25:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XU0NC0hcRjalRxt2NJ6cxXwyBqRzxIVdgCvUQboTZTPmdrbJf33Bf3MtFed/E2+kz6GTV6pFZCNOgJOwJXBxZoEIp8uqV6zeFGXwQvElEg38oEULZAIq/0L1EF5geRh5Oz8mnEqLgXPCbGYfY8OOL1f0W+oB1S6CaultTY8ZeFaTx4Hf7gPzg0jxwED+ifLYnc3sAUcxYfdsy/cfsLYldpolWlh+xd5sIGZdMpYBnEl/kKSYoiRBNKm6fyCoj5FMuvLY1pbxBt59qlcMhWaadw0F6eYSaCI09s/IX7cK8GToAsEG4c9FZFqSTVdIr+8SGYTFXsejrd+h5W8fYG8SeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=TaBeYHvY1SQj3C6GkTC5IiAr9FNJkR6QxJ1QE58DZoM=;
 b=YvA/Oai9QBHVfpcglJIZhvBxdZduRD144YdgfYdPKW8PF1ry8XXsIafcALZSnxhd4z6MtjyUxWzm6lE0tCk2mGgH43Mwog72vyOLEbFd0oNbtBd577DgZ6XX/Xg3x7htJ5UBjsHPb9ZhTZ2J3KsXmYBTCntMrlBOUFeUAZoyBUVWN3H6/rDYMaueEdjBhQuvpbJqhZCYgWvlp6JhXGSl6SsEwAwsI7XLWw/mn0BWMrzvlxeCTCBsessGtFQBzIbUPuQIZ9b9RXd5b/XDPLzfsWCfeAEgV9wt+g89Qle6+W99tAnBmXsaLLFEonodhqLwdI4g/bLT95yNgWqsAoSPqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaBeYHvY1SQj3C6GkTC5IiAr9FNJkR6QxJ1QE58DZoM=;
 b=UbA1dRW5fbu3tUGfD5FgQi1bJqDVwx5uc6yrcnLCv/l0hCxnEo2FoTj9yyJMVP8rmVVRnP3c4KMUPQMf1/oVqHWS+vFecM/SHQ7uhSwJ8jW7Bdffy2vD9nFKFVn4hmc7YjYd2erOD34MCHRKCFan4g6522BzyDgpQG2f1eH3Dpk=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1304.namprd21.prod.outlook.com (2603:10b6:a03:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.2; Wed, 25 Aug
 2021 20:25:02 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::75cf:f11d:d80d:dfd4]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::75cf:f11d:d80d:dfd4%2]) with mapi id 15.20.4436.016; Wed, 25 Aug 2021
 20:25:02 +0000
From:   Long Li <longli@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: [PATCH] PCI: hv: Fix a bug on removing child devices on the bus
Thread-Topic: [PATCH] PCI: hv: Fix a bug on removing child devices on the bus
Thread-Index: AQHXmLiDgHJZXiucJEOu37Y9ArQK+auCfYUAgABrnzCAAa9ggIAAE6eA
Date:   Wed, 25 Aug 2021 20:25:02 +0000
Message-ID: <BY5PR21MB1506B6865DA2DA9948CEA8ADCEC69@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1629789620-11049-1-git-send-email-longli@linuxonhyperv.com>
 <20210824110208.xd57oqm5rii4rr4n@liuwe-devbox-debian-v2>
 <BY5PR21MB1506270100DAE3BAFCA001E9CEC59@BY5PR21MB1506.namprd21.prod.outlook.com>
 <MWHPR21MB15935D5B518ECA1361F2EB1BD7C69@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB15935D5B518ECA1361F2EB1BD7C69@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8eb6a14f-f3c0-4df9-987b-c38e40597571;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-24T17:27:19Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37b66541-3bbb-41cc-7bad-08d968066b15
x-ms-traffictypediagnostic: BYAPR21MB1304:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR21MB1304DA6927B3E622B7D25290CEC69@BYAPR21MB1304.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qy4Ov/U15cL30GcFvvJLTfiwvyjWCGfzVzdAqVlZ/xBh3Jlz5PE5v7DrelMQz/1vBubzfV9OgTGbM7YvlV28S+zAtoM6V5P+6lPucP4Ypp5Ck3rN6oqwlPjv4nnxwfWo2e689ZTEMXEdR3qXoZpKmij/Fzpiab7wilKiElRQL8iLpIVoQwnopN0axsk3lu81+9rQIIxDS42JLINk0n4wq5vhfZDLgMUsCGYEl5eMzVhxhSeQzAEY5okrybGbu3fvGLo+Pq/n6OemDRoQbFbxQtT/NECawSQ4pXM11Sttzu99bBCYM0wx19wr7tM1h+abR4kwXcDKIRCdDcdKikXTiuF7nYL/m0RMryGhvnofsd0HJBo8w0+C2CbNYjoINZ6PUjshJUn7fW1HfHMYK8vSvHOPon3kuFLpzFzSBgRP0KYocHhX0qGIGYLbLTU2wd0Zh+HLgtqgF13PKsgE9RDBw4hR3HrBH04cL9PzmyfpzuaavlYFp4pBGwtV3lUnJt2/FbcIsKR0we5PASUBXZzDVHln4z8m/AWS4YfZo9b8NAZ9jzBD1ncirRmHFQt753Sy/z/wMRUkB70HmTe1+qiLmO/rtUsGDUPBM9XDGL23SApdYPVmkm+cZ2UgEmNRpadLZreF4QbA7XcZNndXgF8s1dZg7yLnLDS0GNqTCszPJnzHCnfkNikGcuKKfMaIQzoDYi8fDtGEEVGKrQjQpiW4jQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(9686003)(86362001)(33656002)(66476007)(5660300002)(82960400001)(10290500003)(6506007)(38100700002)(122000001)(55016002)(76116006)(66574015)(83380400001)(508600001)(2906002)(110136005)(71200400001)(66556008)(4326008)(316002)(64756008)(7696005)(186003)(8990500004)(66446008)(52536014)(66946007)(8936002)(26005)(54906003)(38070700005)(82950400001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjM3NUppUVpiNHpuTURVNVE1bTZBRHFCRTI2Yk12SEdpZVRLdjdHNmxTMDVw?=
 =?utf-8?B?Vk85UjkzOGZzczhpVSs3ZTIzVUhPVGhrRHVwR0V2L29VakpsWVk4dk9jNkJw?=
 =?utf-8?B?YU52K0tESy9MaEV3dkhqakxIN0ZhSThLa2JGRCtHZUNXd1pKbitRTXhMZ3BC?=
 =?utf-8?B?cXlWOEFmc1EyZ21NZXBNSWU4MHpZTGVvR08yK3E4bEtzbzdOWUkwQ29taTNR?=
 =?utf-8?B?MWdRa3lna3cwQzFiSEdjcDBmTkd3RXhYbDF4Uk90bUgzcFI4SkM2ZUk4M1Y0?=
 =?utf-8?B?T3hUZWFxeUtoMDIyQjM2WVB4Tkd6dzcyY05xU0JwVk1KTFpFT1ZzUFh0aEEz?=
 =?utf-8?B?ZFpyWDJzRjFjWUF4SUQyK21BRW54RkROWGEzZ3prTmllVjByT0pmU0J4b1ZV?=
 =?utf-8?B?QnEvbWRBZGFqanptZUNFYjc4b0hzV2JYQ3kxcmYyNE1XbHJGNVB3R2o4SEtJ?=
 =?utf-8?B?U0R1QnBqTUxiL0JsWkdLL3hGR240Q0hQeXJESHFGNEI4eDdpT3lkUGxQaE05?=
 =?utf-8?B?WGFPN1JkNFBHbHc5WW8xbHltcU04RXRwamh1OTR2M3JEemFjbkpaYXlCNDdp?=
 =?utf-8?B?THBBWitzbUpWUWgvOTJTSlVEeWpnWmN1dEc1ZVZsSVp2WEk2NjJWakVwQmth?=
 =?utf-8?B?dngzWjZwSFdwNDVNUjJKZGpJK21tZGFGY2RjVVpTYU1nWkRWS21pQTlxZzdD?=
 =?utf-8?B?TktEWTJ2M1AxVzNMUlJKNXpCZ1BpNFdPK3phYXMzMzh0YzJ1di9scjIwSzhM?=
 =?utf-8?B?b2paazBzaXNEOUJUYXNneTh3c2NKdUh4WEhBdU5GeEh2bVV3T2RJWVZmMU00?=
 =?utf-8?B?NCs4am5ldWpBZDd4VkRsWTRRMkU4eTdVd3RFUnlqaHQzRE5jOGsyNHZPc09L?=
 =?utf-8?B?NHRzdWRnRG16VDJ3RGNhQ2o3ZExjMlQ3dlNxdWI4RzVRTWVzWjI4NEs2a2pu?=
 =?utf-8?B?eEVaSEtkYXNsTE1GL3ZFamYwQXR1RTZXb1ZuWDdEVFU4eW9uUUErQzRSVlA2?=
 =?utf-8?B?SllvMzF5MEF6S2lTdVlSVXNOOEwvOFJHc0R4OUJSY2JGSGtDK0JRNklSelp2?=
 =?utf-8?B?MndYVUZyaVJQekZXeDFadGdSVnMydTFYTEtMU0hUNkpScVJrWEphRFFjL2kr?=
 =?utf-8?B?NmEyYmVFaXBEcGk5alVxTzRkNTEwY3JxSFhtZDNXQVdrTTNMQmFxV1FEU2lw?=
 =?utf-8?B?eFhjNWZCeGd4L3RDWm5WZjZsR2E5dEpEem5idkFBMnRKcTRsbU1SS09wSzN6?=
 =?utf-8?B?WXBRQTR2b1RzaDhuYm5Bc2JkZGlJTkRERkpoZGtzRjNkZnhORjVQMk1YQWo4?=
 =?utf-8?B?bS9xK0NJZmg4U0hzZFg3MkRpNGFvOUNpL0pIYUhHMlM5d2x1a2hOUkwvMVBC?=
 =?utf-8?B?Z3VMNFBRUmtEb0w0WGtHaWJWUEtrVjBmcmtiODVzUEdyenJhZ09nUnlONmpR?=
 =?utf-8?B?aE1HR0ppKzRVeitnRDR2SVNZb0RiMGZiYWJyZzdDaWZCSHZlZE5jb1pTMzly?=
 =?utf-8?B?RGRhNWRveDZhb0RHcS85azRYS09Qdk8xYlc1aVlZUGxlSnZ1bnFQVXAxUzIw?=
 =?utf-8?B?MytNMGZ6RFBIbUNZSG1UdnM5RXdBYmRYNGVlNVB2Kzc4YXlIeVExajA2MnBT?=
 =?utf-8?B?eEhRWFUzRDk4SUFvY0JhZWlLS2FnekEwRW5XZW5BSmhCdnpWTTBxeVZBM01t?=
 =?utf-8?B?a05EMWtaZFVUdXBmV2x2c29NRjVSRXdkUVJJZEdXZlV6UWFKV2Qzemdka28w?=
 =?utf-8?Q?WkPSOOHagfbTYhpiao=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b66541-3bbb-41cc-7bad-08d968066b15
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 20:25:02.3088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f/1tsCiLcI0zrfYYS/6LoIcW+we8FLOuz8fkaOsXcni3rgyaTkstg741fr9uFYclmEI4VUA3DfHwBgC4qVGiJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1304
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBTdWJqZWN0OiBSRTogW1BBVENIXSBQQ0k6IGh2OiBGaXggYSBidWcgb24gcmVtb3ZpbmcgY2hp
bGQgZGV2aWNlcyBvbiB0aGUgYnVzDQo+IA0KPiBGcm9tOiBMb25nIExpIDxsb25nbGlAbWljcm9z
b2Z0LmNvbT4gU2VudDogVHVlc2RheSwgQXVndXN0IDI0LCAyMDIxIDEwOjI4DQo+IEFNDQo+ID4N
Cj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIFBDSTogaHY6IEZpeCBhIGJ1ZyBvbiByZW1vdmlu
ZyBjaGlsZCBkZXZpY2VzIG9uDQo+ID4gPiB0aGUgYnVzDQo+ID4gPg0KPiA+ID4gT24gVHVlLCBB
dWcgMjQsIDIwMjEgYXQgMTI6MjA6MjBBTSAtMDcwMCwgbG9uZ2xpQGxpbnV4b25oeXBlcnYuY29t
DQo+IHdyb3RlOg0KPiA+ID4gPiBGcm9tOiBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT4N
Cj4gPiA+ID4NCj4gPiA+ID4gSW4gaHZfcGNpX2J1c19leGl0LCB0aGUgY29kZSBpcyBob2xkaW5n
IGEgc3BpbmxvY2sgd2hpbGUgY2FsbGluZw0KPiA+ID4gPiBwY2lfZGVzdHJveV9zbG90KCksIHdo
aWNoIHRha2VzIGEgbXV0ZXguDQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMgaXMgbm90IHNhZmUgZm9y
IHNwaW5sb2NrLiBGaXggdGhpcyBieSBtb3ZpbmcgdGhlIGNoaWxkcmVuIHRvDQo+ID4gPiA+IGJl
IGRlbGV0ZWQgdG8gYSBsaXN0IG9uIHRoZSBzdGFjaywgYW5kIHJlbW92aW5nIHRoZW0gYWZ0ZXIN
Cj4gPiA+ID4gc3BpbmxvY2sgaXMgcmVsZWFzZWQuDQo+ID4gPiA+DQo+ID4gPiA+IEZpeGVzOiA5
NGQyMjc2MzIwN2EgKCJQQ0k6IGh2OiBGaXggYSByYWNlIGNvbmRpdGlvbiB3aGVuIHJlbW92aW5n
DQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBkZXZpY2UiKQ0KPiA+ID4gPg0KPiA+ID4gPiBDYzogIksu
IFkuIFNyaW5pdmFzYW4iIDxreXNAbWljcm9zb2Z0LmNvbT4NCj4gPiA+ID4gQ2M6IEhhaXlhbmcg
WmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+DQo+ID4gPiA+IENjOiBTdGVwaGVuIEhlbW1p
bmdlciA8c3RoZW1taW5AbWljcm9zb2Z0LmNvbT4NCj4gPiA+ID4gQ2M6IFdlaSBMaXUgPHdlaS5s
aXVAa2VybmVsLm9yZz4NCj4gPiA+ID4gQ2M6IERleHVhbiBDdWkgPGRlY3VpQG1pY3Jvc29mdC5j
b20+DQo+ID4gPiA+IENjOiBMb3JlbnpvIFBpZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lAYXJt
LmNvbT4NCj4gPiA+ID4gQ2M6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4gPiA+
IENjOiAiS3J6eXN6dG9mIFdpbGN6ecWEc2tpIiA8a3dAbGludXguY29tPg0KPiA+ID4gPiBDYzog
Qmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4gPiA+ID4gQ2M6IE1pY2hhZWwg
S2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQuY29tPg0KPiA+ID4gPiBDYzogRGFuIENhcnBlbnRl
ciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPg0KPiA+ID4gPiBSZXBvcnRlZC1ieTogRGFuIENh
cnBlbnRlciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1oeXBlcnYuYyB8IDE1ICsrKysrKysrKysrKy0tLQ0K
PiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
DQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3Bj
aS1oeXBlcnYuYw0KPiA+ID4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVydi5j
DQo+ID4gPiA+IGluZGV4IGE1M2JkODcyOGQwZC4uZDRmM2NjZTE4OTU3IDEwMDY0NA0KPiA+ID4g
PiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1oeXBlcnYuYw0KPiA+ID4gPiArKysg
Yi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1oeXBlcnYuYw0KPiA+ID4gPiBAQCAtMzIyMCw2
ICszMjIwLDcgQEAgc3RhdGljIGludCBodl9wY2lfYnVzX2V4aXQoc3RydWN0IGh2X2RldmljZQ0K
PiA+ID4gPiAqaGRldiwNCj4gPiA+IGJvb2wga2VlcF9kZXZzKQ0KPiA+ID4gPiAgCXN0cnVjdCBo
dl9wY2lfZGV2ICpocGRldiwgKnRtcDsNCj4gPiA+ID4gIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0K
PiA+ID4gPiAgCWludCByZXQ7DQo+ID4gPiA+ICsJc3RydWN0IGxpc3RfaGVhZCByZW1vdmVkOw0K
PiA+ID4NCj4gPiA+IFRoaXMgY2FuIGJlIG1vdmVkIHRvIHdoZXJlIGl0IGlzIG5lZWRlZCAtLSB0
aGUgaWYoIWtlZXBfZGV2KSBicmFuY2gNCj4gPiA+IC0tIHRvIGxpbWl0IGl0cyBzY29wZS4NCj4g
PiA+DQo+ID4gPiA+DQo+ID4gPiA+ICAJLyoNCj4gPiA+ID4gIAkgKiBBZnRlciB0aGUgaG9zdCBz
ZW5kcyB0aGUgUkVTQ0lORF9DSEFOTkVMIG1lc3NhZ2UsIGl0IGRvZXNuJ3QNCj4gPiA+ID4gQEAN
Cj4gPiA+ID4gLTMyMjksOSArMzIzMCwxOCBAQCBzdGF0aWMgaW50IGh2X3BjaV9idXNfZXhpdChz
dHJ1Y3QgaHZfZGV2aWNlDQo+ID4gPiA+ICpoZGV2LCBib29sDQo+ID4gPiBrZWVwX2RldnMpDQo+
ID4gPiA+ICAJCXJldHVybiAwOw0KPiA+ID4gPg0KPiA+ID4gPiAgCWlmICgha2VlcF9kZXZzKSB7
DQo+ID4gPiA+IC0JCS8qIERlbGV0ZSBhbnkgY2hpbGRyZW4gd2hpY2ggbWlnaHQgc3RpbGwgZXhp
c3QuICovDQo+ID4gPiA+ICsJCUlOSVRfTElTVF9IRUFEKCZyZW1vdmVkKTsNCj4gPiA+ID4gKw0K
PiA+ID4gPiArCQkvKiBNb3ZlIGFsbCBwcmVzZW50IGNoaWxkcmVuIHRvIHRoZSBsaXN0IG9uIHN0
YWNrICovDQo+ID4gPiA+ICAJCXNwaW5fbG9ja19pcnFzYXZlKCZoYnVzLT5kZXZpY2VfbGlzdF9s
b2NrLCBmbGFncyk7DQo+ID4gPiA+IC0JCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShocGRldiwg
dG1wLCAmaGJ1cy0+Y2hpbGRyZW4sDQo+ID4gPiBsaXN0X2VudHJ5KSB7DQo+ID4gPiA+ICsJCWxp
c3RfZm9yX2VhY2hfZW50cnlfc2FmZShocGRldiwgdG1wLCAmaGJ1cy0+Y2hpbGRyZW4sDQo+ID4g
PiBsaXN0X2VudHJ5KQ0KPiA+ID4gPiArCQkJbGlzdF9tb3ZlX3RhaWwoJmhwZGV2LT5saXN0X2Vu
dHJ5LCAmcmVtb3ZlZCk7DQo+ID4gPiA+ICsJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmhidXMt
PmRldmljZV9saXN0X2xvY2ssIGZsYWdzKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCQkvKiBSZW1v
dmUgYWxsIGNoaWxkcmVuIGluIHRoZSBsaXN0ICovDQo+ID4gPiA+ICsJCXdoaWxlICghbGlzdF9l
bXB0eSgmcmVtb3ZlZCkpIHsNCj4gPiA+ID4gKwkJCWhwZGV2ID0gbGlzdF9maXJzdF9lbnRyeSgm
cmVtb3ZlZCwgc3RydWN0IGh2X3BjaV9kZXYsDQo+ID4gPiA+ICsJCQkJCQkgbGlzdF9lbnRyeSk7
DQo+ID4gPg0KPiA+ID4gbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlIGNhbiBhbHNvIGJlIHVzZWQg
aGVyZSwgcmlnaHQ/DQo+ID4gPg0KPiA+ID4gV2VpLg0KPiA+DQo+ID4gSSB3aWxsIGFkZHJlc3Mg
eW91ciBjb21tZW50cy4NCj4gPg0KPiA+IExvbmcNCj4gDQo+IEkgdGhvdWdodCBsaXN0X2Zvcl9l
YWNoX2VudHJ5X3NhZmUoKSBpcyBmb3IgdXNlIHdoZW4gbGlzdCBtYW5pcHVsYXRpb24gaXMgKm5v
dCoNCj4gcHJvdGVjdGVkIGJ5IGEgbG9jayBhbmQgeW91IHdhbnQgdG8gc2FmZWx5IHdhbGsgdGhl
IGxpc3QgZXZlbiBpZiBhbiBlbnRyeSBnZXRzDQo+IHJlbW92ZWQuICBJZiB0aGUgbGlzdCBpcyBw
cm90ZWN0ZWQgYnkgYSBsb2NrIG9yIG5vdCBzdWJqZWN0IHRvIGNvbnRlbnRpb24gKGFzIGlzIHRo
ZQ0KPiBjYXNlIGhlcmUpLCB0aGVuDQo+IGxpc3RfZm9yX2VhY2hfZW50cnkoKSBpcyB0aGUgc2lt
cGxlciBpbXBsZW1lbnRhdGlvbi4gIFRoZSBvcmlnaW5hbA0KPiBpbXBsZW1lbnRhdGlvbiBkaWRu
J3QgbmVlZCB0byB1c2UgdGhlIF9zYWZlIHZlcnNpb24gYmVjYXVzZSBvZiB0aGUgc3BpbiBsb2Nr
Lg0KPiANCj4gT3IgZG8gSSBoYXZlIGl0IGJhY2t3YXJkcz8NCj4gDQo+IE1pY2hhZWwNCg0KSSB0
aGluayB3ZSBuZWVkIGxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZSgpIGJlY2F1c2Ugd2UgZGVsZXRl
IHRoZSBsaXN0IGVsZW1lbnRzIHdoaWxlIGdvaW5nIHRocm91Z2ggdGhlbToNCg0KSGVyZSBpcyB0
aGUgY29tbWVudCBvbiBsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoKToNCi8qKg0KICogTG9vcCB0
aHJvdWdoIHRoZSBsaXN0LCBrZWVwaW5nIGEgYmFja3VwIHBvaW50ZXIgdG8gdGhlIGVsZW1lbnQu
IFRoaXMNCiAqIG1hY3JvIGFsbG93cyBmb3IgdGhlIGRlbGV0aW9uIG9mIGEgbGlzdCBlbGVtZW50
IHdoaWxlIGxvb3BpbmcgdGhyb3VnaCB0aGUNCiAqIGxpc3QuDQogKg0KICogU2VlIGxpc3RfZm9y
X2VhY2hfZW50cnkgZm9yIG1vcmUgZGV0YWlscy4NCiAqLw0KDQo+IA0KPiA+DQo+ID4gPg0KPiA+
ID4gPiAgCQkJbGlzdF9kZWwoJmhwZGV2LT5saXN0X2VudHJ5KTsNCj4gPiA+ID4gIAkJCWlmICho
cGRldi0+cGNpX3Nsb3QpDQo+ID4gPiA+ICAJCQkJcGNpX2Rlc3Ryb3lfc2xvdChocGRldi0+cGNp
X3Nsb3QpOw0KPiA+ID4gPiBAQCAtMzIzOSw3ICszMjQ5LDYgQEAgc3RhdGljIGludCBodl9wY2lf
YnVzX2V4aXQoc3RydWN0IGh2X2RldmljZQ0KPiA+ID4gPiAqaGRldiwNCj4gPiA+IGJvb2wga2Vl
cF9kZXZzKQ0KPiA+ID4gPiAgCQkJcHV0X3BjaWNoaWxkKGhwZGV2KTsNCj4gPiA+ID4gIAkJCXB1
dF9wY2ljaGlsZChocGRldik7DQo+ID4gPiA+ICAJCX0NCj4gPiA+ID4gLQkJc3Bpbl91bmxvY2tf
aXJxcmVzdG9yZSgmaGJ1cy0+ZGV2aWNlX2xpc3RfbG9jaywgZmxhZ3MpOw0KPiA+ID4gPiAgCX0N
Cj4gPiA+ID4NCj4gPiA+ID4gIAlyZXQgPSBodl9zZW5kX3Jlc291cmNlc19yZWxlYXNlZChoZGV2
KTsNCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi4yNS4xDQo+ID4gPiA+DQo=
