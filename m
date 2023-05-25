Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B617105ED
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 May 2023 09:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbjEYHGS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 25 May 2023 03:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238570AbjEYHGK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 25 May 2023 03:06:10 -0400
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazon11020023.outbound.protection.outlook.com [52.101.128.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A232EE47;
        Thu, 25 May 2023 00:06:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVAdwEvkofpZNQTOjBWqjkC+zV+E6nbdizc7FMN75lZFKnQ8aR4jWorL0H+QFzhKCBoh3eTRDQ+MboKXJ1IET8RqB2RSKWMulzvWOD4wKoQedIFnwp6SAn5iRL0BzZlnxmchXuzXll+GWKZTo7dO1cxwGj/tcYxxT//JwHq4S4HzQCRrYaiEZ6PwujFE7BrcLcLnA0ei+OIKhijeY1o6nhH5jTF5/g/zSVxsZXUBd5Ac7/M0u1XDgFFS3UF5EtUwid6Sgh5i+RXH4MyguJh+dhdrhMc0J/XZ9o2lW4A/bnYElctDB9KT2h6cKsTR75vJpMC2ukFIlABXg2n80VjYAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=errV439iky9+8msgC8UtYzvH8kjxRcpLL8MZF5CL5nE=;
 b=IxJheQ6LKP2bv5Q3efDqX2gkbMkdnMjV1Dkyixgy16Q1sgFIwq4ikSODMcr0j7GBLX6R5bG4847hEdwfKgxl5nE6d0RfXbAhYx4l7YEWKFW8IEBdvoCQSa2BUDOYxKWzcxHbNQkgqmeh3DRdpD2rkQizyqbfANdafN2fW+JX1nXFmSkWcYYzpFj0z7bYXxVK5JNaZVdBj57HUhbvhXfdO6jNolPd35Qnn/+FASY8lPCWXR9RGVgOpQKJ03M6HJwnwwluzPBUCTCJIxd+ZC5X/dyAWeqExsalYr9D96FQbJXf77ODZ3ZrGFQx+WNrMMIOlRcL3/GyGCzCtZBDLw7oEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=errV439iky9+8msgC8UtYzvH8kjxRcpLL8MZF5CL5nE=;
 b=QrVWsipOe4a1RuUD19ght7O75F/W9m8h76bQDraQOYJo6St1X8ZSS+TNiweYNY1fNFfTVfsbu0SjsAd7OIi1PPNagX1GS2m2uW2v87J1EMabH/BcyVb4MKuJLVjW6CITHAoBd43CEE8stYMelFegz7ailK52if+ldE3RoZ+j89c=
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e6::8) by
 SI2P153MB0719.APCP153.PROD.OUTLOOK.COM (2603:1096:4:19e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.7; Thu, 25 May 2023 07:06:02 +0000
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11]) by PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11%2]) with mapi id 15.20.6455.004; Thu, 25 May 2023
 07:06:02 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH 1/2] x86/Kconfig: Allow CONFIG_X86_MPPARSE
 disable for OF platforms
Thread-Topic: [EXTERNAL] Re: [PATCH 1/2] x86/Kconfig: Allow CONFIG_X86_MPPARSE
 disable for OF platforms
Thread-Index: AQHZhBiUq424crV8z0Sj0fJkb54l069oNpQAgAF1oECAAB95AIAAz9nA
Date:   Thu, 25 May 2023 07:06:02 +0000
Message-ID: <PUZP153MB074988C9F8F891533871173BBE46A@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
References: <1683816877-10747-1-git-send-email-ssengar@linux.microsoft.com>
 <9b88ddaf-c5c5-0244-5be7-12400ee54e11@intel.com>
 <PUZP153MB074959D2F85EAD559ED7B544BE41A@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
 <33d7800b-7870-6755-b057-f734fa7accd6@intel.com>
