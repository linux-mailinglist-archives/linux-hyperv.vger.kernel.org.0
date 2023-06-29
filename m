Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E416C742BD0
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jun 2023 20:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjF2STE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Jun 2023 14:19:04 -0400
Received: from mail-bn8nam12on2132.outbound.protection.outlook.com ([40.107.237.132]:15424
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232006AbjF2SSp (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Jun 2023 14:18:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRJnNpb2x+0+O2/GT4mgFMiHjiHEg6TnUXIa07R3cE2DSmZMK7yIE0/r8nUZToyoNN5ZOcsBi6iLz9JHphx6aS6dBJdxPsgIGs5fpE32EghiJUaXc0UPS/6gyPN4/OLxngHE1cePa3Xq6iWqv90TWaKyUB/XV4AQYedLw0C4rbgY+2MJd/WJOuD3Uo9IO20a/rb9fm/0qFoip/xYJl7Doc3tbf3p75kLfTOsZ5wcdfVlQlWX3Jw3fozkM9tiQiD0HFDy/nRLM6GfNiUCVX8hfWMC4/SyVhD7+zm7ChD5QegzhBgdhKN4znuQjM7u+5BAaTLsTmbYWV0lVP6PL2nkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txrU1yCyOv0w4BIeM+1828wYdwMr/DU6nHeKzWR/21U=;
 b=ngd/5gfoDNebR8yRNaz/kD0DwekzHXykiUrh+6gdphwlnl6SooZvHtUZKWADDv1f1x8e8TnJD94qipH4DvN1lJ7dJaWwLLrAfyWHZvfI0+FHc3iiAi+/Y2XyZYSUy7BHO7xBjbZmCcIy2jMwzYr8MT8Vb+dAY4TLk0BokTw1wjIhYf6YUhCPr698rWbj1tms3NC8+VIIO28L9ZPU+e71NW1UNjLsmT29eQJle6Zj1D6tDSba+4nAJH5UG2hcqCh4fBxKf+IWUuo6/cLynV5/nMccnw6XwwQOqhPe/JboN+eFL5gWmUYtTgJoVhByxf7GCKti70N7r8ZVW1QG5uOi5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txrU1yCyOv0w4BIeM+1828wYdwMr/DU6nHeKzWR/21U=;
 b=d3IutYeE6bhXmQ1DuXG7mMxd+7NcYogXQc1aFviPonAx0OFmqMec5BWBJvb3ukeqPvYfi9PqypXft0tafZfjTs/R1P0wYtmLcBbgDlrjmA5KAULZm5BWBrdkqWWOYPLxbxmqYh8GtQYbWTg7mUf1NUJiMiP2EeSfx/Hshcl9B0Q=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by DS7PR21MB3774.namprd21.prod.outlook.com (2603:10b6:8:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.2; Thu, 29 Jun
 2023 18:18:37 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::eee5:34cd:7c3b:9374]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::eee5:34cd:7c3b:9374%5]) with mapi id 15.20.6544.002; Thu, 29 Jun 2023
 18:18:37 +0000
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
Thread-Index: AQHZqInuIa+OQxGM80ioo4gKQGwCLa+hejgAgACaBvA=
Date:   Thu, 29 Jun 2023 18:18:37 +0000
Message-ID: <PH7PR21MB3263B266E381BA15DCE45820CE25A@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1687823827-15850-1-git-send-email-longli@linuxonhyperv.com>
 <36c95dd6babb2202f70594d5dde13493af62dcad.camel@redhat.com>
