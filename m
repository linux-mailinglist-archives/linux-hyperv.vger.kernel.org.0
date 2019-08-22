Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A796D9A016
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2019 21:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388609AbfHVTcb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Aug 2019 15:32:31 -0400
Received: from mail-eopbgr800112.outbound.protection.outlook.com ([40.107.80.112]:14136
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726319AbfHVTca (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Aug 2019 15:32:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k71/qGZyx4p0B0z3g9wwbgKyoDXNmpQR18A7SPepvtr4cCM6GrYiIkPjIpAQMBiUVc6ZFB+wgO+OdOyzWAtbPZoi+pR7zYnXqKxjtD82iUyVrVA0eZDN/VR6vimapagYIqRCXoAfAxCWoV1c3jGMGyV1IXG5OL+KZajvyzi/gsSzxGpeLunK3+y1otNhNRzKgHJzeAnfhPVUagkTtWU5yCQ5WmhljxFJ/6Ny86oFyukjXNpj//9nKp9KifFOro4lTQdNBEyDsJmwUAuctA7xgY5aFCJrN1tXSpFQZwjGnVlqqmPrv7vy8/0hTDRHy7Gut9M+6MahHBSG1jTpABxyBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffOdK38UFNymeQ/bH2Ptl6aJC4MKZynyFJXdxlZp/5M=;
 b=Ju5qN55goRy9qjIt3GchcNQARui5ICUwxVn310sQ7SLwAsF2Y18mClrntsQyir2sIdGQMlF6b4vuyymiyfTwIxiS2uMBT3vyhTBT2hyAYqecvcu4v3z4dI96/V6Otd76JzTqz4sKU8CJvuffxXshOkcCMOSR0sLjjiUzAKPB8pGbFQ8FxwBGdv63KVfOkjNt/mYMoE/r5Ex98MS/hGoqlimR7wkZoVGXeLvWkUi8MVb+jbJ8Ggc0v8/yDtu2gR+h8URizPUzUZUdZXghauoxdGd0fDXj+/iy5qxcD02tvyHdpSavYzUKgHzzsW8A2ZxWOoV7dXm3RlNqYjoMfvDyyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffOdK38UFNymeQ/bH2Ptl6aJC4MKZynyFJXdxlZp/5M=;
 b=TQFQIeAE1RmbEsDXSl6oD7VlWF7Y80DCOm4SWsHZtxYQkGljfNr0gUsJooepI4pm4n2oNqVXAPvRvqUqDSlbew33/cKynCw0vXbb6vt89rAW0yaA1bs4zdr2NWJMjN4VDcavLG2hZIRTHaPt1tN0hT4dpGt0RS6+NFYu2XGBBGY=
Received: from CY4PR21MB0741.namprd21.prod.outlook.com (10.173.189.7) by
 CY4PR21MB0774.namprd21.prod.outlook.com (10.173.192.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.3; Thu, 22 Aug 2019 19:31:48 +0000
Received: from CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::2c62:5380:9ed8:496d]) by CY4PR21MB0741.namprd21.prod.outlook.com
 ([fe80::2c62:5380:9ed8:496d%11]) with mapi id 15.20.2220.000; Thu, 22 Aug
 2019 19:31:47 +0000
From:   Long Li <longli@microsoft.com>
To:     Ming Lei <tom.leiming@gmail.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] storvsc: setup 1:1 mapping between hardware queue and CPU
 queue
Thread-Topic: [PATCH] storvsc: setup 1:1 mapping between hardware queue and
 CPU queue
Thread-Index: AQHVVsVOjR1+/ppGqEWs+/6gvc3lXacHArEAgACQC8A=
Date:   Thu, 22 Aug 2019 19:31:47 +0000
Message-ID: <CY4PR21MB07415687EE2329FF320A152ECEA50@CY4PR21MB0741.namprd21.prod.outlook.com>
References: <1566243316-113690-1-git-send-email-longli@linuxonhyperv.com>
 <CACVXFVOGdvMDSZTUNH3DrXErm1E4LKBjzCFpL3r815JFJbvM4A@mail.gmail.com>
