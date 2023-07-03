Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFDD74638F
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Jul 2023 21:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjGCTzQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 Jul 2023 15:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjGCTzP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 Jul 2023 15:55:15 -0400
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazon11020026.outbound.protection.outlook.com [52.101.128.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54CCE69;
        Mon,  3 Jul 2023 12:55:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUuJQg9Nbc5/jknjQd470k0cDhNMepqeLRCAEgRqaheNHzbg/b4Yo34aAutnN9XLwekIwGntCv/RfBKoY0Ki8LV2LueC8TjU3smm7zDa0LC3wIkRdtCkIpPvo9++gfvs5RGQxUqO32Qlqe6Oh4LgjFPdVHqSyM+PkVXeCO8oyUjMEU1F0/q85wPY54Y5zmVPdmwF4naE8ZUUXEtrMIMMa/k1B5fexH0pgCj9Y+oAbdmaEEsDPz1uHFYAc8N9eFUs+duVM/zPDyx7591S66Dbfk1tJvzOTDTswom+Mk+ob40mpOPSOIghs/2GPJmSkD7eCpVRTRy4QfRhbzPaZ+vHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7D9zEuAdOmRF5RlG8ZtVrMzLT5qUvWuIWWX0RNVtduo=;
 b=ETcx6f4Q1TiEUwrWC5KWFM9Ss7pOSd8aek+TzPGh8L8hcfNDs37Vliild1pytn8bTZb0gWtqpTS28is/2v1yqgliX52hHYUMyUl7E8lMB/NH+JIDLq8D7F4Sm8oYMjKgifYpnJXVL/j0qjKduaYcj4afOUmSea/w1BC8GVF3BU8huVzUk3Aq2pE0zTdPL6VRY7HFUdwEsInLPMPrpVtQj2nLARhpUw4bcLfIdStvnBhwbQjpTUFD0pDsXfHgLGFCI4Cy/pHaW3OSGQkD+1dWeFA/reBCdwPcFRwfXZP4vjG48lEqExVbWXqtWf6KDEfUqHatdHQbjlzHUjmNlxF8EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7D9zEuAdOmRF5RlG8ZtVrMzLT5qUvWuIWWX0RNVtduo=;
 b=AvJNS1X5c13wabhGNkQxjyR6ov4uMnuBcXE2IvXnECtR/4mZ5B8eY1LtSbjE1Wch4htkKzZQYnak7lyDxjCIb+WN5cb8+hX9ojf3+btrBUuLZI0UGDBVdk9hcrhYZje2tOsyuofW0cv6NBR8XuMjI7P6KYedP6l3D77VozOSOK8=
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM (2603:1096:301:fc::10)
 by SG2P153MB0379.APCP153.PROD.OUTLOOK.COM (2603:1096:0:7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.5; Mon, 3 Jul 2023 19:55:07 +0000
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::d752:54e0:7b75:4dc7]) by PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::d752:54e0:7b75:4dc7%6]) with mapi id 15.20.6588.001; Mon, 3 Jul 2023
 19:55:07 +0000
From:   Souradeep Chakrabarti <schakrabarti@microsoft.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        souradeep chakrabarti <schakrabarti@linux.microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Long Li <longli@microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH V4 net] net: mana: Fix MANA VF unload when
 host is unresponsive
Thread-Topic: [EXTERNAL] Re: [PATCH V4 net] net: mana: Fix MANA VF unload when
 host is unresponsive
Thread-Index: AQHZrYtPYuWMOmYHY0O7H4YU8qW43q+oQRyAgAAkWPA=
Date:   Mon, 3 Jul 2023 19:55:06 +0000
Message-ID: <PUZP153MB07880E6D692FD5D13C508694CC29A@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
References: <1688374171-10534-1-git-send-email-schakrabarti@linux.microsoft.com>
 <83ef6401-8736-8416-c898-2fbbb786726e@intel.com>