In-Reply-To: <36c95dd6babb2202f70594d5dde13493af62dcad.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=85c90530-9160-4d34-be45-a940b05802ab;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-29T17:53:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|DS7PR21MB3774:EE_
x-ms-office365-filtering-correlation-id: 5649e318-be4f-476d-9f82-08db78cd4222
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2sDEkZ803zmHPSa+i+Vv98mhwVCKEq2HbRW5ery1GncD61yW64iX0QPY3Fzl3FyHkU5AsZACXPuoc6Lo1OlKjZ5NI3ibn7uBL7RdAq5X9dOMEIHY7nA5+FGctSCjKq1JHiF+VtaMcClGpXk8qSbLU6sBO7ouuje7+dDIz4/DZRsEVMdEQg7m3OG8yIJHsw4g2Mq7gtUSIda2V6Hg/MKRYK7cawRsbAJEngyPAWAhQ72gSQjaqa5fa7KijDT0NPLEVYptRANgbmWH6bx55Ua4wMKjtelmbMhNfp9/VpapIPUnzLLK0lcPMr3zZpBffGuUNWWT/8+0XZxcCqvuUqhbSsvLYr97jg1bo+ruqe/NSgPqg9xl+DbRdNjXQFCL/7lIBkNRgCjuvfjiq15YGJMdjeqs88JZjTjH2P2J8XqXM46wHgbnFS47tyuPuMNPKux/QpG8zpxCJEAL2ruuRczUlFF9kEvEIJc1gQol8LWYZdQdoasO03/rJymQA7L9Lfxt+fpd6uGr0kDIy7PRcSPDDlsYcguK3hjUjLxqCD5eopBLLr2bEoKFfxe1KkB3v33IB/Q/Gx+CSxNlS1ampHygpkNBqCuqMLFqeR3dLY75s87596qhpKCLNzpTwEegvGhnnFeeJ9thDbxymPugPi1T8fw0xHq2YbrOWK8jcTZHbnNlZdimcYGPFrM5fNU6mm4Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199021)(122000001)(6506007)(64756008)(66556008)(66476007)(316002)(186003)(4326008)(9686003)(66446008)(76116006)(52536014)(26005)(66946007)(478600001)(86362001)(8990500004)(83380400001)(55016003)(82950400001)(7696005)(7416002)(38070700005)(8676002)(33656002)(5660300002)(54906003)(82960400001)(41300700001)(10290500003)(8936002)(110136005)(2906002)(38100700002)(921005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2o4RytSeGNRelQrTjZURW1aa25heFpCNVBOdThKVEVKMkZKbUExdENQQmlk?=
 =?utf-8?B?Qnk0b25pREkwTXB5K1k0NTNXR290cXRZdmpESzY5eW1PY0Z1K3UwaGlObjln?=
 =?utf-8?B?VC9KNkRmZGt1WkJHaGRUYmttMFNFYm1JRmdZMS9Od3NJbUVDNFVjVmladTlZ?=
 =?utf-8?B?U0c2UVUzY1NwNnNRZzZYR0lkWG05aEhVSlBoZ3ZkbWs1ZzJoTHNYS2tnQVUx?=
 =?utf-8?B?SzBpZDIvd1R1Y2NLUmRycmRya3BqajJMTmREcnVsSU8rbnFHcTVCUlJ2dkpS?=
 =?utf-8?B?NDFUeVB0UFVvdnBQNW5ueTZya3dsMGJDM1BROXFMdzhOMFdQZkRxWVFSaTh0?=
 =?utf-8?B?b3RUNTkvSEluUVNiZ01VV05WM3ZHcXhmQTRhWTZaM0tNOWVGY1RRNGpjZFc0?=
 =?utf-8?B?WlBLL3NUVnFYQm14OHJpWWpvRythZzI2Snp2VmdoUWZJRDYxbkFjNkxEcWVD?=
 =?utf-8?B?Y3p6MUNocU5kdzRCV0Q0Y25nT3Qzb0pxK0QvN3pXZjNSK2JBNTlVVU82a0Yz?=
 =?utf-8?B?eTAxVDJNN0N1dExDMjI3a0dWcXFSb1dhUVN5T2pxM3B4NzBWMUZUYzVtbTdS?=
 =?utf-8?B?UWluY0hVY1NRYVYyeUZSU2xtWncrWE5FeFhYaTR2ai92cE9XdUVDcnNGdmU3?=
 =?utf-8?B?R3VHQitRWlFlV3lkYUcxMjVjbjJPWThSRHIxdEhVUXM3SWYrampxRDU2MUFw?=
 =?utf-8?B?NGt6ajJKL3Bmc1hJVWxUUFM2ekR3WjZsQTRjUUdtVTVJUE5aYktsVkNqLzc0?=
 =?utf-8?B?NFJldHR5ZUtsSUt5Y0NQOGozcWRiVDBpZnJ2RkxnZVNNNGRDNmxzYk9qS1cw?=
 =?utf-8?B?V2QwcEZxbmFNWktGTkxnZ2RZOUd1SFkxNW51K1phclVnbTdqckJoYnN2WUZj?=
 =?utf-8?B?N3EzL0phRWtnQWcyVXVyWWwyNkJTWWNQeC8zMG9FNnpQKzUxQkVwdHVxTlla?=
 =?utf-8?B?dndwSzdSODJlbkRkTWwvNkJBNHNUQXJTYm52YS9neHVESHR1aUlDeSt0VVhN?=
 =?utf-8?B?d09JcytaR2NIdDk1Rll4enNoYTZKQ3BmVEsway83SFZEanJRUytiNEpPL0Jq?=
 =?utf-8?B?bjc1WjdtSXZpWE1kT3hWVUlOb1kvYmFjV0FHbHMrQVpUa2k1RWxoRTB2c0E1?=
 =?utf-8?B?Ny9aaTlDaTNSOTJ3NzdPUE1xTFhCY3NqOSttcVl1dThBSUdlMVAvZjViZVJY?=
 =?utf-8?B?eHZ1dUFjclhUSWNvb3ErdDViYVErS3RiYlFndE1OR1JSOHdCbC91RUl2ck1U?=
 =?utf-8?B?R09BZENDSTRtYWFkMFlUUGVyc0tLTXlQWFJXcWx0eFV3UEcxTEJ4Y09hdUYv?=
 =?utf-8?B?czVrb1FUUWVQbHVPbzAydFkwYlAya29tOEl6MUtDbWYrNXg2ZTYvYXZWVmxO?=
 =?utf-8?B?Nm1uOHJXdDFISXZSVjJFbzVVdmp5VlJqMktCVGhYL2FrcDE1TkQrNzZQYWpa?=
 =?utf-8?B?eGZiR0J4cDZIK1c0WkNNanh2VU1UeXdlNG9vQzF2RFpzRm9xY0N4QnpGTEdM?=
 =?utf-8?B?Q2RzUktaMmJ3RmxBSERUMEdrRW1mVTZPQXBqc1M3clJqdFhhbHJUQ080Q2dm?=
 =?utf-8?B?dWRkN2JVbFd3dTF2bCtTdmZ1ZXQ5emUxdStIS2Y0SitSQldQWlAvdGNDRHNZ?=
 =?utf-8?B?UnhRY0lZb2tpZGhKOGV2cFNyblZPcmxDcHpXM21RYjViRkhQa2phelVkcnFE?=
 =?utf-8?B?bGV0ZnNvUFlCTU5hRkpqWVk3ZG9JZUtjSHk5aUM3dUxmbDlWQVNPSUNUamNa?=
 =?utf-8?B?VTFqd1FsSGdXdGpIK1FWVmwyOStIemZLZy93SDVNeC8rQm9VVlZuWHNaSmhk?=
 =?utf-8?B?bXVqQUk3YUZKM0IrTU1rYmZLVCtRc1lTTWx3UEIvdldXV0ZzbU5MYm0vb1N3?=
 =?utf-8?B?WUlVcERZUjR3V2JHdVpyeVJwYlZPRDduWSt6ZEhIUEtYOG0rQjNDNVBZS21W?=
 =?utf-8?B?RlZaZ3VNdU1kUDRIeXNmdkl4c2xrVGRjYWtFRU1IOCtEeENrY0FRREN5LzFB?=
 =?utf-8?B?Vi9zTUh2NndRLzZIQ2pnaVFCcGNETkpnamxnMkM4Q015ZkxvNWh1K0dPeGR4?=
 =?utf-8?B?SER0NGN2Y1hSZ05ndDZ6NlpzcDhtWWVwNklmU0RyT0xPSnZ5ZlVrSFhvSTNl?=
 =?utf-8?Q?xUM8Dne5RRH+glEaVSIyoApog?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5649e318-be4f-476d-9f82-08db78cd4222
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 18:18:37.5957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FCAbnw5LQgh8cjblUhG8epMb7sbH+7o6yQtl0tsmYIhRTm+qaYHb+pGRi8R7/bxUo2BjE012kWhZDkrdL9NHlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3774
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BhdGNoIHYzXSBuZXQ6IG1hbmE6IEJhdGNoIHJpbmdpbmcgUlggcXVl
dWUgZG9vcmJlbGwgb24gcmVjZWl2aW5nDQo+IHBhY2tldHMNCj4gDQo+IE9uIE1vbiwgMjAyMy0w
Ni0yNiBhdCAxNjo1NyAtMDcwMCwgbG9uZ2xpQGxpbnV4b25oeXBlcnYuY29tIHdyb3RlOg0KPiA+
IEZyb206IExvbmcgTGkgPGxvbmdsaUBtaWNyb3NvZnQuY29tPg0KPiA+DQo+ID4gSXQncyBpbmVm
ZmljaWVudCB0byByaW5nIHRoZSBkb29yYmVsbCBwYWdlIGV2ZXJ5IHRpbWUgYSBXUUUgaXMgcG9z
dGVkDQo+ID4gdG8gdGhlIHJlY2VpdmVkIHF1ZXVlLiBFeGNlc3NpdmUgTU1JTyB3cml0ZXMgcmVz
dWx0IGluIENQVSBzcGVuZGluZw0KPiA+IG1vcmUgdGltZSB3YWl0aW5nIG9uIExPQ0sgaW5zdHJ1
Y3Rpb25zIChhdG9taWMgb3BlcmF0aW9ucyksIHJlc3VsdGluZw0KPiA+IGluIHBvb3Igc2NhbGlu
ZyBwZXJmb3JtYW5jZS4NCj4gPg0KPiA+IE1vdmUgdGhlIGNvZGUgZm9yIHJpbmdpbmcgZG9vcmJl
bGwgcGFnZSB0byB3aGVyZSBhZnRlciB3ZSBoYXZlIHBvc3RlZA0KPiA+IGFsbCBXUUVzIHRvIHRo
ZSByZWNlaXZlIHF1ZXVlIGR1cmluZyBhIGNhbGxiYWNrIGZyb20gbmFwaV9wb2xsKCkuDQo+ID4N
Cj4gPiBXaXRoIHRoaXMgY2hhbmdlLCB0ZXN0cyBzaG93ZWQgYW4gaW1wcm92ZW1lbnQgZnJvbSAx
MjBHL3MgdG8gMTYwRy9zIG9uDQo+ID4gYSAyMDBHIHBoeXNpY2FsIGxpbmssIHdpdGggMTYgb3Ig
MzIgaGFyZHdhcmUgcXVldWVzLg0KPiA+DQo+ID4gVGVzdHMgc2hvd2VkIG5vIHJlZ3Jlc3Npb24g
aW4gbmV0d29yayBsYXRlbmN5IGJlbmNobWFya3Mgb24gc2luZ2xlDQo+ID4gY29ubmVjdGlvbi4N
Cj4gPg0KPiA+IFdoaWxlIHdlIGFyZSBtYWtpbmcgY2hhbmdlcyBpbiB0aGlzIGNvZGUgcGF0aCwg
Y2hhbmdlIHRoZSBjb2RlIGZvcg0KPiA+IHJpbmdpbmcgZG9vcmJlbGwgdG8gc2V0IHRoZSBXUUVf
Q09VTlQgdG8gMCBmb3IgUmVjZWl2ZSBRdWV1ZS4gVGhlDQo+ID4gaGFyZHdhcmUgc3BlY2lmaWNh
dGlvbiBzcGVjaWZpZXMgdGhhdCBpdCBzaG91bGQgc2V0IHRvIDAuIEFsdGhvdWdoDQo+ID4gY3Vy
cmVudGx5IHRoZSBoYXJkd2FyZSBkb2Vzbid0IGVuZm9yY2UgdGhlIGNoZWNrLCBpbiB0aGUgZnV0
dXJlDQo+ID4gcmVsZWFzZXMgaXQgbWF5IGRvLg0KPiA+DQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcNCj4gPiBGaXhlczogY2E5YzU0ZDJkNmE1ICgibmV0OiBtYW5hOiBBZGQgYSBkcml2
ZXIgZm9yIE1pY3Jvc29mdCBBenVyZQ0KPiA+IE5ldHdvcmsgQWRhcHRlciAoTUFOQSkiKQ0KPiAN
Cj4gVWhtbW0uLi4gdGhpcyBsb29rcyBsaWtlIGEgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQgdG8g
bWUsIG1vcmUgc3VpdGFibGUgZm9yDQo+IHRoZSBuZXQtbmV4dCB0cmVlID8hPyAoTm90ZSB0aGF0
IG5ldC1uZXh0IGlzIGNsb3NlZCBub3cpLg0KDQpUaGlzIGlzc3VlIGlzIGEgYmxvY2tlciBmb3Ig
dXNhZ2Ugb24gMjAwRyBwaHlzaWNhbCBsaW5rLiBJIHRoaW5rIGl0IGNhbiBiZSBjYXRlZ29yaXpl
ZCBhcyBhIGZpeC4NCg0KPiANCj4gSW4gYW55IGNhc2UgeW91IG11c3QgYXZvaWQgZW1wdHkgbGlu
ZXMgaW4gdGhlIHRhZyBhcmVhLg0KPiANCj4gSWYgeW91IHJlYWxseSBpbnRlbmQgdGFyZ2V0aW5n
IHRoZSAtbmV0IHRyZWUsIHBsZWFzZSByZXBvc3QgZml4aW5nIHRoZSBhYm92ZSBhbmQNCj4gZXhw
bGljaXRseSBzcGVjaWZ5aW5nIHRoZSB0YXJnZXQgdHJlZSBpbiB0aGUgc3ViaiBwcmVmaXguDQoN
CldpbGwgZG8sIHRoYW5rIHlvdS4NCg0KTG9uZw0KDQo+IA0KPiB0aGFua3MhDQo+IA0KPiBQYW9s
bw0KDQo=