In-Reply-To: <CACVXFVOGdvMDSZTUNH3DrXErm1E4LKBjzCFpL3r815JFJbvM4A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:7:ede6:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24261170-8c77-4c4d-e737-08d727375fac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0774;
x-ms-traffictypediagnostic: CY4PR21MB0774:|CY4PR21MB0774:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB0774DE7C12461FE004061E52CEA50@CY4PR21MB0774.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(199004)(51914003)(189003)(25786009)(33656002)(71190400001)(8990500004)(66946007)(76116006)(53936002)(52536014)(2906002)(2501003)(10090500001)(6116002)(6246003)(5660300002)(256004)(7696005)(66556008)(66476007)(4326008)(64756008)(66446008)(478600001)(316002)(46003)(7736002)(9686003)(81166006)(81156014)(110136005)(99286004)(305945005)(74316002)(8676002)(186003)(229853002)(14454004)(76176011)(11346002)(10290500003)(6506007)(86362001)(6436002)(102836004)(446003)(71200400001)(22452003)(54906003)(55016002)(8936002)(476003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0774;H:CY4PR21MB0741.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3IYGfVrMwxsQTZsjLJGNYlZAmlf1uIztL/SeSIgKvEAdBogyzjBe20KCV7Sb71anoh/Wg/nPTdmm+KdZaQmwE7pATetzaOQaebiQeyimRylfi3WYkwg7WRf/fGyyY4FONOkIALmc7vIRt0ZaEv9pwBNjtkQQc0qx7iXO1N/hjpnqnZpCsZq/F+RJwDVp2M9nbqWR3aZHA4nzR2xSP8y4i4J2CV81Oo8ar/w89iG4vizmAGcEgzERK+cUyE303PCkvNNnnNeIX9D4/KlJMIRJjLb5FVVsRIl+136r7E9CQWDLt8X95slV/3nNqnIT2FxYt2P6FDlB1s/1Zaxfvh5HlU2kmNOJJcS0LbUTtra0mfBVmwtp0nnhttvOjg9xwjadfEr73Hw9rXXxuVOnIkOAHrPFDpp9R/49Tuly+A7rJEs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24261170-8c77-4c4d-e737-08d727375fac
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 19:31:47.6836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7gbwzHM6zI4wU3PoQ56PgIlVwUQOFVCl7vWYutcYQhCpJMPv8rNWBaFpeLezCbwH4bxp/pp3Ce8aXmwjiLDuuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0774
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Pj4+U3ViamVjdDogUmU6IFtQQVRDSF0gc3RvcnZzYzogc2V0dXAgMToxIG1hcHBpbmcgYmV0d2Vl
biBoYXJkd2FyZSBxdWV1ZQ0KPj4+YW5kIENQVSBxdWV1ZQ0KPj4+DQo+Pj5PbiBUdWUsIEF1ZyAy
MCwgMjAxOSBhdCAzOjM2IEFNIDxsb25nbGlAbGludXhvbmh5cGVydi5jb20+IHdyb3RlOg0KPj4+
Pg0KPj4+PiBGcm9tOiBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT4NCj4+Pj4NCj4+Pj4g
c3RvcnZzYyBkb2Vzbid0IHVzZSBhIGRlZGljYXRlZCBoYXJkd2FyZSBxdWV1ZSBmb3IgYSBnaXZl
biBDUFUgcXVldWUuDQo+Pj4+IFdoZW4gaXNzdWluZyBJL08sIGl0IHNlbGVjdHMgcmV0dXJuaW5n
IENQVSAoaGFyZHdhcmUgcXVldWUpDQo+Pj4+IGR5bmFtaWNhbGx5IGJhc2VkIG9uIHZtYnVzIGNo
YW5uZWwgdXNhZ2UgYWNyb3NzIGFsbCBjaGFubmVscy4NCj4+Pj4NCj4+Pj4gVGhpcyBwYXRjaCBz
ZXRzIHVwIGEgMToxIG1hcHBpbmcgYmV0d2VlbiBoYXJkd2FyZSBxdWV1ZSBhbmQgQ1BVDQo+Pj5x
dWV1ZSwNCj4+Pj4gdGh1cyBhdm9pZGluZyB1bm5lY2Vzc2FyeSBsb2NraW5nIGF0IHVwcGVyIGxh
eWVyIHdoZW4gaXNzdWluZyBJL08uDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IExvbmcgTGkg
PGxvbmdsaUBtaWNyb3NvZnQuY29tPg0KPj4+PiAtLS0NCj4+Pj4gIGRyaXZlcnMvc2NzaS9zdG9y
dnNjX2Rydi5jIHwgMTYgKysrKysrKysrKysrKystLQ0KPj4+PiAgMSBmaWxlIGNoYW5nZWQsIDE0
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3Njc2kvc3RvcnZzY19kcnYuYyBiL2RyaXZlcnMvc2NzaS9zdG9ydnNjX2Rydi5jDQo+
Pj4+IGluZGV4IGI4OTI2OTEyMGEyZC4uMjZjMTZkNDBlYzQ2IDEwMDY0NA0KPj4+PiAtLS0gYS9k
cml2ZXJzL3Njc2kvc3RvcnZzY19kcnYuYw0KPj4+PiArKysgYi9kcml2ZXJzL3Njc2kvc3RvcnZz
Y19kcnYuYw0KPj4+PiBAQCAtMTY4Miw2ICsxNjgyLDE4IEBAIHN0YXRpYyBpbnQgc3RvcnZzY19x
dWV1ZWNvbW1hbmQoc3RydWN0DQo+Pj5TY3NpX0hvc3QgKmhvc3QsIHN0cnVjdCBzY3NpX2NtbmQg
KnNjbW5kKQ0KPj4+PiAgICAgICAgIHJldHVybiAwOw0KPj4+PiAgfQ0KPj4+Pg0KPj4+PiArc3Rh
dGljIGludCBzdG9ydnNjX21hcF9xdWV1ZXMoc3RydWN0IFNjc2lfSG9zdCAqc2hvc3QpIHsNCj4+
Pj4gKyAgICAgICB1bnNpZ25lZCBpbnQgY3B1Ow0KPj4+PiArICAgICAgIHN0cnVjdCBibGtfbXFf
cXVldWVfbWFwICpxbWFwID0NCj4+Pj4gKyZzaG9zdC0+dGFnX3NldC5tYXBbSENUWF9UWVBFX0RF
RkFVTFRdOw0KPj4+PiArDQo+Pj4+ICsgICAgICAgZm9yX2VhY2hfcG9zc2libGVfY3B1KGNwdSkg
ew0KPj4+PiArICAgICAgICAgICAgICAgcW1hcC0+bXFfbWFwW2NwdV0gPSBjcHU7DQo+Pj4+ICsg
ICAgICAgfQ0KPj4+DQo+Pj5CbG9jayBsYXllciBwcm92aWRlcyB0aGUgaGVscGVyIG9mIGJsa19t
cV9tYXBfcXVldWVzKCksIHNvIHN1Z2dlc3QgeW91DQo+Pj50byB1c2UgdGhlIGRlZmF1bHQgY3B1
IG1hcHBpbmcsIGluc3RlYWQgb2YgaW52ZW50aW5nIGEgbmV3IG9uZS4NCg0KVGhhbmtzIGZvciB0
aGUgcG9pbnRlci4gSSdtIHNlbmRpbmcgYSB2Mi4NCg0KTG9uZw0KDQo+Pj4NCj4+PnRoYW5rcywN
Cj4+Pk1pbmcgTGVpDQo=
