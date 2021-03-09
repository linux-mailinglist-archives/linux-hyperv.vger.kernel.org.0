Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DDC332B49
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Mar 2021 16:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhCIP55 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 9 Mar 2021 10:57:57 -0500
Received: from mail-dm6nam11on2098.outbound.protection.outlook.com ([40.107.223.98]:41953
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232112AbhCIP5p (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 9 Mar 2021 10:57:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bq6D//bpULn3F9rt7KkumplX6Ql0X05nb02kji3PbB0lL1Qh5uug5fcBYQdhinzlM+sO36T//dUvuPXzlRc14K4L95AH72WzfeydfQfMGot5fJ7L3gRZEDPrAIwfBIQIkvYv1yqCHMhlYlCJZd2kIKpc0Ur3u/+R6LgGsD0cpfgGFH15GjinjdO1zOJ+n5kHOIxz2TzjXhdA1bjOpSRrAG5kWqV7k1spL8WHSbWx0yT1oWBtpNhUD5cMjWK/s4FVx+LDMwCEcm6ky89g+Y4lRWs29VSfvSNzj346U7yje7H3dn+/563KUJZ7+rB+A5qetDKo2yG8a+QGJwpJQ2uMSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1c6dJzExGJ70MvGM6fLAkSI7YtTQPMYXnHB6Zs9rUXw=;
 b=HVmXHyqlTXADrmroJZjKNI9cKAs8111I+X8nbfKCGeUeGDSBYOVdY0c2Grn1M3oBCRLlo75ADSQcVZigoJUsFCs29lquBBd5hRY74KTLVTl+gW1QIgomZiTi19Dn/TRa936l5ePnPB7Bdi9e5xOyRU3vNRqm3N5PszOFnlc2IwRT0IeWn3qCqU1dt3VWUsE3FJ3X+vFX7GdQvIc2U2QmdbDd6JETVyp5I3qCoidFUlp5FdXL5RZpOvEg2Nt+/wJtoh0EPIzwcmcyjjEWmJVxmm0Ub2848MiupdYhWifN4MKaYwncnKsZCRCpAOtd2kdLhQPTvtXe1WHNAEC7TvXdxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1c6dJzExGJ70MvGM6fLAkSI7YtTQPMYXnHB6Zs9rUXw=;
 b=jDHeKvUyohe15ndYwOPsLgwM0YnSX0AMU0mnVyHf79gCHjtOiZYcqfbAFjONpc28u0yxorBLE4gepBxTKEPfgxL9O3ADNPMuW761xWi41FFLJbU3+cIa/hyeufXCZ08oFnmPP7SjGdp3aq6LZYqUhHbODnjkZ1oSRHTFAcXen+U=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1955.namprd21.prod.outlook.com (2603:10b6:303:71::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.16; Tue, 9 Mar
 2021 15:57:30 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3955.008; Tue, 9 Mar 2021
 15:57:30 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     John Garry <john.garry@huawei.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "andres@anarazel.de" <andres@anarazel.de>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: RE: [PATCH v1] scsi: storvsc: Cap cmd_per_lun at can_queue
Thread-Topic: [PATCH v1] scsi: storvsc: Cap cmd_per_lun at can_queue
Thread-Index: AQHXEhZt+ZHc82CPuUC0eGRm1QUsMap6KhHQgAA6cACAAQ/+AIAAXcEg
Date:   Tue, 9 Mar 2021 15:57:30 +0000
Message-ID: <MWHPR21MB1593A9670EFF745B2FB96C1BD7929@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210305232151.1531-1-melanieplageman@gmail.com>
 <MWHPR21MB1593078007256C5155ED5A86D7939@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210308175618.GA2376@goldwasser>
 <01aa44d0-f0a5-6de6-6778-a1658a3d8a8f@huawei.com>
In-Reply-To: <01aa44d0-f0a5-6de6-6778-a1658a3d8a8f@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-09T15:57:29Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ed468167-85b6-4126-8682-a9f18d5ede71;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cb8294bd-fc1e-441d-fc2b-08d8e3140bcb
x-ms-traffictypediagnostic: MW4PR21MB1955:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB19551E52A0DEA257BD555AE9D7929@MW4PR21MB1955.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ysqA2/Rlv498U9PL2hTMRzUf2GF6IH0LOFTubN54D97KRGUmiVAwLF06QwwYl8tx1eTnQCmODK2bZF3ZBPMtZh29zM9lJFIPDYbU2z5jVXA/xTSVpynwyo+OUTAvod1pojVvLffauLcxu0Gnhgbntvt1GnAAOeglTeOQnIUdno/pIk5OfWBFzeDYJKV8y+XnyC2Zv9mxkPPR440PleA222+GB/P+xd0cAJ1FWwhoM0aZHaWUfxd5eG5zR6NLH4QJQLf7YUIzQOa0Z9yh9N+HjJqeq99C8xDrqCo1+FtQoZzPXL7rHOMVM4Dlx7GXpenPTRLErVLql9ESTuN3LbJMxTcBvFszey723VsUjVKsxn4LfWjVAIinoWGdi5Cb5UCCeuG2C7WimlmSqQ3bplIQU2zdpV2aKdIfnV2c4bsKaHHLfxUgUzc75oi1E91s5+1Ql2XeBok0Ac6+DCpZhij2Y6n9qeO/m1Z4qy5Y1bR5GlAO7NI8nGu+D9nJ/J+E7W34fpLcOZq/TPPGLLBFIyFYQ/cJLRWGqhZtw9aZYFNP+p0B5zVy2AUsDnn0At98kWS21sFwTDhmaBYijs4z/pcgty9PEY3atIuV8imwqN5APqg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(86362001)(5660300002)(76116006)(53546011)(33656002)(82960400001)(10290500003)(316002)(921005)(186003)(83380400001)(2906002)(82950400001)(8990500004)(8936002)(6506007)(9686003)(71200400001)(55016002)(7696005)(52536014)(66946007)(8676002)(66556008)(478600001)(110136005)(66476007)(64756008)(26005)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SnZ5TjBNTlBhZitZUmNsSys1ZTFGalJWWXdvTElRTXhISVczVFFna0FiM0xV?=
 =?utf-8?B?blIzQnlPb1ozTVFiajNVQ1JDTExFZXhxaUY3WXlqREZhMitOWWtQVHNIWGxp?=
 =?utf-8?B?YmVTaXgzU0NBeHNOa0dvWDBmeCtuVU45M1dJc0NJZmZYZjFCZis4UTdBbVk5?=
 =?utf-8?B?dUQ5dHl6dUhYYXIwbzREUHc0V1JqbHR4NEVFM1hUWVRERXFpSkxmTDNFT2VW?=
 =?utf-8?B?eEVrVUVhT0MvSEFBbHFBQUFWZ2hYcjNzY0Q4VkxKeGhTS0luSnlmZ1VyRjFH?=
 =?utf-8?B?NnFwRlk3YjExRUkyWWliT203SFlxV1RVeUtDbG5TRzVrSXlnY3hiN2RkMHBH?=
 =?utf-8?B?NG8rWHhMYkYxN2p0OVdJaERTYUF2M3RUUit6NmlaRU1XWExVejlJYUYyZjNv?=
 =?utf-8?B?a3JIL24vcitCaVUwL1ZldFhhN3o3YXpxVG9RYXBIcWpzdzhhTUNUUmg5TjU4?=
 =?utf-8?B?RytVRkxXbTFWL3dsVGUvb2RJa3lMYUx2OTFtaEJDNmZTRnN0b1V4WnZRa3Bm?=
 =?utf-8?B?UHVqc3QwMzE5TkRzajVsQjlOVFZZVU4zbUhJbUJUb3dsMVhCN3oyNlQ3L3Av?=
 =?utf-8?B?SkxzNWtDelNJYVptekd6bmQ3djFCNFJRMmoyc2pkS3l4V1EySE5uVjhCbC8r?=
 =?utf-8?B?QXNMRllhVE0xdWxFU0Z2REw3WWQ1aG5NMEo2MzJVR3RvY3QweEgxdmMrdVgw?=
 =?utf-8?B?Yzl0RnNCUmdVT1FYUlZZRnNzazF3MmJielhIOEFIci9RbGxYVTd4MjR4MUhq?=
 =?utf-8?B?Q3hxSXN3NUlWQy9pNTNMZk45TVdNY1VPZGtlbkd5M0dUc3dYem5xUXVOd2JF?=
 =?utf-8?B?QW5QU1VnQk44R0xxZkZwVnY1SWV5aE84Y2ovWjFJVm1MZkpEa1piaDVzZkRq?=
 =?utf-8?B?THA2ME9uMWZQZjhTcWptU2FRVm9pRkdGTHdzV3pDYVBUa1ZKL1BoVXE4QUx1?=
 =?utf-8?B?UDZKMWUyRnVteEpVZmxmTUtVemJQRCs4NmxZOVVUTXBHaDBTTHA4SUZOMXE2?=
 =?utf-8?B?M29GMDAwdW5wT2tjRDd5MG1nMkJ2N09GTG5UaWx4eFM2NmtlVG1SSHlYQWFo?=
 =?utf-8?B?U21oc2VQdDd6ZUVHdEg0LyszVS83ME8zZ3ZSb1ZOUjZONWJzVFpHdVRSSThZ?=
 =?utf-8?B?dnMzcFVHL2pSZXZEVm9qTHJiUnByRGcySnU4dWd1Y3Y3a3lNMWJ1TnJsY202?=
 =?utf-8?B?NFZweWhSQ3Zxc09IenFnaDNNUk1wcVVtRGFMRlNoNGZxS1k2RGplNUozcDVv?=
 =?utf-8?B?eFJXbC9nM0FtTmkvWmZOYk1VNDA3MklMeG1oa2RYTnpQR0xMdVFMdzJ2REQ5?=
 =?utf-8?B?ckZXcHh0b2VLN2dGeXU2WHlHd2hzSVllUklQSmNQNkFNZTNpa3NrcEZlemYx?=
 =?utf-8?B?ZERpWWNKUEdYRGlKd3ZRdUtaL0pENjUzeVZCa3N5RWdFa3VJVy90bUJEUnNV?=
 =?utf-8?B?ai9EMEw0VGR0NENYR2tQQmNVWHZ1QUkya24rb3ZibkI5QXVhMFNXdDJFTFBw?=
 =?utf-8?B?ZUxuVWNtVlpjcnREVitnUVd6SGxJazVybW8vNll6TDI4dnZWNWx1QktxcUFW?=
 =?utf-8?B?WkZvT3hEMFpxNU96UkFXbFZ1c2o5bDIwcGk4bEhaUDZ6Yi9iYjFNKzAzaEpJ?=
 =?utf-8?B?ZUVpbUc2MHp5SFc2TDdSdjJRNGRRcitLMS9LUkU3ekNVWGdUdDR0R2tzMUJl?=
 =?utf-8?B?YlF2WjA0Vm5oem5qTy9zN3A5OU9OSDRpdlk2allFVng1OHBnMi9SNVh6MTBq?=
 =?utf-8?Q?6C9KbpJdCn7Mo7ZReTTGszttsz3IWRFyL9fkMMr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8294bd-fc1e-441d-fc2b-08d8e3140bcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 15:57:30.8724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KrrRybxSrQB3OD3YBucehnJ+uEC9L/DXkEV435ZZBkXG3o1DxZAPFhX/UpLmtBE0qCwbcmgzv1xZNdbbMO1Ib+204nJzwtq93OkPxTBaokE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1955
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogSm9obiBHYXJyeSA8am9obi5nYXJyeUBodWF3ZWkuY29tPiBTZW50OiBUdWVzZGF5LCBN
YXJjaCA5LCAyMDIxIDI6MTAgQU0NCj4gDQo+IE9uIDA4LzAzLzIwMjEgMTc6NTYsIE1lbGFuaWUg
UGxhZ2VtYW4gd3JvdGU6DQo+ID4gT24gTW9uLCBNYXIgMDgsIDIwMjEgYXQgMDI6Mzc6NDBQTSAr
MDAwMCwgTWljaGFlbCBLZWxsZXkgd3JvdGU6DQo+ID4+IEZyb206IE1lbGFuaWUgUGxhZ2VtYW4g
KE1pY3Jvc29mdCkgPG1lbGFuaWVwbGFnZW1hbkBnbWFpbC5jb20+IFNlbnQ6IEZyaWRheSwNCj4g
TWFyY2ggNSwgMjAyMSAzOjIyIFBNDQo+ID4+Pg0KPiA+Pj4gVGhlIHNjc2lfZGV2aWNlLT5xdWV1
ZV9kZXB0aCBpcyBzZXQgdG8gU2NzaV9Ib3N0LT5jbWRfcGVyX2x1biBkdXJpbmcNCj4gPj4+IGFs
bG9jYXRpb24uDQo+ID4+Pg0KPiA+Pj4gQ2FwIGNtZF9wZXJfbHVuIGF0IGNhbl9xdWV1ZSB0byBh
dm9pZCBkaXNwYXRjaCBlcnJvcnMuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogTWVsYW5p
ZSBQbGFnZW1hbiAoTWljcm9zb2Z0KSA8bWVsYW5pZXBsYWdlbWFuQGdtYWlsLmNvbT4NCj4gPj4+
IC0tLQ0KPiA+Pj4gICBkcml2ZXJzL3Njc2kvc3RvcnZzY19kcnYuYyB8IDIgKysNCj4gPj4+ICAg
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3Njc2kvc3RvcnZzY19kcnYuYyBiL2RyaXZlcnMvc2NzaS9zdG9ydnNjX2Rydi5j
DQo+ID4+PiBpbmRleCA2YmM1NDUzY2VhOGEuLmQ3OTUzYTZlMDBlNiAxMDA2NDQNCj4gPj4+IC0t
LSBhL2RyaXZlcnMvc2NzaS9zdG9ydnNjX2Rydi5jDQo+ID4+PiArKysgYi9kcml2ZXJzL3Njc2kv
c3RvcnZzY19kcnYuYw0KPiA+Pj4gQEAgLTE5NDYsNiArMTk0Niw4IEBAIHN0YXRpYyBpbnQgc3Rv
cnZzY19wcm9iZShzdHJ1Y3QgaHZfZGV2aWNlICpkZXZpY2UsDQo+ID4+PiAgIAkJCQkobWF4X3N1
Yl9jaGFubmVscyArIDEpICoNCj4gPj4+ICAgCQkJCSgxMDAgLSByaW5nX2F2YWlsX3BlcmNlbnRf
bG93YXRlcikgLyAxMDA7DQo+ID4+Pg0KPiA+Pj4gKwlzY3NpX2RyaXZlci5jbWRfcGVyX2x1biA9
IG1pbl90KHUzMiwgc2NzaV9kcml2ZXIuY21kX3Blcl9sdW4sDQo+IHNjc2lfZHJpdmVyLmNhbl9x
dWV1ZSk7DQo+ID4+PiArDQo+ID4+DQo+ID4+IEknbSBub3Qgc3VyZSB3aGF0IHlvdSBtZWFuIGJ5
ICJhdm9pZCBkaXNwYXRjaCBlcnJvcnMiLiAgQ2FuIHlvdSBlbGFib3JhdGU/DQo+ID4NCj4gPiBU
aGUgc2NzaV9kcml2ZXIuY21kX3Blcl9sdW4gaXMgc2V0IHRvIDIwNDguIFdoaWNoIGlzIHRoZW4g
dXNlZCB0byBzZXQNCj4gPiBTY3NpX0hvc3QtPmNtZF9wZXJfbHVuIGluIHN0b3J2c2NfcHJvYmUo
KS4NCj4gPg0KPiA+IEluIHN0b3J2c2NfcHJvYmUoKSwgd2hlbiBkb2luZyBzY3NpX3NjYW5faG9z
dCgpLCBzY3NpX2FsbG9jX3NkZXYoKSBpcw0KPiA+IGNhbGxlZCBhbmQgc2V0cyB0aGUgc2NzaV9k
ZXZpY2UtPnF1ZXVlX2RlcHRoIHRvIHRoZSBTY3NpX0hvc3Qncw0KPiA+IGNtZF9wZXJfbHVuIHdp
dGggdGhpcyBjb2RlOg0KPiA+DQo+ID4gc2NzaV9jaGFuZ2VfcXVldWVfZGVwdGgoc2Rldiwgc2Rl
di0+aG9zdC0+Y21kX3Blcl9sdW4gPw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc2Rldi0+aG9zdC0+Y21kX3Blcl9sdW4gOiAxKTsNCj4gPg0KPiA+IER1cmlu
ZyBkaXNwYXRjaCwgdGhlIHNjc2lfZGV2aWNlLT5xdWV1ZV9kZXB0aCBpcyB1c2VkIGluDQo+ID4g
c2NzaV9kZXZfcXVldWVfcmVhZHkoKSwgY2FsbGVkIGJ5IHNjc2lfbXFfZ2V0X2J1ZGdldCgpIHRv
IGRldGVybWluZQ0KPiA+IHdoZXRoZXIgb3Igbm90IHRoZSBkZXZpY2UgY2FuIHF1ZXVlIGFub3Ro
ZXIgY29tbWFuZC4NCj4gPg0KPiA+IE9uIHNvbWUgbWFjaGluZXMsIHdpdGggdGhlIDIwNDggdmFs
dWUgb2YgY21kX3Blcl9sdW4gdGhhdCB3YXMgdXNlZCB0bw0KPiA+IHNldCB0aGUgaW5pdGlhbCBz
Y3NpX2RldmljZS0+cXVldWVfZGVwdGgsIGNvbW1hbmRzIGNhbiBiZSBxdWV1ZWQgdGhhdA0KPiA+
IGFyZSBsYXRlciBub3QgYWJsZSB0byBiZSBkaXNwYXRjaGVkIGFmdGVyIHJ1bm5pbmcgb3V0IG9m
IHNwYWNlIGluIHRoZQ0KPiA+IHJpbmdidWZmZXIuDQo+ID4NCj4gPiBPbiBhbiA4IGNvcmUgQXp1
cmUgVk0gd2l0aCAxNkdCIG9mIG1lbW9yeSB3aXRoIGEgc2luZ2xlIDEgVGlCIFNTRA0KPiA+IChy
dW5uaW5nIGFuIGZpbyB3b3JrbG9hZCB0aGF0IEkgY2FuIHByb3ZpZGUgaWYgbmVlZGVkKSwgc3Rv
cnZzY19kb19pbygpDQo+ID4gZW5kcyB1cCBvZnRlbiByZXR1cm5pbmcgU0NTSV9NTFFVRVVFX0RF
VklDRV9CVVNZLg0KPiA+DQo+ID4gVGhpcyBpcyB0aGUgY2FsbCBzdGFjazoNCj4gPg0KPiA+IGh2
X2dldF9ieXRlc190b193cml0ZQ0KPiA+IGh2X3JpbmdidWZmZXJfd3JpdGUNCj4gPiB2bWJ1c19z
ZW5kX3BhY2tldA0KPiA+IHN0b3J2c2NfZGlvX2lvDQo+ID4gc3RvcnZzY19xdWV1ZWNvbW1hbmQN
Cj4gPiBzY3NpX2Rpc3BhdGNoX2NtZA0KPiA+IHNjc2lfcXVldWVfcnENCj4gPiBkaXNwYXRjaF9y
cV9saXN0DQo+ID4NCj4gPj4gQmUgYXdhcmUgdGhhdCB0aGUgY2FsY3VsYXRpb24gb2YgImNhbl9x
dWV1ZSIgaW4gdGhpcyBkcml2ZXIgaXMgc29tZXdoYXQNCj4gPj4gZmxhd2VkIC0tIGl0IHNob3Vs
ZCBub3QgYmUgYmFzZWQgb24gdGhlIHNpemUgb2YgdGhlIHJpbmcgYnVmZmVyLCBidXQgaW5zdGVh
ZCBvbg0KPiA+PiB0aGUgbWF4aW11bSBudW1iZXIgb2YgcmVxdWVzdHMgSHlwZXItViB3aWxsIHF1
ZXVlLiAgQW5kIGV2ZW4gdGhlbiwNCj4gPj4gY2FuX3F1ZXVlIGRvZXNuJ3QgcHJvdmlkZSB0aGUg
Y2FwIHlvdSBtaWdodCBleHBlY3QgYmVjYXVzZSB0aGUgYmxrLW1xIGxheWVyDQo+ID4+IGFsbG9j
YXRlcyBjYW5fcXVldWUgdGFncyBmb3IgZWFjaCBIVyBxdWV1ZSwgbm90IGFzIGEgdG90YWwuDQo+
ID4NCj4gPg0KPiA+IFRoZSBkb2NzIGZvciBzY3NpX21pZF9sb3dfYXBpIGRvY3VtZW50IFNjc2lf
SG9zdCBjYW5fcXVldWUgdGhpcyB3YXk6DQo+ID4NCj4gPiAgICBjYW5fcXVldWUNCj4gPiAgICAt
IG11c3QgYmUgZ3JlYXRlciB0aGFuIDA7IGRvIG5vdCBzZW5kIG1vcmUgdGhhbiBjYW5fcXVldWUN
Cj4gPiAgICAgIGNvbW1hbmRzIHRvIHRoZSBhZGFwdGVyLg0KPiA+DQo+ID4gSSBkaWQgbm90aWNl
IHRoYXQgaW4gc2NzaV9ob3N0LmgsIHRoZSBjb21tZW50IGZvciBjYW5fcXVldWUgZG9lcyBzYXkN
Cj4gPiBjYW5fcXVldWUgaXMgdGhlICJtYXhpbXVtIG51bWJlciBvZiBzaW11bHRhbmVvdXMgY29t
bWFuZHMgYSBzaW5nbGUgaHcNCj4gPiBxdWV1ZSBpbiBIQkEgd2lsbCBhY2NlcHQuIiBIb3dldmVy
LCBJIGRvbid0IHNlZSBpdCBiZWluZyB1c2VkIHRoaXMgd2F5DQo+ID4gaW4gdGhlIGNvZGUuDQo+
ID4NCj4gDQo+IEpGWUksIHRoZSBibG9jayBsYXllciBlbnN1cmVzIHRoYXQgbm8gbW9yZSB0aGFu
IGNhbl9xdWV1ZSByZXF1ZXN0cyBhcmUNCj4gc2VudCB0byB0aGUgaG9zdC4gU2VlIHNjc2lfbXFf
c2V0dXBfdGFncygpLCBhbmQgaG93IHRoZSB0YWdzZXQgcXVldWUNCj4gZGVwdGggaXMgc2V0IHRv
IHNob3N0LT5jYW5fcXVldWUuDQo+IA0KPiBUaGFua3MsDQo+IEpvaG4NCg0KQWdyZWUgb24gd2hh
dCdzIGluIHNjc2lfbXFfc2V0dXBfdGFncygpLiAgQnV0IHNjc2lfbXFfc2V0dXBfdGFncygpIGNh
bGxzDQpibGtfbXFfYWxsb2NfdGFnX3NldCgpLCB3aGljaCBpbiB0dXJuIGNhbGxzIGJsa19tcV9h
bGxvY19tYXBfYW5kX3JlcXVlc3RzKCksDQp3aGljaCBjYWxscyBfX2Jsa19tcV9hbGxvY19ycV9t
YXBzKCkgcmVwZWF0ZWRseSwgcmVkdWNpbmcgdGhlIHRhZw0Kc2V0IHF1ZXVlX2RlcHRoIGFzIG5l
ZWRlZCB1bnRpbCBpdCBzdWNjZWVkcy4NCg0KVGhlIGtleSB0aGluZyBpcyB0aGF0IF9fYmxrX21x
X2FsbG9jX3JxX21hcHMoKSBpdGVyYXRlcyBvdmVyIHRoZQ0KbnVtYmVyIG9mIEhXIHF1ZXVlcyBj
YWxsaW5nIF9fYmxrX21xX2FsbG9jX21hcF9hbmRfcmVxdWVzdCgpLg0KVGhlIGxhdHRlciBmdW5j
dGlvbiBhbGxvY2F0ZXMgdGhlIG1hcCBhbmQgdGhlIHJlcXVlc3RzIHdpdGggYSBjb3VudA0Kb2Yg
dGhlIHRhZyBzZXQncyBxdWV1ZV9kZXB0aC4gICBUaGVyZSdzIG5vIGxvZ2ljIHRvIGFwcG9ydGlv
biB0aGUNCmNhbl9xdWV1ZSB2YWx1ZSBhY3Jvc3MgbXVsdGlwbGUgSFcgcXVldWVzLiBTbyBlYWNo
IEhXIHF1ZXVlIGdldHMNCmNhbl9xdWV1ZSB0YWdzIGFsbG9jYXRlZCwgYW5kIHRoZSBTQ1NJIGhv
c3QgZHJpdmVyIG1heSBzZWUgdXAgdG8NCihjYW5fcXVldWUgKiAjIEhXIHF1ZXVlcykgc2ltdWx0
YW5lb3VzIHJlcXVlc3RzLg0KDQpJJ20gY2VydGFpbmx5IG5vdCBhbiBleHBlcnQgaW4gdGhpcyBh
cmVhLCBidXQgdGhhdCdzIHdoYXQgSSBzZWUgaW4gdGhlDQpjb2RlLiAgV2UndmUgcnVuIGxpdmUg
ZXhwZXJpbWVudHMsIGFuZCBjYW4gc2VlIHRoZSBudW1iZXINCnNpbXVsdGFuZW91cyByZXF1ZXN0
cyBzZW50IHRvIHRoZSBzdG9ydnNjIGRyaXZlciBiZSBncmVhdGVyIHRoYW4NCmNhbl9xdWV1ZSB3
aGVuIHRoZSAjIG9mIEhXIHF1ZXVlcyBpcyBncmVhdGVyIHRoYW4gMSwgd2hpY2ggc2VlbXMNCnRv
IGJlIGNvbnNpc3RlbnQgd2l0aCB0aGUgY29kZS4NCg0KTWljaGFlbA0KDQo+IA0KPiANCj4gPiBE
dXJpbmcgZGlzcGF0Y2gsIEluIHNjc2lfdGFyZ2V0X3F1ZXVlX3JlYWR5KCksIHRoZXJlIGlzIHRo
aXMgY29kZToNCj4gPg0KPiA+ICAgICAgICAgIGlmIChidXN5ID49IHN0YXJnZXQtPmNhbl9xdWV1
ZSkNCj4gPiAgICAgICAgICAgICAgICAgIGdvdG8gc3RhcnZlZDsNCj4gPg0KPiA+IEFuZCB0aGUg
c2NzaV90YXJnZXQtPmNhbl9xdWV1ZSB2YWx1ZSBzaG91bGQgYmUgY29taW5nIGZyb20gU2NzaV9o
b3N0IGFzDQo+ID4gbWVudGlvbmVkIGluIHRoZSBzY3NpX3RhcmdldCBkZWZpbml0aW9uIGluIHNj
c2lfZGV2aWNlLmgNCj4gPiAgICAgIC8qDQo+ID4gICAgICAgICogTExEcyBzaG91bGQgc2V0IHRo
aXMgaW4gdGhlIHNsYXZlX2FsbG9jIGhvc3QgdGVtcGxhdGUgY2FsbG91dC4NCj4gPiAgICAgICAg
KiBJZiBzZXQgdG8gemVybyB0aGVuIHRoZXJlIGlzIG5vdCBsaW1pdC4NCj4gPiAgICAgICAgKi8N
Cj4gPiAgICAgIHVuc2lnbmVkIGludCAgICAgICAgICAgIGNhbl9xdWV1ZTsNCj4gPg0KPiA+IFNv
LCBJIGRvbid0IHJlYWxseSBzZWUgaG93IHRoaXMgd291bGQgYmUgcGVyIGhhcmR3YXJlIHF1ZXVl
Lg0KPiA+DQo+ID4+DQo+ID4+IEkgYWdyZWUgdGhhdCB0aGUgY21kX3Blcl9sdW4gc2V0dGluZyBp
cyBhbHNvIHRvbyBiaWcsIGJ1dCB3ZSBzaG91bGQgZml4IHRoYXQgaW4NCj4gPj4gdGhlIGNvbnRl
eHQgb2YgZ2V0dGluZyBhbGwgb2YgdGhlc2UgZGlmZmVyZW50IHNldHRpbmdzIHdvcmtpbmcgdG9n
ZXRoZXIgY29ycmVjdGx5LA0KPiA+PiBhbmQgbm90IHBpZWNlbWVhbC4NCj4gPj4NCj4gPg0KPiA+
IENhcHBpbmcgU2NzaV9Ib3N0LT5jbWRfcGVyX2x1biB0byBzY3NpX2RyaXZlci5jYW5fcXVldWUg
ZHVyaW5nIHByb2JlDQo+ID4gd2lsbCBhbHNvIHByZXZlbnQgdGhlIExVTiBxdWV1ZV9kZXB0aCBm
cm9tIGJlaW5nIHNldCB0byBhIHZhbHVlIHRoYXQgaXMNCj4gPiBoaWdoZXIgdGhhbiBpdCBjYW4g
ZXZlciBiZSBzZXQgdG8gYWdhaW4gYnkgdGhlIHVzZXIgd2hlbg0KPiA+IHN0b3J2c2NfY2hhbmdl
X3F1ZXVlX2RlcHRoKCkgaXMgaW52b2tlZC4NCj4gPg0KPiA+IEFsc28gaW4gc2NzaV9zeXNmcyBz
ZGV2X3N0b3JlX3F1ZXVlX2RlcHRoKCkgdGhlcmUgaXMgdGhpcyBjaGVjazoNCj4gPg0KPiA+ICAg
ICAgICAgICAgaWYgKGRlcHRoIDwgMSB8fCBkZXB0aCA+IHNkZXYtPmhvc3QtPmNhbl9xdWV1ZSkN
Cj4gPiAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+DQo+ID4gSSB3b3VsZCBh
bHNvIG5vdGUgdGhhdCBWaXJ0SU8gU0NTSSBpbiB2aXJ0c2NzaV9wcm9iZSgpLCBTY3NpX0hvc3Qt
PmNtZF9wZXJfbHVuDQo+ID4gaXMgc2V0IHRvIHRoZSBtaW4gb2YgdGhlIGNvbmZpZ3VyZWQgY21k
X3Blcl9sdW4gYW5kDQo+ID4gU2NzaV9Ib3N0LT5jYW5fcXVldWU6DQo+ID4NCj4gPiAgICAgIHNo
b3N0LT5jbWRfcGVyX2x1biA9IG1pbl90KHUzMiwgY21kX3Blcl9sdW4sIHNob3N0LT5jYW5fcXVl
dWUpOw0KPiA+DQo+ID4gQmVzdCwNCj4gPiBNZWxhbmllDQo+ID4gLg0KPiA+DQoNCg==
