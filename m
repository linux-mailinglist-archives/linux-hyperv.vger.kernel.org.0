Return-Path: <linux-hyperv+bounces-538-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C6C7CB667
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Oct 2023 00:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A5F28134F
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Oct 2023 22:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2703538F98;
	Mon, 16 Oct 2023 22:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="c6b3blgn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631FB381DC;
	Mon, 16 Oct 2023 22:15:23 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020002.outbound.protection.outlook.com [52.101.56.2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26E4A2;
	Mon, 16 Oct 2023 15:15:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LadLmPxpnatzF9kUQy9N+e4VFgGq1Du5lhEE+2qHoGTwvjdtRks6nd5oJgMghVjc5iBrvzddCqkzsBvOI0sy6YggDZDfvE300yI/4amDiss5oNm59T1t8DfLG7V3yhjSx0gKfAt2bQdryKuivvaAFwsytqb4YrXqAhUC74Hn9kEx1johHqCC3Wlxr/9v19Cwjlr9Am8zXNZtemtP7z6LkEOyE37w6USMPOs9i7urFoGsIi5Ez6A4itdEvo7tO9hNMVPO9RFUhmBsy3ZwTsraVMjGU8/L3cCU0dSf0LNsxA1rv8axWjjqMiQRRwSlyJGngDDA8OAVkTMSNZUn4mzV4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ip7n+95UzoDUnRcOjWrhe72PlcCv8H6YiBzonA8zdbc=;
 b=EFpBQbCoUK6zaWnGWK5MkrFOjEOd5kdQBFqaOp4YAADFgnZfbnmZrjcsDv8yLBG6YtTkA5lvLzPEqMcggWv7xKGvV7Ol19lwGLkVT0CTn3fxkTbYvQtBOAeXxIs+TMy1QaZcnR0cooFgUcoETDzzlaBxkrtEsZmuqAnxUb+qTLYeM3bGqHRV0Hd4DCt0KMMTa7rr5cxcMbr5lhvf0+Sbf82lQxg59vE7+Kcx5GKEPwtCbfHC9wvQ6jITZxlvXpjK/f9Zs5HBalA/znXxPyIxnYRSxkxLdhpShWwsfhRvKXcmkppuFOAZtuRRRBQF974CbiUnh2dlvjv4kDw2oROH/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ip7n+95UzoDUnRcOjWrhe72PlcCv8H6YiBzonA8zdbc=;
 b=c6b3blgnF/Kb8lPZk+FifGNzU6Otr1M8y+oE1GHuhpF1Sb+LaCV715nU/J1lJnU6+K9wLu/5xPEh80HA/tTr/rvTdO9JVfghnKSmRZ1XDmFKAARxYrKA+4kdonM9h+PyQnh25ViOyKqAVAg7/a+NmTAfNYD+jOd3n+iMiNHcL0g=
Received: from MN0PR21MB3606.namprd21.prod.outlook.com (2603:10b6:208:3d1::17)
 by MN0PR21MB3532.namprd21.prod.outlook.com (2603:10b6:208:3d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.3; Mon, 16 Oct
 2023 22:15:18 +0000
Received: from MN0PR21MB3606.namprd21.prod.outlook.com
 ([fe80::a2b3:122e:e242:3d3]) by MN0PR21MB3606.namprd21.prod.outlook.com
 ([fe80::a2b3:122e:e242:3d3%4]) with mapi id 15.20.6933.003; Mon, 16 Oct 2023
 22:15:18 +0000
From: Ajay Sharma <sharmaajay@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
CC: "sharmaajay@linuxonhyperv.com" <sharmaajay@linuxonhyperv.com>, Long Li
	<longli@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>, Dexuan Cui
	<decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ajay Sharma
	<sharmaajay@microsoft.com>
Subject: RE: [EXTERNAL] Re: [Patch v5 0/5] RDMA/mana_ib
Thread-Topic: [EXTERNAL] Re: [Patch v5 0/5] RDMA/mana_ib
Thread-Index: AQHZ5KwOjzbv5vFcSU2j0jIgYOlpn7AV+Q7QgApR9oCALOdL8A==
Date: Mon, 16 Oct 2023 22:15:18 +0000
Message-ID:
 <MN0PR21MB3606BE5B57AF1FEE85915F3AD6D7A@MN0PR21MB3606.namprd21.prod.outlook.com>
References: <1694105559-9465-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <20230911123231.GB19469@unreal>
 <BY5PR21MB1394F62601FEFE734181FFF7D6F2A@BY5PR21MB1394.namprd21.prod.outlook.com>
 <20230918082903.GC13757@unreal>
In-Reply-To: <20230918082903.GC13757@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ab46e44e-b795-4f92-bf6c-b3e64e313885;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-16T22:12:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3606:EE_|MN0PR21MB3532:EE_
x-ms-office365-filtering-correlation-id: 23da5cd2-4368-4194-b4b4-08dbce9561af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 91qiIhbGtiNzv0+A9+fbCqb4FTwxORdm6TMLlCx17rs10F/Y5X20aS9WPIBipTpcRFolhoMPBsCbNABY86Hk7oQb6pyxnqoOeTEtkFEla+lwsBQhYeyZkA6MIZ8XEbmZj0Us7ZmAIit3GuasPVYmEIFfzOfVnBh2/+GiRUO83sREVX0TMeicdPIvZt7nGzqiQAmljxXgUpBDYpTWUOgxQC/GJ9m4gBUhBnim0p+VKM9fOp7aGiBaCZUgwl9G43L2XCuDi3upbtKjFshd+bhmoGowBbpn8V+sUctGUXeEPpfX66TFnGlQf7uiCV8GL4ya5GqlaLWR3Vv3WTF67YQEdJw3e9UBhOY0ACdHPP5rzkRa7sRjlNpteUAN9lMpjf1eL2z76yyD2IngrfGfaUBe9KWYiSSzJTWQmaEMIRJrjBtkt7oX63n9/nLaxVWPJbUlVtIw+kq4diG5/Ls2mlkdfLCwBBaXnkgmW4P+kgnzwdP20XAYk0SCOlYqUYV0k5Tchxt52bNQnCSNI2AZud9TfyKDdGtTv7IMLxXFR6hCqsVH++hTAjTxlcAKsPg+FLQhwA/bgwp39fdJujSM9vr/iGzT204rmAGyT3odW+FVxLtEj46du0Se2QSdJ+h0JaSud6wnymm6EFC57VAN+q6H2kgQBnQ4/mvRReDPsn54+Xc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3606.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(7416002)(2906002)(316002)(8936002)(54906003)(64756008)(41300700001)(8676002)(66446008)(66476007)(6916009)(52536014)(66556008)(66946007)(5660300002)(76116006)(4326008)(55016003)(8990500004)(86362001)(38100700002)(83380400001)(33656002)(82950400001)(38070700005)(122000001)(82960400001)(71200400001)(7696005)(53546011)(6506007)(10290500003)(9686003)(478600001)(107886003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cWdrSENBUDhBOHJ5V0lFdFQyQUFtbDA4NkV6MnJZQXhxSVZwS2VhUVJqVytv?=
 =?utf-8?B?L0Y2RVJSWkcyR1JvV09LT3RwQXFOdVh3aC8zencrSFJHV2xaMjZFM1FzRUV2?=
 =?utf-8?B?dGhaTlloVVozelowSGZ3bWl0MlU1MDRQN3JLUzl3YTMyMWNKWE5SOXZsVXAy?=
 =?utf-8?B?Vm04WTM5cDFMYTFVblBNc3ROWDF5elNpa0wyMlgzTk1pc1ZEY0RXQUZnTWtn?=
 =?utf-8?B?VTEyb3JzSzRHcGo5RUc2RjhPQVpYcDlvV1M0c2l1a0c1UkhBWmFQRklLWDZP?=
 =?utf-8?B?dFhWYm8yRlJkRXRDR3ZzcllvVUUyWUhKemFmSktZeDNldnhCUWU5andQRXV5?=
 =?utf-8?B?aW5kL003eGhVbkU3enQ3Z2RIZnQwYk9hVW44TkdpaU9taWJydWV2aGlkbG53?=
 =?utf-8?B?OVF1VlVmOGdTSlRPbmNaNXRMM0lWOUtxVkdZcmVseWZ2ZHVicnF1ZkJadEk0?=
 =?utf-8?B?Ui9yaFAzUCtqYUhJeDZYMFZNUDNzbkpkbFpWUi9SWmdFMU10dlhmSTNyNVNr?=
 =?utf-8?B?bkN5dEFoSHdpMUx5UDlmcE9yT1BLamhIRVJYUk5ZRkVvRmo1ekJJU01tUU9C?=
 =?utf-8?B?a0ZmUUFDdjA4cVN5YStKblg0UGIrY1JReHEva2pVM2NoOWh3NTQzL1Jyejdz?=
 =?utf-8?B?YUtmajNOcVNDSG8zRi9VRXNVZEZjZDA0UXBYUDdGSmhoUzMySld0aUtTR2Nu?=
 =?utf-8?B?eVlKUW5CWklYZVZNUWx1Qy9oMTk4ZHd6d2txOG04emU1KzVDSWNpamM5dEVm?=
 =?utf-8?B?QTRycHJ2dGJhRGV6QURRQ0J5NFRYdExWMmpXKzlYajRzOWdHcTNvb3B0a1B6?=
 =?utf-8?B?Njd2QlBWeGhpNFlra1VCTW8xRDdweEJTeEcwc2lUU1RseWNGdXhIcHdvYVQ1?=
 =?utf-8?B?NTIwV3o2bW1GUHJwU2NXRVZ0RGZ3aHBxRkpqNG15Y1ZYTkdtMlVDN0xNb2Jr?=
 =?utf-8?B?Zjl3YzVVa1YrclplbzVhMUNTRmVkSlBhcExDMVQrcHlHVHM3WGU5bnhjNVBi?=
 =?utf-8?B?eUo3bjdIQ0U1VmsvMWhyQU5ydTJnQytTTmdXMWJqTjBQTG5GOWNWamcxdnpp?=
 =?utf-8?B?YmRNY25GSkFHUEc0ZEVVWnhMK1BpT0tsMG50M05ic3dQbExIZXFzQXF2VFFN?=
 =?utf-8?B?VlZjT0czV3cweUlLWTVSWnJSZmFoSGVnb0FQNG12QjFyMkwrUFFHdVV4Q3Z5?=
 =?utf-8?B?dEFDMUF0MC9aZFdpUGx5OWNaL0NmalVDdTVCNFd3MnpjL3dVZTRWVlZ2clg4?=
 =?utf-8?B?a1FqcGRHSzVHVmFJeERiaTBodnlRTklUZUc1OVl5bG5Pa2NoUklxckZMbm5T?=
 =?utf-8?B?aGhxRkRzYnB1a0orc05IcXNxUU9MSG1PMlNkOUZOZU1OVHNTSlBaSmhMSHpj?=
 =?utf-8?B?Yy9VMndobVc3MGxEUExvZ0tveXFQaWNBa0JocU9nZUdSTjd0S1ZVNFlKby9a?=
 =?utf-8?B?WVB2M1R1OXRML2hob0NXMVh5dXRwY1dUMW9UZ3hRR3F3elhRTFlmUjEzYjVG?=
 =?utf-8?B?bisxa3pFTG9BZWFHd1kySkdzZkllMjJ0UWM4MWZvVUJQaDVacjNMRE9vZWtN?=
 =?utf-8?B?NjJXQzM3WmFuWmIxQ2FOVGNiNHBieWRPUWhVZWNlem5hZktHbUx1ZFZIbGFO?=
 =?utf-8?B?SWpBcWdURlNvcHJxd2xXcUNJMGZDY1YrSlhDNnJrek9tM05MdnpjenZkeTBV?=
 =?utf-8?B?UWNGYnZyYWRXWXJqRDlheWNGMEo4M3JwOUhZaithVGtuWm1pa29MTWRtanJE?=
 =?utf-8?B?MWNYcW9oVi9ubDUwc0F5UnBUdTErenB0Z3V4WlQ5NDlmeVpUeS9wZ2JNVXE1?=
 =?utf-8?B?ZVVnV1JOMEIxb0ZkVXU3RkJnL3NvajJPUkNjbUw2MFlEbW1seERZVXNYU1l5?=
 =?utf-8?B?c09VNnFzRFpTWkRVRHVSeVhUdnV2eHB4YkViL2tiWlJZMFA1eWJHRVNwMDU3?=
 =?utf-8?B?QjRvTU1sdjdVS1BMRFlVMER1ejNiejh1bWo4NU5hcExacFV4UE4yNlFwYXNI?=
 =?utf-8?B?N0c1blVvWjBlMWxWc21HZGF0bWZZb2pRdHArZ00ycUhVWnJxRTNUcUw1QTdG?=
 =?utf-8?Q?qBEFKo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3606.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23da5cd2-4368-4194-b4b4-08dbce9561af
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 22:15:18.7091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oysbtvEgLFkCpPb/QE7QqLKWRaG/mxuc578dVJqrtSH/yb+SuTVAOqom5P0UMkF5zid7wBNTSkNGVQ6BMQfLwexZ4KkN1bgxPwAOl+H5Xcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3532
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

SSBoYXZlIHNlbnQgdjcgcGF0Y2ggc2VyaWVzIHdpdGggdGhlIHNwYWNlIHJlbW92ZWQgDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGVvbiBSb21hbm92c2t5IDxsZW9u
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDE4LCAyMDIzIDE6MjkgQU0N
Cj4gVG86IEFqYXkgU2hhcm1hIDxzaGFybWFhamF5QG1pY3Jvc29mdC5jb20+DQo+IENjOiBzaGFy
bWFhamF5QGxpbnV4b25oeXBlcnYuY29tOyBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT47
IEphc29uDQo+IEd1bnRob3JwZSA8amdnQHppZXBlLmNhPjsgRGV4dWFuIEN1aSA8ZGVjdWlAbWlj
cm9zb2Z0LmNvbT47IFdlaSBMaXUNCj4gPHdlaS5saXVAa2VybmVsLm9yZz47IERhdmlkIFMuIE1p
bGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpldA0KPiA8ZWR1bWF6ZXRAZ29v
Z2xlLmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBQYW9sbyBBYmVuaQ0K
PiA8cGFiZW5pQHJlZGhhdC5jb20+OyBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsgbGludXgt
DQo+IGh5cGVydkB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtFWFRFUk5BTF0gUmU6IFtQ
YXRjaCB2NSAwLzVdIFJETUEvbWFuYV9pYg0KPiANCj4gT24gTW9uLCBTZXAgMTEsIDIwMjMgYXQg
MDY6NTc6MjFQTSArMDAwMCwgQWpheSBTaGFybWEgd3JvdGU6DQo+ID4gSSBoYXZlIHVwZGF0ZWQg
dGhlIGxhc3QgcGF0Y2ggdG8gdXNlIHhhcnJheSwgd2lsbCBwb3N0IHRoZSB1cGRhdGUgcGF0Y2gu
IFdlDQo+IGN1cnJlbnRseSB1c2UgYXV4IGJ1cyBmb3IgaWIgZGV2aWNlLiBHZF9yZWdpc3Rlcl9k
ZXZpY2UgaXMgZmlybXdhcmUgc3BlY2lmaWMuIEFsbA0KPiB0aGUgcGF0Y2hlcyB1c2UgUkRNQS9t
YW5hX2liIGZvcm1hdCB3aGljaCBpcyBhbGlnbmVkIHdpdGgNCj4gZHJpdmVycy9pbmZpbmliYW5k
L2h3L21hbmEvIC4NCj4gDQo+IOKenCAga2VybmVsIGdpdDood2lwL2xlb24tZm9yLXJjKSBnaXQg
bCAtLW5vLW1lcmdlcyBkcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS8NCj4gMjE0NTMyODUxNWM4
IFJETUEvbWFuYV9pYjogVXNlIHYyIHZlcnNpb24gb2YgY2ZnX3J4X3N0ZWVyX3JlcSB0byBlbmFi
bGUNCj4gUlggY29hbGVzY2luZw0KPiA4OWQ0MmI4Yzg1YjQgUkRNQS9tYW5hX2liOiBGaXggYSBi
dWcgd2hlbiB0aGUgUEYgaW5kaWNhdGVzIG1vcmUgZW50cmllcw0KPiBmb3IgcmVnaXN0ZXJpbmcg
bWVtb3J5IG9uIGZpcnN0IHBhY2tldA0KPiA1NjNjYTBlOWVhYjggUkRNQS9tYW5hX2liOiBQcmV2
ZW50IGFycmF5IHVuZGVyZmxvdyBpbg0KPiBtYW5hX2liX2NyZWF0ZV9xcF9yYXcoKQ0KPiAzNTc0
Y2ZkY2EyODUgUkRNQS9tYW5hOiBSZW1vdmUgcmVkZWZpbml0aW9uIG9mIGJhc2ljIHU2NCB0eXBl
DQo+IDAyNjZhMTc3NjMxZCBSRE1BL21hbmFfaWI6IEFkZCBhIGRyaXZlciBmb3IgTWljcm9zb2Z0
IEF6dXJlIE5ldHdvcmsNCj4gQWRhcHRlcg0KPiANCj4gSXQgaXMgZGlmZmVyZW50IGZvcm1hdCBm
cm9tIHByZXNlbnRlZCBoZXJlLiBZb3UgYWRkZWQgZXh0cmEgc3BhY2UgYmVmb3JlICI6Ig0KPiBh
bmQgdGhlcmUgaXMgZG91YmxlIHNwYWNlIGluIG9uZSBvZiB0aGUgdGl0bGVzLg0KPiANCkkgaGF2
ZSByZW1vdmVkIHRoZSBzcGFjZQ0KDQo+IFJlZ2FyZGluZyBhdXgsIEkgc2VlIGl0LCBidXQgd2hh
dCBjb25mdXNlcyBtZSBpcyBwcm9saWZlcmF0aW9uIG9mIHRlcm1zIGFuZA0KPiB2YXJpb3VzIGNh
bGxzOiBkZXZpY2UsIGNsaWVudCwgYWRhcHRlci4gTXkgZXhwZWN0YXRpb24gaXMgdG8gc2VlIG1v
cmUgdW5pZm9ybQ0KPiBtZXRob2RvbG9neSB3aGVyZSBJQiBpcyByZXByZXNlbnRlZCBhcyBkZXZp
Y2UuDQo+IA0KDQpUaGUgYWRhcHRlciBpcyBhIHNvZnR3YXJlIGNvbnN0cnVjdC4gSXQgaXMgdXNl
ZCBhcyBhIGNvbnRhaW5lciBmb3IgcmVzb3VyY2VzLiBDbGllbnQgaXMgdXNlZCB0byBkaXN0aW5n
dWlzaCBiZXR3ZWVuIGV0aCBhbmQgaWIuICBQbGVhc2Ugbm90ZSB0aGF0IHRoZXNlIGFyZSB0ZXJt
cyB1c2VkIGZvciBkaWZmZXJlbnQgcHVycG9zZXMgb24gdGhlIG1hbmFnZW1lbnQgc2lkZS4gDQoN
Cj4gVGhhbmtzDQo+IA0KPiA+DQo+ID4gVGhhbmtzDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9y
Zz4NCj4gPiA+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDExLCAyMDIzIDc6MzMgQU0NCj4gPiA+
IFRvOiBzaGFybWFhamF5QGxpbnV4b25oeXBlcnYuY29tDQo+ID4gPiBDYzogTG9uZyBMaSA8bG9u
Z2xpQG1pY3Jvc29mdC5jb20+OyBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT47DQo+ID4g
PiBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPjsgV2VpIExpdSA8d2VpLmxpdUBrZXJu
ZWwub3JnPjsNCj4gPiA+IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVy
aWMgRHVtYXpldA0KPiA+ID4gPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1YiBLaWNpbnNraSA8
a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkNCj4gPiA+IDxwYWJlbmlAcmVkaGF0LmNvbT47
IGxpbnV4LSByZG1hQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IGxpbnV4LWh5cGVydkB2Z2VyLmtl
cm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBBamF5IFNoYXJtYSA8c2hhcm1hYWpheUBtaWNyb3NvZnQuY29tPg0KPiA+
ID4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BhdGNoIHY1IDAvNV0gUkRNQS9tYW5hX2liDQo+
ID4gPg0KPiA+ID4gT24gVGh1LCBTZXAgMDcsIDIwMjMgYXQgMDk6NTI6MzRBTSAtMDcwMCwNCj4g
PiA+IHNoYXJtYWFqYXlAbGludXhvbmh5cGVydi5jb20NCj4gPiA+IHdyb3RlOg0KPiA+ID4gPiBG
cm9tOiBBamF5IFNoYXJtYSA8c2hhcm1hYWpheUBtaWNyb3NvZnQuY29tPg0KPiA+ID4gPg0KPiA+
ID4gPiBDaGFuZ2UgZnJvbSB2NDoNCj4gPiA+ID4gU2VuZCBxcCBmYXRhbCBlcnJvciBldmVudCB0
byB0aGUgY29udGV4dCB0aGF0IGNyZWF0ZWQgdGhlIHFwLiBBZGQNCj4gPiA+ID4gbG9va3VwIHRh
YmxlIGZvciBxcC4NCj4gPiA+ID4NCj4gPiA+ID4gQWpheSBTaGFybWEgKDUpOg0KPiA+ID4gPiAg
IFJETUEvbWFuYV9pYiA6IFJlbmFtZSBhbGwgbWFuYV9pYl9kZXYgdHlwZSB2YXJpYWJsZXMgdG8g
bWliX2Rldg0KPiA+ID4gPiAgIFJETUEvbWFuYV9pYiA6IFJlZ2lzdGVyIE1hbmEgSUIgIGRldmlj
ZSB3aXRoIE1hbmFnZW1lbnQgU1cNCj4gPiA+ID4gICBSRE1BL21hbmFfaWIgOiBDcmVhdGUgYWRh
cHRlciBhbmQgQWRkIGVycm9yIGVxDQo+ID4gPiA+ICAgUkRNQS9tYW5hX2liIDogUXVlcnkgYWRh
cHRlciBjYXBhYmlsaXRpZXMNCj4gPiA+ID4gICBSRE1BL21hbmFfaWIgOiBTZW5kIGV2ZW50IHRv
IHFwDQo+ID4gPg0KPiA+ID4gSSBkaWRuJ3QgbG9vayB2ZXJ5IGRlZXAgaW50byB0aGUgc2VyaWVz
IGFuZCBoYXMgdGhyZWUgdmVyeSBpbml0aWFsIGNvbW1lbnRzLg0KPiA+ID4gMS4gUGxlYXNlIGRv
IGdpdCBsb2cgZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvIGFuZCB1c2Ugc2FtZSBmb3JtYXQN
Cj4gPiA+IGZvciBjb21taXQgbWVzc2FnZXMuDQo+ID4gPiAyLiBEb24ndCBpbnZlbnQgeW91ciBv
d24gaW5kZXgtdG8tcXAgcXVlcnkgbWVjaGFuaXNtIGluIGxhc3QgcGF0Y2gNCj4gPiA+IGFuZCB1
c2UgeGFycmF5Lg0KPiA+ID4gMy4gT25jZSB5b3UgZGVjaWRlZCB0byBleHBvcnQgbWFuYV9nZF9y
ZWdpc3Rlcl9kZXZpY2UsIGl0IGhpbnRlZCBtZQ0KPiA+ID4gdGhhdCBpdCBpcyB0aW1lIHRvIG1v
dmUgdG8gYXV4YnVzIGluZnJhc3RydWN0dXJlLg0KPiA+ID4NCj4gPiA+IFRoYW5rcw0KPiA+ID4N
Cj4gPiA+ID4NCj4gPiA+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL2NxLmMgICAgICAg
ICAgICAgICB8ICAxMiArLQ0KPiA+ID4gPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvZGV2
aWNlLmMgICAgICAgICAgIHwgIDgxICsrKy0tDQo+ID4gPiA+ICBkcml2ZXJzL2luZmluaWJhbmQv
aHcvbWFuYS9tYWluLmMgICAgICAgICAgICAgfCAyODggKysrKysrKysrKysrKy0tLS0tDQo+ID4g
PiA+ICBkcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9tYW5hX2liLmggICAgICAgICAgfCAxMDIg
KysrKysrLQ0KPiA+ID4gPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvbXIuYyAgICAgICAg
ICAgICAgIHwgIDQyICsrLQ0KPiA+ID4gPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvcXAu
YyAgICAgICAgICAgICAgIHwgIDg2ICsrKy0tLQ0KPiA+ID4gPiAgZHJpdmVycy9pbmZpbmliYW5k
L2h3L21hbmEvd3EuYyAgICAgICAgICAgICAgIHwgIDIxICstDQo+ID4gPiA+ICAuLi4vbmV0L2V0
aGVybmV0L21pY3Jvc29mdC9tYW5hL2dkbWFfbWFpbi5jICAgfCAxNTIgKysrKystLS0tDQo+ID4g
PiA+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb3NvZnQvbWFuYS9tYW5hX2VuLmMgfCAgIDMg
Kw0KPiA+ID4gPiAgaW5jbHVkZS9uZXQvbWFuYS9nZG1hLmggICAgICAgICAgICAgICAgICAgICAg
IHwgIDE2ICstDQo+ID4gPiA+ICAxMCBmaWxlcyBjaGFuZ2VkLCA1NDUgaW5zZXJ0aW9ucygrKSwg
MjU4IGRlbGV0aW9ucygtKQ0KPiA+ID4gPg0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjI1LjENCj4g
PiA+ID4NCg==