In-Reply-To: <83ef6401-8736-8416-c898-2fbbb786726e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1885f393-fb46-4093-8110-a76ca554c530;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-03T18:57:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0788:EE_|SG2P153MB0379:EE_
x-ms-office365-filtering-correlation-id: 99d5789a-52c8-40a8-51b8-08db7bff6665
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xz3Ly1SvdgZV/pASulSo87BtVLoQdFnsaltmhq8vG7mGNck+Sm0h0qC3y3BaPcxBN1f7StVHo7bH4ylwS/89Wog2VE4AtV50LMFSoWZcp/POOyZEHUV2yobCSYBaTnJZ2B+Tc8D4wCmfdbF1KNbOwvijY7Jyk0j7JIjoH2ZtnYfW8DKTz1vVli0R0pjZz1t0SdlBiaxpmV+0Ivw4KBUPTqmkCgRGavLjiDxMUUu/Ma8CsVwR2sHBqgwIN5/cEwFe/x1QD0LXOLmaeepm+Fcj4q3zDKqLwIQWeTrSDrSJULakXZ0q5eAGJQHx/UvbS0ASLUigfzUBhROqTI9m+PeSW9YtmDIGZWYxp7DfXTNf2LILBGfkj2oxD6rVt5y9pmbG4UHn3YpzQpHrkZi6uEcveV9dgE8nxfPZGIGcEiy6y1/oehIUBcTEyypWt0J0XzNA0dOjM6TrYFixA5RY5tK5FZwgJLGvTm1ade7j5sffgga+RxN/MJTxqJBAPVQVaLTQG06dezEde069PF5ZQcIYyZQUFc87cNVNuLCEKocHsCJn3lGNmdyVhCV46bMxFaFPTQ91d7SpHXVE7DMkZJ+mdWMHPpWmpBMwafc07AnIsc2HBjW/U+rXqchgHDajP4iDg5W2PjT12KMbGwtO7fbRvbBR9SE/Y/DW22TBhWMdVmA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0788.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(41300700001)(7696005)(38100700002)(82950400001)(82960400001)(122000001)(83380400001)(6506007)(26005)(186003)(71200400001)(9686003)(55016003)(38070700005)(110136005)(54906003)(8990500004)(86362001)(478600001)(10290500003)(316002)(2906002)(66446008)(64756008)(76116006)(4326008)(33656002)(66556008)(66476007)(66946007)(52536014)(5660300002)(8676002)(8936002)(7416002)(66899021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUMxdkJDalJROWNabmJhUDZpZXdsVDVtZTFzT25LNmdiZFBGeitrYU1BSjZt?=
 =?utf-8?B?OVh5RGJSTzFsVXJRMTAwTncrbDY5R2VRUWVVV1pLTDhXUTVhUkhHZHE2RWRF?=
 =?utf-8?B?NTlmZFM4Z3U4ak9xeExEMTM0Z2Z5NW5Fb0ZNUzlRUnZJb0lKWTRCdmpDTWxr?=
 =?utf-8?B?Q1BOR0VqSnk1Z21PeHJ2M09jbFhZb0I2bGlWV3JnOU5uS2FlTDVxb2RDUFQ4?=
 =?utf-8?B?YXhZR3FjcUlGMVNJNUhRei9qOTZvb2laaitlbTJQQm9zbUU5Nlc5WDNVNTdo?=
 =?utf-8?B?Yk9WRlVpS2c2R1NabXRNVEo2N1FxM1BSYm1OemlWcVBGbGI1eHhLT0J4WGJi?=
 =?utf-8?B?K2lWTE9BYjhUN3VucXB2Wi82UTM4ejA2S1IySTNRTzhWV2VIL0JwZlVSWjls?=
 =?utf-8?B?YjFlcTJGWGhPeEo3ZHkwTzRCYWw1UmlGWlZKSkFxempYM29uK3NNSnJZbzY2?=
 =?utf-8?B?azdVMzNKdGZvZEdLYUZ0SEJOVXkrNUg0RjZLYUFUTmxUa0lCQWFzUFRkaW9t?=
 =?utf-8?B?ZWNJbkRIYklhQU12MEJrU2c2N1h4bGNPVWVSZ1hjR3hFckk0Y3dBcG00N2Rl?=
 =?utf-8?B?WWtVbzF3SDAzWEVwWDBuRkNzUkU3cDRiNVk3TFJFQUlQYnI4Sk1vanVSQlRE?=
 =?utf-8?B?ZTQ2WXZ6VllvcjZWcTNFYnp4dzFCb0kzL2crNDE5eU1qb2JvbngycTZEbUc1?=
 =?utf-8?B?UWx6bnFiWC9vQUl3bk0vWExVT3NVOW9wSHBHQWJ2N0NGbFRtOEVMazR0c2NE?=
 =?utf-8?B?ekVKaG9SbHpLR3NnaVkvTUh0YzdOVVB5Ym9oOHBqTkFnUERaRmVlOFhqSmI4?=
 =?utf-8?B?V2ZScUdLVHdSUGlERUJzTXdiZmI0b1ZIdklQVXoveEFRWGFjbWhBb283RW9I?=
 =?utf-8?B?c1JpeENER0tnSmtabjFBN09FcEtCa0hSQ1k2WmxoZkZpY3Q5NUsyMncxbkRw?=
 =?utf-8?B?ZHFiZDRMSjlNTDJsZUNKRFhiemtvMnZSUUViWnFvYnhIMjdtVDdMMHVhMlJZ?=
 =?utf-8?B?TmJ5RVk1NmJUSC9ZOHI2T21kaHhhZnFCY1orTUQvRzZ3SWlFZzd0aHZrVVl5?=
 =?utf-8?B?UGhjOVJuN2p3WTJhaDB5ZkllRWE2ODFTajJEaHkvNC9lci9rMHBkUC83REMw?=
 =?utf-8?B?WVBLUEJkS2JmQ2F1OVpWcnlrdmlzNnQ4akV6K1BMQnNRenZsbDg3bUh2aFY2?=
 =?utf-8?B?eUk2bnUxM244NkpYQ0dpN2Fkc3dpeUxuZVFkRlg2TjhNVG5zN1JXTFFqUmJV?=
 =?utf-8?B?bWJzSHFCeWwrOUlhQXl4VXIvc1ZldEp1M2hNdVlBeXIySkJVdFJDREp0cDA4?=
 =?utf-8?B?Ky9pSkRKanA4bllNTlJlZDFUbXRoaTQwV0o3OExGdzIydXJ0ZC9CaUExS3Zw?=
 =?utf-8?B?R1dkblJ1OEdSM2kwbHlDNVEvQTk2OGYzWDNyaERHN3daT0ZudkhDL2w4dTlr?=
 =?utf-8?B?LzFFK3V2RVZodDhDUklZN3A1TUZxL29tU09uOXZNcDM0TVBFM0R2K0NlL1hL?=
 =?utf-8?B?ZTNMYXZLUU4vNkc0d1N0S3E1TUVEL1JjQXl6ZUtqRWdHR1JzUFVENkl5b2pB?=
 =?utf-8?B?YzF2STBZbm40QmI4Wnl1WUJwbTZHaktMVUs3NXA2RVVHQy93Zm5NcHU5NGhD?=
 =?utf-8?B?bmpReEc5V1UyTDA0bXZpeHRQTTlLNFkxdXVHWVhPZkg5SmR2SE1ETm1jS3VG?=
 =?utf-8?B?N3VZRlFxUnJHNXEzNUpsSWJwdFBDV3BROHc5b24wWVJCSzcxd2Y2QUhrKzBQ?=
 =?utf-8?B?SFRZZGVocllvZUhQUFVZVHJqVEs5cFZrK3djdmtSN2UvSXlVQU42TlY3aXk2?=
 =?utf-8?B?S0hBbTR0WHdrREo3Q3ZTMWs5ajZHQ2JtNCtib2plVGRiYnB4SGhEZ3h2VlJx?=
 =?utf-8?B?bXB5a1h0YUgyZUQrT2c4ZldjN3NULzZtM1ZlWHFodjM3d0VtTjBNL1NHRjB0?=
 =?utf-8?B?WE5sbGlmRExzb2dJTFJ3aHRIUmtzdG5iMkRLWm1kWE1FMDBTSENtd2pmMUFT?=
 =?utf-8?B?aUdnb2pESitaazBlNGEyV2Q2MnlWenVsQzNhK0pGNUFDOXd2U2hvR09XQ0hn?=
 =?utf-8?Q?VfvkZ+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d5789a-52c8-40a8-51b8-08db7bff6665
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 19:55:06.7438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mXOnyIbVHjI9fTKEbXyVfCwDZXDh7qZUPxH0h4GQ/3IZWkjtMZnMnLTB2yKw7/272oW5Walv7sMmULnRO93CEJL4Isn4NCNHrp+Jty6226M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P153MB0379
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEFsZXhhbmRlciBMb2Jha2lu
IDxhbGVrc2FuZGVyLmxvYmFraW5AaW50ZWwuY29tPg0KPlNlbnQ6IE1vbmRheSwgSnVseSAzLCAy
MDIzIDEwOjE4IFBNDQo+VG86IHNvdXJhZGVlcCBjaGFrcmFiYXJ0aSA8c2NoYWtyYWJhcnRpQGxp
bnV4Lm1pY3Jvc29mdC5jb20+DQo+Q2M6IEtZIFNyaW5pdmFzYW4gPGt5c0BtaWNyb3NvZnQuY29t
PjsgSGFpeWFuZyBaaGFuZw0KPjxoYWl5YW5nekBtaWNyb3NvZnQuY29tPjsgd2VpLmxpdUBrZXJu
ZWwub3JnOyBEZXh1YW4gQ3VpDQo+PGRlY3VpQG1pY3Jvc29mdC5jb20+OyBkYXZlbUBkYXZlbWxv
ZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOw0KPmt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJl
ZGhhdC5jb207IExvbmcgTGkgPGxvbmdsaUBtaWNyb3NvZnQuY29tPjsgQWpheQ0KPlNoYXJtYSA8
c2hhcm1hYWpheUBtaWNyb3NvZnQuY29tPjsgbGVvbkBrZXJuZWwub3JnOw0KPmNhaS5odW9xaW5n
QGxpbnV4LmRldjsgc3NlbmdhckBsaW51eC5taWNyb3NvZnQuY29tOyB2a3V6bmV0c0ByZWRoYXQu
Y29tOw0KPnRnbHhAbGludXRyb25peC5kZTsgbGludXgtaHlwZXJ2QHZnZXIua2VybmVsLm9yZzsg
bmV0ZGV2QHZnZXIua2VybmVsLm9yZzsNCj5saW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsNCj5zdGFibGVAdmdlci5rZXJuZWwub3JnOyBTb3Vy
YWRlZXAgQ2hha3JhYmFydGkgPHNjaGFrcmFiYXJ0aUBtaWNyb3NvZnQuY29tPg0KPlN1YmplY3Q6
IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCBWNCBuZXRdIG5ldDogbWFuYTogRml4IE1BTkEgVkYgdW5s
b2FkIHdoZW4NCj5ob3N0IGlzIHVucmVzcG9uc2l2ZQ0KPg0KPkZyb206IFNvdXJhZGVlcCBDaGFr
cmFiYXJ0aSA8c2NoYWtyYWJhcnRpQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+RGF0ZTogTW9uLCAg
MyBKdWwgMjAyMyAwMTo0OTozMSAtMDcwMA0KPg0KPj4gRnJvbTogU291cmFkZWVwIENoYWtyYWJh
cnRpIDxzY2hha3JhYmFydGlAbGludXgubWljcm9zb2Z0LmNvbT4NCj4NCj5QbGVhc2Ugc3luYyB5
b3VyIEdpdCBuYW1lIGFuZCBHaXQgbWFpbCBhY2NvdW50IHNldHRpbmdzLCBzbyB0aGF0IHlvdXIg
b3duDQo+cGF0Y2hlcyB3b24ndCBoYXZlICJGcm9tOiIgd2hlbiBzZW5kaW5nLiBGcm9tIHdoYXQg
SSBzZWUsIHlvdSBuZWVkIHRvDQo+Y29ycmVjdCBmaXJzdCBsZXR0ZXJzIG9mIG5hbWUgYW5kIHN1
cm5hbWUgdG8gY2FwaXRhbCBpbiB0aGUgR2l0IGVtYWlsIHNldHRpbmdzDQo+YmxvY2suDQpUaGFu
ayB5b3UgZm9yIHBvaW50aW5nLCBJIHdpbGwgZml4IGl0Lg0KPg0KPj4NCj4+IFdoZW4gdW5sb2Fk
aW5nIHRoZSBNQU5BIGRyaXZlciwgbWFuYV9kZWFsbG9jX3F1ZXVlcygpIHdhaXRzIGZvciB0aGUN
Cj4+IE1BTkEgaGFyZHdhcmUgdG8gY29tcGxldGUgYW55IGluZmxpZ2h0IHBhY2tldHMgYW5kIHNl
dCB0aGUgcGVuZGluZw0KPj4gc2VuZCBjb3VudCB0byB6ZXJvLiBCdXQgaWYgdGhlIGhhcmR3YXJl
IGhhcyBmYWlsZWQsDQo+PiBtYW5hX2RlYWxsb2NfcXVldWVzKCkgY291bGQgd2FpdCBmb3JldmVy
Lg0KPj4NCj4+IEZpeCB0aGlzIGJ5IGFkZGluZyBhIHRpbWVvdXQgdG8gdGhlIHdhaXQuIFNldCB0
aGUgdGltZW91dCB0byAxMjANCj4+IHNlY29uZHMsIHdoaWNoIGlzIGEgc29tZXdoYXQgYXJiaXRy
YXJ5IHZhbHVlIHRoYXQgaXMgbW9yZSB0aGFuIGxvbmcNCj4+IGVub3VnaCBmb3IgZnVuY3Rpb25h
bCBoYXJkd2FyZSB0byBjb21wbGV0ZSBhbnkgc2VuZHMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
U291cmFkZWVwIENoYWtyYWJhcnRpDQo+PiA8c2NoYWtyYWJhcnRpQGxpbnV4Lm1pY3Jvc29mdC5j
b20+DQo+DQo+V2hlcmUncyAiRml4ZXM6IiB0YWdnaW5nIHRoZSBibGFtZWQgY29tbWl0Pw0KVGhp
cyBpcyBwcmVzZW50IGZyb20gdGhlIGRheSB6ZXJvIG9mIHRoZSBtYW5hIGRyaXZlciBjb2RlLg0K
SXQgaGFzIG5vdCBiZWVuIGludHJvZHVjZWQgaW4gdGhlIGNvZGUgYnkgYW55IGNvbW1pdC4NCj4N
Cj4+IC0tLQ0KPj4gVjMgLT4gVjQ6DQo+PiAqIEZpeGVkIHRoZSBjb21taXQgbWVzc2FnZSB0byBk
ZXNjcmliZSB0aGUgY29udGV4dC4NCj4+ICogUmVtb3ZlZCB0aGUgdmZfdW5sb2FkX3RpbWVvdXQs
IGFzIGl0IGlzIG5vdCByZXF1aXJlZC4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0
L21pY3Jvc29mdC9tYW5hL21hbmFfZW4uYyB8IDI2DQo+PiArKysrKysrKysrKysrKysrLS0tDQo+
PiAgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21pY3Jvc29mdC9tYW5hL21hbmFf
ZW4uYw0KPj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb3NvZnQvbWFuYS9tYW5hX2VuLmMN
Cj4+IGluZGV4IGE0OTllNDYwNTk0Yi4uZDI2ZjFkYTcwNDExIDEwMDY0NA0KPj4gLS0tIGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvbWljcm9zb2Z0L21hbmEvbWFuYV9lbi5jDQo+PiArKysgYi9kcml2
ZXJzL25ldC9ldGhlcm5ldC9taWNyb3NvZnQvbWFuYS9tYW5hX2VuLmMNCj4+IEBAIC0yMzQ2LDcg
KzIzNDYsMTAgQEAgc3RhdGljIGludCBtYW5hX2RlYWxsb2NfcXVldWVzKHN0cnVjdA0KPj4gbmV0
X2RldmljZSAqbmRldikgIHsNCj4+ICAJc3RydWN0IG1hbmFfcG9ydF9jb250ZXh0ICphcGMgPSBu
ZXRkZXZfcHJpdihuZGV2KTsNCj4+ICAJc3RydWN0IGdkbWFfZGV2ICpnZCA9IGFwYy0+YWMtPmdk
bWFfZGV2Ow0KPj4gKwl1bnNpZ25lZCBsb25nIHRpbWVvdXQ7DQo+PiAgCXN0cnVjdCBtYW5hX3R4
cSAqdHhxOw0KPj4gKwlzdHJ1Y3Qgc2tfYnVmZiAqc2tiOw0KPj4gKwlzdHJ1Y3QgbWFuYV9jcSAq
Y3E7DQo+PiAgCWludCBpLCBlcnI7DQo+Pg0KPj4gIAlpZiAoYXBjLT5wb3J0X2lzX3VwKQ0KPj4g
QEAgLTIzNjMsMTUgKzIzNjYsMzIgQEAgc3RhdGljIGludCBtYW5hX2RlYWxsb2NfcXVldWVzKHN0
cnVjdA0KPm5ldF9kZXZpY2UgKm5kZXYpDQo+PiAgCSAqIHRvIGZhbHNlLCBidXQgaXQgZG9lc24n
dCBtYXR0ZXIgc2luY2UgbWFuYV9zdGFydF94bWl0KCkgZHJvcHMgYW55DQo+PiAgCSAqIG5ldyBw
YWNrZXRzIGR1ZSB0byBhcGMtPnBvcnRfaXNfdXAgYmVpbmcgZmFsc2UuDQo+PiAgCSAqDQo+PiAt
CSAqIERyYWluIGFsbCB0aGUgaW4tZmxpZ2h0IFRYIHBhY2tldHMNCj4+ICsJICogRHJhaW4gYWxs
IHRoZSBpbi1mbGlnaHQgVFggcGFja2V0cy4NCj4+ICsJICogQSB0aW1lb3V0IG9mIDEyMCBzZWNv
bmRzIGZvciBhbGwgdGhlIHF1ZXVlcyBpcyB1c2VkLg0KPj4gKwkgKiBUaGlzIHdpbGwgYnJlYWsg
dGhlIHdoaWxlIGxvb3Agd2hlbiBoL3cgaXMgbm90IHJlc3BvbmRpbmcuDQo+PiArCSAqIFRoaXMg
dmFsdWUgb2YgMTIwIGhhcyBiZWVuIGRlY2lkZWQgaGVyZSBjb25zaWRlcmluZyBtYXgNCj4+ICsJ
ICogbnVtYmVyIG9mIHF1ZXVlcy4NCj4+ICAJICovDQo+PiArDQo+PiArCXRpbWVvdXQgPSBqaWZm
aWVzICsgMTIwICogSFo7DQo+DQo+V2h5IG5vdCBpbml0aWFsaXplIGl0IHJpZ2h0IHdoZW4gZGVj
bGFyaW5nPw0KSSB3aWxsIGZpeCBpdCBpbiBuZXh0IHZlcnNpb24uDQo+DQo+PiAgCWZvciAoaSA9
IDA7IGkgPCBhcGMtPm51bV9xdWV1ZXM7IGkrKykgew0KPj4gIAkJdHhxID0gJmFwYy0+dHhfcXBb
aV0udHhxOw0KPj4gLQ0KPj4gLQkJd2hpbGUgKGF0b21pY19yZWFkKCZ0eHEtPnBlbmRpbmdfc2Vu
ZHMpID4gMCkNCj4+ICsJCXdoaWxlIChhdG9taWNfcmVhZCgmdHhxLT5wZW5kaW5nX3NlbmRzKSA+
IDAgJiYNCj4+ICsJCSAgICAgICB0aW1lX2JlZm9yZShqaWZmaWVzLCB0aW1lb3V0KSkgew0KPj4g
IAkJCXVzbGVlcF9yYW5nZSgxMDAwLCAyMDAwKTs+ICsJCX0NCj4+ICAJfQ0KPg0KPjEyMCBzZWNv
bmRzIGJ5IDIgbXNlYyBzdGVwIGlzIDYwMDAwIGl0ZXJhdGlvbnMsIGJ5IDEgbXNlYyBpcyAxMjAw
MDANCj5pdGVyYXRpb25zLiBJIGtub3cgdXNsZWVwX3JhbmdlKCkgb2Z0ZW4gaXMgbXVjaCBsZXNz
IHByZWNpc2UsIGJ1dCBzdGlsbC4NCj5EbyB5b3UgcmVhbGx5IG5lZWQgdGhhdCBtdWNoIHRpbWU/
IEhhcyB0aGlzIGJlZW4gbWVhc3VyZWQgZHVyaW5nIHRoZSB0ZXN0cw0KPnRoYXQgaXQgY2FuIHRh
a2UgdXAgdG8gMTIwIHNlY29uZHMgb3IgaXMgaXQganVzdCBzb21lIHJhbmRvbSB2YWx1ZSB0aGF0
ICJzaG91bGQNCj5iZSBlbm91Z2giPw0KPklmIHlvdSByZWFsbHkgbmVlZCAxMjAgc2Vjb25kcywg
SSdkIHN1Z2dlc3QgdXNpbmcgYSB0aW1lciAvIGRlbGF5ZWQgd29yayBpbnN0ZWFkDQo+b2Ygd2Fz
dGluZyByZXNvdXJjZXMuDQpIZXJlIHRoZSBpbnRlbnQgaXMgbm90IHdhaXRpbmcgZm9yIDEyMCBz
ZWNvbmRzLCByYXRoZXIgdGhhbiBhdm9pZCBjb250aW51ZSBjaGVja2luZyB0aGUgDQpwZW5kaW5n
X3NlbmRzICBvZiBlYWNoIHR4IHF1ZXVlcyBmb3IgYW4gaW5kZWZpbml0ZSB0aW1lLCBiZWZvcmUg
ZnJlZWluZyBza19idWZmcy4NClRoZSBwZW5kaW5nX3NlbmRzIGNhbiBvbmx5IGdldCBkZWNyZWFz
ZWQgZm9yIGEgdHggcXVldWUsICBpZiBtYW5hX3BvbGxfdHhfY3EoKQ0KZ2V0cyBjYWxsZWQgZm9y
IGEgY29tcGxldGlvbiBub3RpZmljYXRpb24gYW5kIGluY3JlYXNlZCBieSB4bWl0Lg0KDQpJbiB0
aGlzIHBhcnRpY3VsYXIgYnVnLCBhcGMtPnBvcnRfaXNfdXAgaXMgbm90IHNldCB0byBmYWxzZSwg
Y2F1c2luZw0KeG1pdCB0byBrZWVwIGluY3JlYXNpbmcgdGhlIHBlbmRpbmdfc2VuZHMgZm9yIHRo
ZSBxdWV1ZSBhbmQgbWFuYV9wb2xsX3R4X2NxKCkNCm5vdCBnZXR0aW5nIGNhbGxlZCBmb3IgdGhl
IHF1ZXVlLg0KDQpJZiB3ZSBzZWUgdGhlIGNvbW1lbnQgaW4gdGhlIGZ1bmN0aW9uIG1hbmFfZGVh
bGxvY19xdWV1ZXMoKSwgaXQgbWVudGlvbnMgaXQgOg0KDQoyMzQ2ICAgICAvKiBObyBwYWNrZXQg
Y2FuIGJlIHRyYW5zbWl0dGVkIG5vdyBzaW5jZSBhcGMtPnBvcnRfaXNfdXAgaXMgZmFsc2UuDQoy
MzQ3ICAgICAgKiBUaGVyZSBpcyBzdGlsbCBhIHRpbnkgY2hhbmNlIHRoYXQgbWFuYV9wb2xsX3R4
X2NxKCkgY2FuIHJlLWVuYWJsZQ0KMjM0OCAgICAgICogYSB0eHEgYmVjYXVzZSBpdCBtYXkgbm90
IHRpbWVseSBzZWUgYXBjLT5wb3J0X2lzX3VwIGJlaW5nIGNsZWFyZWQNCjIzNDkgICAgICAqIHRv
IGZhbHNlLCBidXQgaXQgZG9lc24ndCBtYXR0ZXIgc2luY2UgbWFuYV9zdGFydF94bWl0KCkgZHJv
cHMgYW55DQoyMzUwICAgICAgKiBuZXcgcGFja2V0cyBkdWUgdG8gYXBjLT5wb3J0X2lzX3VwIGJl
aW5nIGZhbHNlLg0KDQpUaGUgdmFsdWUgMTIwIHNlY29uZHMgaGFzIGJlZW4gZGVjaWRlZCBoZXJl
IGJhc2VkIG9uIG1heGltdW0gbnVtYmVyIG9mIHF1ZXVlcw0KYXJlIGFsbG93ZWQgaW4gdGhpcyBz
cGVjaWZpYyBoYXJkd2FyZSwgaXQgaXMgYSBzYWZlIGFzc3VtcHRpb24uDQo+DQo+Pg0KPj4gKwlm
b3IgKGkgPSAwOyBpIDwgYXBjLT5udW1fcXVldWVzOyBpKyspIHsNCj4+ICsJCXR4cSA9ICZhcGMt
PnR4X3FwW2ldLnR4cTsNCj4+ICsJCWNxID0gJmFwYy0+dHhfcXBbaV0udHhfY3E7DQo+DQo+Y3Eg
Y2FuIGJlIGp1c3QgJnR4cS0+dHhfY3EuDQptYW5hX3R4cSAgc3RydWN0dXJlIGRvZXMgbm90IGhh
dmUgYSBwb2ludGVyIHRvIG1hbmFfY3EuDQo+DQo+PiArCQl3aGlsZSAoYXRvbWljX3JlYWQoJnR4
cS0+cGVuZGluZ19zZW5kcykpIHsNCj4+ICsJCQlza2IgPSBza2JfZGVxdWV1ZSgmdHhxLT5wZW5k
aW5nX3NrYnMpOw0KPj4gKwkJCW1hbmFfdW5tYXBfc2tiKHNrYiwgYXBjKTsNCj4+ICsJCQluYXBp
X2NvbnN1bWVfc2tiKHNrYiwgY3EtPmJ1ZGdldCk7DQo+DQo+KHlvdSBhbHJlYWR5IGhhdmUgY29t
bWVudCBhYm91dCB0aGlzIG9uZSkNCj4NCj4+ICsJCQlhdG9taWNfc3ViKDEsICZ0eHEtPnBlbmRp
bmdfc2VuZHMpOw0KPj4gKwkJfQ0KPj4gKwl9DQo+PiAgCS8qIFdlJ3JlIDEwMCUgc3VyZSB0aGUg
cXVldWVzIGNhbiBubyBsb25nZXIgYmUgd29rZW4gdXAsIGJlY2F1c2UNCj4+ICAJICogd2UncmUg
c3VyZSBub3cgbWFuYV9wb2xsX3R4X2NxKCkgY2FuJ3QgYmUgcnVubmluZy4NCj4+ICAJICovDQo+
DQo+VGhhbmtzLA0KPk9sZWsNCg==
