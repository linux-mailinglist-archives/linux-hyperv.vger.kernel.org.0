Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84900742AD9
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jun 2023 18:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjF2Qxr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Jun 2023 12:53:47 -0400
Received: from mail-bn8nam12on2121.outbound.protection.outlook.com ([40.107.237.121]:25089
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229494AbjF2Qxq (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Jun 2023 12:53:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhdFUo38idtOiq/+M375XLRsF1amksxV0YWyKze/gFmPZvsbZ0d0ZJRPtIZmKxP17ddnrDFNraVDq6wD04aTz/TLhyOrjQTZSsQVb1w29QsHT/Riq0ESYt2HTdZzSsT1iRXPC8h01lGcxOkqd1sJQDNsz/CE644fFyJSrQA+ak7AVszvwtkoO92avLLyUSwO5xRGXOCkJsL4Fg8ZP+/tugFcyiQ9v7TcU7vwyzVEy7cMvsSCFDKWCNGf4lZXKed/FB8YZ3mSyfLpbvPjVQS8w2twxMtVn/0PMunvK8Lcs0UVrfQ1nXQEnCXQxGEH3SXhGYenL8/YT4+SLZkWDS0mJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INs4lopK9B3qHdy3prw8He8yWTuuiKwQhc6tDDsH03k=;
 b=TUT9zctSs93E4XWchNMF6bo64uJtGvP8yoCQrS6F2tHDF9guHVmm+d/jOhVkD3dvxe10FjTyyl/qbbPP3ZlNT0vIUAKEzWBGidp5A5T42AC9xjcCTwqp8QUnKY3TmkVq2IUUU7qwcKR9qjXAh9uHVxArIItYJaF5V653BrpIwpsA0hgyt88EUh7jX32iCnjYBJsQBSWyKanaTQwxUWr+OOkt0bhwAQJyOkGDSfhGo3jJpTQuqWx8dkOgN4II+mcaQUZ8jgCqAMPqKXnHfh3poS2Ch2j0B1wwuSiRBq+gU0aXQId7dJDCpVut0RK900hJhFtpp8rNw7SIEAvEEvqr4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INs4lopK9B3qHdy3prw8He8yWTuuiKwQhc6tDDsH03k=;
 b=SZJDDVxnrITDUjTfEhIfyG1lELlpNsMeBY67TsWncHfflWdgdl6LmlqyG8HowM15wyvz26vGb0u2kp4kCsUhPxXtft+7U88AIh/Bcxci6SGy2T5jJxDOvuNyAOsoyXM9WuesOcUf8wS0+ylpD/K8jt26/ryfRJNknPpQrz1+SmU=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by SJ0PR21MB1294.namprd21.prod.outlook.com (2603:10b6:a03:3f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.8; Thu, 29 Jun
 2023 16:53:42 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::848b:6d47:841d:20ff]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::848b:6d47:841d:20ff%4]) with mapi id 15.20.6544.006; Thu, 29 Jun 2023
 16:53:42 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Paolo Abeni <pabeni@redhat.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Long Li <longli@microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Patch v3] net: mana: Batch ringing RX queue doorbell on
 receiving packets
Thread-Topic: [Patch v3] net: mana: Batch ringing RX queue doorbell on
 receiving packets
Thread-Index: AQHZqInu5QIPQqXV1UCF4asyOz+7fK+hejgAgACImMA=
Date:   Thu, 29 Jun 2023 16:53:42 +0000
Message-ID: <PH7PR21MB3116276E09BFD0950FB0FB49CA25A@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1687823827-15850-1-git-send-email-longli@linuxonhyperv.com>
 <36c95dd6babb2202f70594d5dde13493af62dcad.camel@redhat.com>