In-Reply-To: <33d7800b-7870-6755-b057-f734fa7accd6@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6d6110b1-d905-497f-b99a-3fce01836555;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-25T06:26:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0749:EE_|SI2P153MB0719:EE_
x-ms-office365-filtering-correlation-id: b53bd827-a754-448d-f4d4-08db5cee8014
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n3W5Bd9FdIj7fZh1atdqjGrOvcWmEcHh8uLSUxzigtc0XWrHER0zMlWvhZKypFqD4VpdbadGdcri8NFtebeZjMC+u3T2k6XE92TpJ6UvwrEeiSt3DnitwVAgALHjCKXH4ZupkP/HVmnNOevopThCIBEb84SrlrY5x2zOgE4BP1PzSvme5lNAQSa9Z5r+wUlLrX38fr7Ftn7pl2ZrNbVZLNayoywB7m5seP5h9a4iHlN6FapZwCq8kj5eyZHQuAgz6xzJNYr/gDSW+YNLrzgsCOGmhnrSNoznPfn0uNAG95VlD9R3GOeCFvnBUjCf5FfV8PSx0oFEKlhmDvI+2uUOcU+CdIBhL4JD3g+eWTnBRvkVjvY0+lU7j67OYjHaRg4otx+Sz5wlr5cwVP5/hdpjWyHoj2p7WfBdF2KsjIEOe4RVacGpCj+SMNx5yYbF8P122/U/50ikxZc2PlBPHa/Y0QE1d4xfBa/QNsZGxt3A6kcmuceLYkRNEB+ldTnF2Pw0PIV72m4wQuZ6CD8awRCaYILCkhM1MJzkVv5XfDKOvJEpTGPmN5XAOUAJ9Hb1XUo1vrNPQxQt3vfGD5a4Wj4g2gqO8U7TQS+f41fLJCMKV7vcl+vI5NIWs05gAS/RAG/SgbBvAXT9proJg23IGu/eulWXcnvl10BxHjDwI/x/aL4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0749.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(33656002)(82960400001)(38100700002)(82950400001)(921005)(122000001)(38070700005)(86362001)(55016003)(8936002)(8676002)(5660300002)(52536014)(10290500003)(7416002)(966005)(9686003)(6506007)(2906002)(66556008)(186003)(83380400001)(786003)(71200400001)(76116006)(66946007)(7696005)(316002)(41300700001)(110136005)(478600001)(8990500004)(66446008)(64756008)(53546011)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHRsaFFzalB1THdVRmxxbk5kWEg2eUpDTGF6eWVvQ2llUmNlMXBaTVRqemR3?=
 =?utf-8?B?SnNkclJzK29UR3dmeWh3aC9CaXdxazBLS1JGYk16WnloUFRWeUIxNWQxKzNy?=
 =?utf-8?B?bjh4cTVPUmpMTEMzUnFHcGpaU1hGQ2xUcFFOa0MxcW5xVTE0Q1N2ZU5mREhr?=
 =?utf-8?B?ZzlhVk5SUkU2THNqMnVYSjJOaVE2WWwvbjZjMUdWS0FDN3BuN2w0WHEwb3By?=
 =?utf-8?B?eUF6QldVZFk4YlRQbk9lRFF6Mm9KVmViRHd2VWczTDkxUnJMTExtYTQvOFRP?=
 =?utf-8?B?MWlzeG96aDNDRVpOelpiZGxSRGhIY3dNWlUxOHFaNEZEblRoUzJIOVBNbXVa?=
 =?utf-8?B?aVJKZFNxS3JwdEVmc01GWEZoa3VWUWM1bmpkdzJBVVhwV2RhSWxvR0UzTTlw?=
 =?utf-8?B?Y0RjK2ZhYVNpcS80QVB6T3lEY3dDdG1pMWplNlZqNVlIY1FFaTB3ZE1BRGw4?=
 =?utf-8?B?TlYwOEU1YlZ2TXEzU01PVFdhVTZvcmNjankveDlZUHJsVUxzQkc4SnZWWEVJ?=
 =?utf-8?B?M01SckFLWThSakJDODkxVWp4SVFyTFdMZDlJYlI4V1ZRelhFQ2RXZVZKYkF1?=
 =?utf-8?B?MEZVaG9IZWUzZWRBbnl2TFdFNHRpa091SVBmZURDSjNXeGU0MGpqWWhjeVF6?=
 =?utf-8?B?eHRqVmpITkdNSW1ER3lZZVA0dVVQcGZNSG5obDRyVUludlVvejhyZkJDb2Nu?=
 =?utf-8?B?RFlHbTgwQ1VRWUhQM3l2TDhNY3p4SThiQ1lmWFA5U2NOdVA0cGFLQnhzRTIw?=
 =?utf-8?B?Yzh4Tkl1NnNaeko5WkREbXhXenlJNWFONVAxT1ZENytPZjRVREJXWnFwc0xD?=
 =?utf-8?B?T3k2R3ZoTm42WTV2eE84a1Z3MHMzM2xuNXVsdVpWald4L0FvZElheG5Ub3JE?=
 =?utf-8?B?eWYyUW5lMlpUZVh0MU5ybnh2Uit5MEVKa2ZWOEFDeE84S1FXWDJVUW9ib3JY?=
 =?utf-8?B?Nk5ZSHo4Z2k4NkhxaVFmTTZKRVkwa21taFVEaDR5OXFsSy8rTUJtL28vN2Jx?=
 =?utf-8?B?TisvQk5WN3ZjZjNreWRDdXIvaGo5WXBqR25GNHJMNm9BUmRVZU1oRjBIZnFV?=
 =?utf-8?B?d1k2bTd1a1dlWEx4U3JWaTRDK2M2UmFUdVlUQ3k5eThXTDA3Q0w0ckU1TmZz?=
 =?utf-8?B?ZzUxZVN5Z1pycWhlSnI5QlNiY0ptcVlNZEkvSVhYRGlOMy9QK2dKRUkyaXk1?=
 =?utf-8?B?OUcrejkzak1PR2xaQ1F3VkJ4L2xyYzBLYUMya3EvNmloWjdWZU15SU1Wa2N2?=
 =?utf-8?B?R2xVUWlhWXBheTVReGl2WE1SVGw5Wjl6QXB3cnd3SFh0c2hkR2haQmxkUUJR?=
 =?utf-8?B?T3RVQVFXYS9DY2JxbjNrWmJWWklsT0pWUk55dklPSmczQWpSdk1TSjhremt6?=
 =?utf-8?B?RzExcjJEbnNMMTJlcDJOQmU4OVF1N05ncUllelFEbmJNRE95UHhsNlB1dzVz?=
 =?utf-8?B?UENxQTRnek90bllVdDk3aEM1RVZUSTVDOThpaTlaTkxMbEYvSUpaakJ4Y2Rn?=
 =?utf-8?B?b1MxWFNDK1lLVjFHcjZvdTZYQWMxeFF3TFJzUnBiSjBHM1NiejdjdEd5Sjl4?=
 =?utf-8?B?U3FxMkMyeXVhdkxKeXVTZWt1OVc4aFdrRjlXd2tnU09NUzdBaUlYV1RueGtE?=
 =?utf-8?B?ZFpFcG50WGlyMGdKeGcyMWNBUngva2MwMldMR0c3ODFsS1lPSC9oK0kyUHRO?=
 =?utf-8?B?eFI3Z2FQWnZqS29McUMyNnVoOGZQTGJDSTBDMzduWi9CSkZ0K3gxbWFsUFJN?=
 =?utf-8?B?UTJINkNoelFvanlSOE4ra0NpTWlINWxreWlVb0lXRi9FUjBRSG9FUEFMbnpi?=
 =?utf-8?B?Vmx1SjhwS2Z4c1N0Q0lQVnlqa3gwNzhubEduY2VSSGpZR3RZOFVsQ21zR1I1?=
 =?utf-8?B?WjhVRzdMQjdSdUFxcEFvcjhLdTFVZGE3QW9Qei94SkZxbmVLSUFkazZLNWpp?=
 =?utf-8?B?cU92S25ETzRyQWErOVhOMFpmL1NlUnV5amFGaU4xNHNoeUtrYmcwYy9QS0JZ?=
 =?utf-8?B?V1JDZDhHaDFFZ2NCRWNjRVVSak9YVHpwVVkvb0QxUnJLVE42Z2dNblVnVDNJ?=
 =?utf-8?B?YndCMlJFelVhbmwxNnM4MFhoVzBGQkRrVFUvMHFWSWtTRURwRVBMYzBMZ2la?=
 =?utf-8?Q?2wmUaDivbGo+qMlgyBpmXxXnm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b53bd827-a754-448d-f4d4-08db5cee8014
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 07:06:02.3809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yicfnMfT6spX9vXNS6Gg5NG44qbkpjdA5C5S9I66IphHthXZrVnEcukUtqToUmdRH2BdyeexsOoffuZEjPHw8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2P153MB0719
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2ZSBIYW5zZW4gPGRh
dmUuaGFuc2VuQGludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgMjQsIDIwMjMgMTE6
MzMgUE0NCj4gVG86IFNhdXJhYmggU2luZ2ggU2VuZ2FyIDxzc2VuZ2FyQG1pY3Jvc29mdC5jb20+
OyBTYXVyYWJoIFNlbmdhcg0KPiA8c3NlbmdhckBsaW51eC5taWNyb3NvZnQuY29tPjsgdGdseEBs
aW51dHJvbml4LmRlOyBtaW5nb0ByZWRoYXQuY29tOw0KPiBicEBhbGllbjguZGU7IGRhdmUuaGFu
c2VuQGxpbnV4LmludGVsLmNvbTsgeDg2QGtlcm5lbC5vcmc7DQo+IGhwYUB6eXRvci5jb207IEtZ
IFNyaW5pdmFzYW4gPGt5c0BtaWNyb3NvZnQuY29tPjsgSGFpeWFuZyBaaGFuZw0KPiA8aGFpeWFu
Z3pAbWljcm9zb2Z0LmNvbT47IHdlaS5saXVAa2VybmVsLm9yZzsgRGV4dWFuIEN1aQ0KPiA8ZGVj
dWlAbWljcm9zb2Z0LmNvbT47IE1pY2hhZWwgS2VsbGV5IChMSU5VWCkgPG1pa2VsbGV5QG1pY3Jv
c29mdC5jb20+Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1oeXBlcnZA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggMS8y
XSB4ODYvS2NvbmZpZzogQWxsb3cNCj4gQ09ORklHX1g4Nl9NUFBBUlNFIGRpc2FibGUgZm9yIE9G
IHBsYXRmb3Jtcw0KPiANCj4gT24gNS8yNC8yMyAwOToyMywgU2F1cmFiaCBTaW5naCBTZW5nYXIg
d3JvdGU6DQo+ID4+IENvdWxkIHlvdSBwbGVhc2UgcmVwaHJhc2UgdGhpcyB0byBiZSBsZXNzIGNv
bmZ1c2luZz8NCj4gPg0KPiA+IFRoYW5rcyBmb3IgeW91ciByZXZpZXcuIEN1cnJlbnRseSwgaW4g
dGhlIGFic2VuY2Ugb2YgQUNQSSwgaXQgaXMNCj4gPiBpbXBvc3NpYmxlIHRvIGRpc2FibGUgWDg2
X01QUEFSU0UuIEluIHRoZSBjYXNlIG9mIEFDUEkgYmVpbmcgZW5hYmxlZCwNCj4gPiBvbmUgaGFz
IHRoZSBvcHRpb24gdG8gZWl0aGVyIGVuYWJsZSBvciBkaXNhYmxlIFg4Nl9NUEFSU0UuIE15DQo+
ID4gaW50ZW50aW9uIGlzIHRvIHBlcm1pdCBYODZfTVBQQVJTRT1uIGZvciBPRiBwbGF0Zm9ybXMg
d2hlcmUgQUNQST1uLiBUbw0KPiA+IGRlc2NyaWJlIHRoZSBjYXBhYmlsaXR5IG9mIGNob29zaW5n
IGFueSBkZXNpcmVkIHZhbHVlIGZvciBNUFBBUlNFLCBJIHVzZWQNCj4gdGhlIHRlcm0gJ3NlbGVj
dGFibGUuJw0KPiA+IFBlcmhhcHMgJ2NvbmZpZ3VyYWJsZScgd291bGQgYmUgYSBtb3JlIGFwcHJv
cHJpYXRlIHdvcmQgaW4gdGhpcyBjb250ZXh0Pw0KPiA+IEkgY2FuIGZpeCB0aGlzIGFuZCBpbmNs
dWRlIGl0IGluIFYyLg0KPiANCj4gT0ssIHNvIHRoaXMgcGFydGljdWxhciBIeXBlci1WIHNldHVw
IGRvZXNuJ3QgcnVuIG5vcm1hbCBub3JtYWwgZGlzdHJvDQo+IGtlcm5lbHM/ICBJdCByZXF1aXJl
cyBhIHZlcnkgc3BlY2lhbGl6ZWQga2VybmVsPyAgT3IgaXQncyBqdXN0IF9iZXR0ZXJfIHRoYXQg
dGhlDQo+IGtlcm5lbCBpcyBjb25maWd1cmVkIHRoaXMgd2F5Pw0KDQpUaGlzIGlzIGEgc3lzdGVt
IHdoZXJlIHdlIHByb3ZpZGUgaXNvbGF0aW9uIHRocm91Z2ggVlRMLiBNb3JlIGluZm9ybWF0aW9u
DQpBYm91dCBWVEwgaXMgaGVyZTogaHR0cHM6Ly9sZWFybi5taWNyb3NvZnQuY29tL2VuLXVzL3Zp
cnR1YWxpemF0aW9uL2h5cGVyLXYtb24td2luZG93cy90bGZzL3ZzbSN2aXJ0dWFsLXRydXN0LWxl
dmVsLXZ0bA0KDQpJbiB0aGUgY29udGV4dCBvZiBWVEwwLCB0aGUgc3lzdGVtIHJ1bnMgdGhlIG5v
cm1hbCBrZXJuZWwuIEhvd2V2ZXIsIGZvcg0KaGlnaGVyIFZUTHMsIHdlIGVuYWJsZSB0aGUga2Vy
bmVsIHdpdGggSFlQRVJWX1ZUTF9NT0RFLiBJdCdzIGltcG9ydGFudA0KdG8gbm90ZSB0aGF0IHRo
ZSBsb3dlciBtZW1vcnkgb2YgdGhlIHN5c3RlbSBpcyBub3QgaW5jbHVkZWQgaW4gdGhlIGhpZ2hl
ciBWVExzDQoNCkl0IHJ1bnMgdGhlIG5vcm1hbCBrZXJuZWwgYXMgcGFydCBvZiBWVEwwIGJ1dCBm
b3IgaGlnaGVyIFZUTHMgd2UgcnVuIHRoZSBrZXJuZWwgd2l0aA0KSFlQRVJWX1ZUTF9NT0RFIGVu
YWJsZS4gVlRMMCBpcyBhc3NpZ25lZCB0byBsb3dlciBtZW1vcnkgb2Ygc3lzdGVtLCB0aGUgbG93
ZXINCm1lbW9yeSBub3QgcGFydCBvZiBoaWdoZXIgVlRMcy4gSG93ZXZlciwgTVBBUlNFIG9wdGlv
biBkaXNyZWdhcmQgdGhpcyBhbmQgdHJ5IHRvDQpzY2FuIFZUTDAgbWVtb3J5IHdoaWNoIGNhdXNl
cyBpc3N1ZS4gVGhpcyB3aWxsIGVuYWJsZSBhbnkgc3lzdGVtIHdoaWNoDQpkb2Vzbid0IHdhbnQg
bG93ZXIgbWVtb3J5IHRvIGJlIHNjYW5uZWQgZm9yIE1QUEFSU0UgZm9yIHdoYXRldmVyIHJlYXNv
bi4NCg0KPiANCj4gPj4gVGhpcyBpcyBhbHNvIG9uZSBvZiB0aG9zZSBwYXRjaGVzIHdoZXJlIEkg
d29uZGVyOiBXaHkgZG8gX3lvdV8gY2FyZQ0KPiA+PiBhYm91dCB0aGlzPyAgQXJlIHlvdSBqdXN0
IHRyeWluZyB0byBiZSBuaWNlPyAgSXMgdGhpcyBpbnRlbmRlZCBhcyBzb21lIGtpbmQgb2YNCj4g
Y2xlYW51cD8NCj4gPg0KPiA+IEl0IHNvbHZlcyBhbiBpc3N1ZSBmb3IgSHlwZXItViBWQlMgc2V0
dXAsIHBsZWFzZSByZWZlciB0byB0aGUgMi8yIG9mDQo+ID4gdGhpcyBwYXRjaCBzZXJpZXMuDQo+
IA0KPiBIZWgsIHRoYXQgY2hhbmdlbG9nIGlzIGV2ZW4gbW9yZSBjb25mdXNpbmcgdGhhbiBfdGhp
c18gb25lLiAgSXQgZG9lc24ndCBzYXkNCj4gdGhhdCB0aGVyZSdzIGEgcHJvYmxlbSwgb25seSB0
aGF0IGl0IHJlbW92ZXMgIm5vdCByZXF1aXJlZCIgY29kZS4NCj4gDQo+IEknbSBzdGlsbCBjb25m
dXNlZCBieSB0aGlzIHdob2xlIHRoaW5nLg0KDQpJIGFncmVlIHRoZSBjb21taXQgbWVzc2FnZSBj
b3VsZCBiZSBiZXR0ZXIuIEFuZCBJIGNvbW1lbnRlZCBiZWxvdyBpbiB0aGF0DQp0aHJlYWQgdG8g
Y2xhcmlmeS4gSG9wZSBpdCBjbGFyaWZpZXMsIHBsZWFzZSBsZXQgbWUga25vdyBpZiBhbnkgbW9y
ZSBpbmZvcm1hdGlvbiBpcw0KcmVxdWlyZWQ6DQoNCldoZW4gQ09ORklHX1g4Nl9NUFBBUlNFIGlz
IGVuYWJsZWQsIHRoZSBrZXJuZWwgd2lsbCBzY2FuIGxvdyBtZW1vcnksDQpsb29raW5nIGZvciBN
UCB0YWJsZXMuIEluIEh5cGVyLVYgVkJTIHNldHVwLCBsb3dlciBtZW1vcnkgaXMgYXNzaWduZWQg
dG8gVlRMMC4NClRoaXMgbG93ZXIgbWVtb3J5IG1heSBjb250YWluIHRoZSBhY3R1YWwgTVBQQVJT
RSB0YWJsZSBmb3IgVlRMMCwNCndoaWNoIGNhbiBjb25mdXNlIHRoZSBWVEx4IGtlcm5lbCBhbmQg
Y2F1c2UgaXNzdWVzLiAoeCA+IDApDQo=