In-Reply-To: <36c95dd6babb2202f70594d5dde13493af62dcad.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=429f960d-d77f-4361-b17a-0bbf1a84560f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-29T16:51:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|SJ0PR21MB1294:EE_
x-ms-office365-filtering-correlation-id: 0fb12598-1e27-4b24-cefe-08db78c16537
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NNqQ98WdiBMRaKlqrJUvYNSHytzytCdsVnxYfbj3ep+XynOD1AK1GW0MJJEDaPHypcIkG3JKndOIyVlW+qRKKdhZkBxaKhe78OJeCbJrd5gsxme9TT0mixd1exBDyEc8Oxnqv3tnjEwNIVaSuvIKxq0+9ABJHvMjlf5/mod+wUcqj5lBCV5HgDM+LaR0KbFg7ZzBkq0LZhXxYGIRfFXlTTtYKFGXLfqyM2U7P1IdUpNIdSClZ5EXNc2QpvURe0ch85ddJ5VrmPqVCea62mX6v2E/Je/mqAdl+uI64quUGypzT9OgK+sXA8IhYfhgkfcj729JE/Q9SfUzBnJMdEBnZiddZ1x4LMP2AcZLtSV0FXdvEn9jp5qtGtzL385BdO6OMBMEFB55OMZTeteoPOef1NW/rK+NHhK2VKPN/c/LmH6TS4O659DGp8FLC9T5wo+9JN4zXjeclhqG4Vw5GmbWeTnI3WVFxpZMv8sPyrJVNdLBmi6bh9f7CJXEHB50IvOOxxceF2/+PpSRxFoN8rJit6I2UTJTRDiYkKztvpOYNypO9zviiBBJEPbCPsX+l0SZUtacdHBpAHcJ4DgxRC8DgQWVrkU3WsqYXNb8+khf/V+MIpLLbclAWuhwDY0NVs+3kGT9Y1D/IP7NWnL4qxH/PsKxJKRVgUkDeV8JZzMJAiA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199021)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(41300700001)(316002)(54906003)(122000001)(82950400001)(82960400001)(4326008)(110136005)(921005)(83380400001)(38100700002)(10290500003)(478600001)(8936002)(8676002)(7416002)(26005)(55016003)(38070700005)(8990500004)(52536014)(5660300002)(186003)(7696005)(53546011)(71200400001)(86362001)(6506007)(9686003)(2906002)(33656002)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vi9XVzJ5S3p0TUxLYWN2bVQySkNTNmM4SFY4YVE4SXlkNGlsS0g2RXNZMkZq?=
 =?utf-8?B?UmdrbS8vbDN2RzQvVmpoem5keUFESngwMFpWbDJyK1FjZUlWdnE3cTZNZUxU?=
 =?utf-8?B?S0JCb3oxVitadWk1bDFxTkVtSnNad2hucFJndHh5RTY0bDNjK0ZmQ2xMT2hE?=
 =?utf-8?B?cmJwMnZYdktqYW1sOTJnMXNQalp5R1lGd0hRN0hoU3gxYmhRTXdzK0JhUGJ5?=
 =?utf-8?B?YllEYWd6MHVPdkVjaHpjdTc4cnRBNEJhSnoyY0FRakF5R2NEK1RzZmV0Q2Jr?=
 =?utf-8?B?Z3hvOGRpd3ZtZGJkNURKNkx4aWlIV0tmOVZFSkZJSDJpQmhtVlVNTUkyMTFu?=
 =?utf-8?B?TGVjN0NEVG5Za0ltZnBXakt5bXBjdm5Sd3ZUaUF4L20yYW9GY1ltR3ptUU1y?=
 =?utf-8?B?ZEROREFmOUpJTmVVSytXRWpwWSs4SFBrTTEwWU1XYWtPR05LbHNKSWNiVkFO?=
 =?utf-8?B?UG00TVBZSldBakMzMlhPeVdUSWFnMXRJbE10MlJ3c09IbzcwSnpLUHQyNFk0?=
 =?utf-8?B?Z09pQTR4bkVkLzVYSGlkdXZ2c3lJSWhSVEZqYjlKRnpCRzZiYUlVSDdNZDJE?=
 =?utf-8?B?TnNKOG1sR04vVmNoOFR2UVBhSVNCbVlFejVwREdyVGo4TEw1Zk5laXdZU1JE?=
 =?utf-8?B?WVZGSE1KV3JuTmxEajk4c1NvTlFpN0hOZzY4eUtWeHNGN2QrNzFVamVSOWxp?=
 =?utf-8?B?Q3UwZU5QWlNSb0RtVGdySVpSaDc3dURXRTlCcHZzS0c4TWxrQm9Bd1hVV25r?=
 =?utf-8?B?cGo2VkJGV0hoeFdrTU5pVVR6QVh0RlA0TC85dnJ0cWJBWEpoTkYvOXVNYW16?=
 =?utf-8?B?aVY3UUF6VXdlWXVVL3FQNXVUdkptZEltOE5jREZ1NDNsVTRPYU1rU0ZST3Iz?=
 =?utf-8?B?TVF5dmFJb2dHOUlsWnFLZWEvUjJVOENocjgvWHBoeDFicVRNYVMzQzJtb1N2?=
 =?utf-8?B?K2dSRU9pZk1uaTYxOE80NVZHM3M4bkM4R1lFRDJWY1d6T0s1WUQyU0xZdXZD?=
 =?utf-8?B?SUd5bThpeHI2Y1FKOEhlMjJEUmRoMG05RFRuRVpxZytsWFpXNFpreXp4WEhz?=
 =?utf-8?B?Z2VUcndQeDNCUldQZldONmpDUHlsVFJpQ3FIa2hVZUp4bXlVd3N0TmVKT0tD?=
 =?utf-8?B?a0FadWhsblY5YkExOWFkQS82YnR0a0wvMmo0ei91MExaWHJxeEhoQm9YaFJ2?=
 =?utf-8?B?QWZMZk9uV3FjQWVFUlI1SjBlUCszL0I2N2wvU2Vuc2RkSnVZaDdGZWlraGww?=
 =?utf-8?B?dk11MVE0eTh3M2V1OWJwZmxqcjQxbVRUbVlxMjVXOGpnajFUN3BsNUhOQUtt?=
 =?utf-8?B?SytkQ29BWkdzWGhlNTF3OFFsaEUrWjkxdkNRK2Z6SXZEblBnVFhYUzczNDBF?=
 =?utf-8?B?NUtoc05Pbm5mTkpHYzhabitVVytKclduSndxTFQxUG8yRXIvQjRqNkVRVzVj?=
 =?utf-8?B?UFhwRGh3Wmhqc2ZqdjdRb1dWbE8xYXNIZnFha3Z6dlpKYWJPeEczWFJkVXhE?=
 =?utf-8?B?SEd6RTh2dzlBVnQ4VUE5SlQ2a3VVU3RpYUZtN2VuMVZqNjFJRWo3a0crejIx?=
 =?utf-8?B?WWdmdGNvM09IcmIzUWR1VngrVDdpdGFHUGtZeFMzT3pEMmc4VGdycHQ3N3o3?=
 =?utf-8?B?dE01RExKQVovUlBsZCtDNzNIMWNEc0hCMzhlQWgwdGU3Vk1OcGhCUGFtUHJZ?=
 =?utf-8?B?bFhndW9PQXhyZXZFMU4wQk9IOW9EK3hMczljMFVwQ1FVNGIzUXpRNHFZRlZX?=
 =?utf-8?B?ZmxBN2lOcndRZi9scFBVbEZyVmdMVERFQ1BvWVZ3aXgwcVRXbmQ1bkRFOWtm?=
 =?utf-8?B?QS9ydXJEZmMzNTc3MUYzb1ZlVGRMK1hkeHdGK05pUzVwVWpiVkxDVWxpbTdt?=
 =?utf-8?B?ZXU3aDNna2VxYlRpTndIV3JUMWxpMUFjbjRQb0dReS8vVDVwU3hrZmdXM3NO?=
 =?utf-8?B?UmpZaTR0MThIL05Ydit4RkNRRkQ5ZWxMaFVzek5IN1ZuQW5GNmFLQUl3L2cv?=
 =?utf-8?B?U1Evai96Qm15WTdTK25DbFd3ZG5GV3JKWU41OVpQY0xVdC95N2NSa1ZFZ2tR?=
 =?utf-8?B?TU0xY3pqS1A1WTQ2aFRMQWZILzNNSFZ6K3NtUng3MThGdnNRbVl3ZVI2bFNX?=
 =?utf-8?Q?o8xoeuUUuuYRUTkHVjpYxNq+W?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3116.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb12598-1e27-4b24-cefe-08db78c16537
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 16:53:42.4762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cXbd6hR7swdqGakoZXyeB+fVDqludc6qv885gvbXk35fZNDNkMBN8KW9KycD+YOvSIK/kwPcg4J2o1/bhKTNVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1294
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQWJlbmkgPHBh
YmVuaUByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSAyOSwgMjAyMyA0OjQzIEFN
DQo+IFRvOiBsb25nbGlAbGludXhvbmh5cGVydi5jb207IEphc29uIEd1bnRob3JwZSA8amdnQHpp
ZXBlLmNhPjsgTGVvbg0KPiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+OyBBamF5IFNoYXJt
YSA8c2hhcm1hYWpheUBtaWNyb3NvZnQuY29tPjsNCj4gRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9z
b2Z0LmNvbT47IEtZIFNyaW5pdmFzYW4gPGt5c0BtaWNyb3NvZnQuY29tPjsNCj4gSGFpeWFuZyBa
aGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT47IFdlaSBMaXUgPHdlaS5saXVAa2VybmVsLm9y
Zz47DQo+IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpl
dA0KPiA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5v
cmc+DQo+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsgbGludXgtaHlwZXJ2QHZnZXIu
a2VybmVsLm9yZzsNCj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgTG9uZyBMaQ0KPiA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+OyBzdGFibGVAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUGF0Y2ggdjNdIG5ldDogbWFuYTogQmF0Y2gg
cmluZ2luZyBSWCBxdWV1ZSBkb29yYmVsbCBvbiByZWNlaXZpbmcNCj4gcGFja2V0cw0KPiANCj4g
T24gTW9uLCAyMDIzLTA2LTI2IGF0IDE2OjU3IC0wNzAwLCBsb25nbGlAbGludXhvbmh5cGVydi5j
b20gd3JvdGU6DQo+ID4gRnJvbTogTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+DQo+ID4N
Cj4gPiBJdCdzIGluZWZmaWNpZW50IHRvIHJpbmcgdGhlIGRvb3JiZWxsIHBhZ2UgZXZlcnkgdGlt
ZSBhIFdRRSBpcyBwb3N0ZWQgdG8NCj4gPiB0aGUgcmVjZWl2ZWQgcXVldWUuIEV4Y2Vzc2l2ZSBN
TUlPIHdyaXRlcyByZXN1bHQgaW4gQ1BVIHNwZW5kaW5nIG1vcmUNCj4gPiB0aW1lIHdhaXRpbmcg
b24gTE9DSyBpbnN0cnVjdGlvbnMgKGF0b21pYyBvcGVyYXRpb25zKSwgcmVzdWx0aW5nIGluDQo+
ID4gcG9vciBzY2FsaW5nIHBlcmZvcm1hbmNlLg0KPiA+DQo+ID4gTW92ZSB0aGUgY29kZSBmb3Ig
cmluZ2luZyBkb29yYmVsbCBwYWdlIHRvIHdoZXJlIGFmdGVyIHdlIGhhdmUgcG9zdGVkIGFsbA0K
PiA+IFdRRXMgdG8gdGhlIHJlY2VpdmUgcXVldWUgZHVyaW5nIGEgY2FsbGJhY2sgZnJvbSBuYXBp
X3BvbGwoKS4NCj4gPg0KPiA+IFdpdGggdGhpcyBjaGFuZ2UsIHRlc3RzIHNob3dlZCBhbiBpbXBy
b3ZlbWVudCBmcm9tIDEyMEcvcyB0byAxNjBHL3Mgb24gYQ0KPiA+IDIwMEcgcGh5c2ljYWwgbGlu
aywgd2l0aCAxNiBvciAzMiBoYXJkd2FyZSBxdWV1ZXMuDQo+ID4NCj4gPiBUZXN0cyBzaG93ZWQg
bm8gcmVncmVzc2lvbiBpbiBuZXR3b3JrIGxhdGVuY3kgYmVuY2htYXJrcyBvbiBzaW5nbGUNCj4g
PiBjb25uZWN0aW9uLg0KPiA+DQo+ID4gV2hpbGUgd2UgYXJlIG1ha2luZyBjaGFuZ2VzIGluIHRo
aXMgY29kZSBwYXRoLCBjaGFuZ2UgdGhlIGNvZGUgZm9yDQo+ID4gcmluZ2luZyBkb29yYmVsbCB0
byBzZXQgdGhlIFdRRV9DT1VOVCB0byAwIGZvciBSZWNlaXZlIFF1ZXVlLiBUaGUNCj4gPiBoYXJk
d2FyZSBzcGVjaWZpY2F0aW9uIHNwZWNpZmllcyB0aGF0IGl0IHNob3VsZCBzZXQgdG8gMC4gQWx0
aG91Z2gNCj4gPiBjdXJyZW50bHkgdGhlIGhhcmR3YXJlIGRvZXNuJ3QgZW5mb3JjZSB0aGUgY2hl
Y2ssIGluIHRoZSBmdXR1cmUgcmVsZWFzZXMNCj4gPiBpdCBtYXkgZG8uDQo+ID4NCj4gPiBDYzog
c3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+IEZpeGVzOiBjYTljNTRkMmQ2YTUgKCJuZXQ6IG1h
bmE6IEFkZCBhIGRyaXZlciBmb3IgTWljcm9zb2Z0IEF6dXJlIE5ldHdvcmsNCj4gQWRhcHRlciAo
TUFOQSkiKQ0KPiANCj4gVWhtbW0uLi4gdGhpcyBsb29rcyBsaWtlIGEgcGVyZm9ybWFuY2UgaW1w
cm92ZW1lbnQgdG8gbWUsIG1vcmUgc3VpdGFibGUNCj4gZm9yIHRoZSBuZXQtbmV4dCB0cmVlID8h
PyAoTm90ZSB0aGF0IG5ldC1uZXh0IGlzIGNsb3NlZCBub3cpLg0KDQpUaGlzIHdlYiBwYWdlIHNo
b3dzIHRoZSBuZXQtbmV4dCBpcyAib3BlbiI6DQpodHRwOi8vdmdlci5rZXJuZWwub3JnL35kYXZl
bS9uZXQtbmV4dC5odG1sDQoNCklzIHRoaXMgc3RpbGwgdGhlIHJpZ2h0IHBsYWNlIHRvIGNoZWNr
IG5ldC1uZXh0IHN0YXR1cz8NCg0KLSBIYWl5YW5nDQo=
