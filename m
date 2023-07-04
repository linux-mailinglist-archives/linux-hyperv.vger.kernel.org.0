Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A1F7472F5
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jul 2023 15:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjGDNmh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 4 Jul 2023 09:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjGDNmf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 4 Jul 2023 09:42:35 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2104.outbound.protection.outlook.com [40.107.237.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ED410D5;
        Tue,  4 Jul 2023 06:42:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNYwTJo6HbSE3jAJhR8IHgczjf+PsEHoo6Qj7frlRQ1W0CDiP55FsY+2YMs+cA4eGZ/xM2FyftG2nAFFnHRvGXhWMXrXw9Nalaanqh8tSGa4wl4MXgAIARbD/z1IfUJKdKQgcOeeEANObHwd+2FtKasJpc2GKcsRgxPabhA/nsBGagEnKjWRvyc0j2zzTFp8c8jWbM17noKfDy663O++q7J03MazDAuHsMQQyM0PyQxInkReSCjHmRUdNs/h34FPhqNOrwiLxafASfYMyqo3IdUrdh8p4ixV7RbziHYyLUuuPDHd2l5yfVcggsCSTqebxajtDoDxsVyQ314DYhG98g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Za2DdJeMXY1WK4EE19OgRn3JX4we2MLgMwbGDWXd2+Q=;
 b=CF+vBddbei1CyfDK4iy8jkh+mejTsVWUZNgYdUPMAVHbrXpS6LuyzwkmTARJKlsEBldvYcp22zCwvkdDXdHXoN6+mzlNHGqy15zZ6KWHmv4vSzAZ3U0FmkUZWYemXG7Ay8yQjEd9jXqbkfWfYppqDwksBMQHtSZoHyw6+SyvhbN0Ftrr5L4kIeClnkbF0IhvXLpo4BEf/JeQJjf3OLo3LFE4o6pf/sqSojHZMnRNk6OQySCooGSnnhu1sNTKDDsieRe6Y/8hQVEDrAzurI6gahUBaZw+HG3PIANYgZ7/9wrTClV1WKFmbjgLXgGcQQg+hMSb1yzREWTyTH4NtkQU1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Za2DdJeMXY1WK4EE19OgRn3JX4we2MLgMwbGDWXd2+Q=;
 b=ModftgtSM+Jo5wMD0W5GHwcf2n31qNG5w3GDFwdFbEEBDeacqFTXj34rHpDIAbhhV06kaXuCLb6NoFVNvNC7SxVIS7clXZZx9ni6lD8Y6u25WKy311GFflYfJYI0P+2yQ5Sf2bnuhQ0KEtYcGH5rWvUD2jAzYrcY2uzhhXmITBQ=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by DM4PR21MB3369.namprd21.prod.outlook.com (2603:10b6:8:6d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.4; Tue, 4 Jul
 2023 13:42:25 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::848b:6d47:841d:20ff]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::848b:6d47:841d:20ff%4]) with mapi id 15.20.6544.006; Tue, 4 Jul 2023
 13:42:24 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Souradeep Chakrabarti <schakrabarti@microsoft.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        souradeep chakrabarti <schakrabarti@linux.microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
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
Thread-Index: AQHZrYtO9uZDC1JBBkmdomCootYeWK+oQRyAgAA0VACAASgUMA==
Date:   Tue, 4 Jul 2023 13:42:24 +0000
Message-ID: <PH7PR21MB31166C1FB6FEB3886EDA8103CA2EA@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1688374171-10534-1-git-send-email-schakrabarti@linux.microsoft.com>
 <83ef6401-8736-8416-c898-2fbbb786726e@intel.com>
 <PUZP153MB07880E6D692FD5D13C508694CC29A@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PUZP153MB07880E6D692FD5D13C508694CC29A@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1885f393-fb46-4093-8110-a76ca554c530;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-03T18:57:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|DM4PR21MB3369:EE_
x-ms-office365-filtering-correlation-id: 2eb5ed98-d84e-4888-af49-08db7c94800e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iJAfrQnZYpOoGECXYdmddBhZaSSYaU7jEF2eOma/h6lqt/bO7Yqr6Y12fSNvkuNTdUknOGAM4aZWXZvk9fn0tn0hbvmnVQBXIleYZ9Wt8zUxYKBv6qDiDlPzohCskgiFcP2ui2E1H7OuXPuzmLARmypxpRkCvpbo1AD/iIHzAKFiLlzWGW7yQTxwK6s4quIk+tg6OCJFQ8AzWHIWEAhtdYMMlvhWrPmOon4BiKhXLlIqfSIheEbgg3047WD70EbIUQaiSaHYi1Qk7bz86gqoUHVwZDqvvdiWVSyw2xiMkLKyVJGaWE9m0iqCAkJwuBR6auLP4UryjPqc7leOrVSTjBBG2VB5NvQK7utAwQz+SS+S3sfFANSPRrUy+N52NaD8n6VJ9r9KZIcJpwipGMv3TxOEZaquQ5AY3ffj4GWpYIGXG2jE6CHh7YWXvw61SdzWLmVpJTh5TlOXeAV1lEGaoLPUkr5l5FTeYP76T/bW9CA8ZyjxFhNqvDhWwsTpoAh7nkLKabYfS+kRwNoGHrfLMgY9vRIUY85Je6w8algP9nUuQ3sb3Dm1e0AItLjMrJe6iAKryAs0VhfsZjUswZ0A1qKSn4I6712IAbJYlZFMsuoqACNUMIayRwZ11PdT0OgzK4Q+GQwIpo5sOYnR+TyFRyWkiUaGV9MBzrfpZVZj31Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(10290500003)(76116006)(8990500004)(122000001)(5660300002)(478600001)(66946007)(2906002)(4326008)(66476007)(71200400001)(110136005)(54906003)(66446008)(41300700001)(66556008)(8936002)(8676002)(7696005)(64756008)(6506007)(9686003)(7416002)(26005)(186003)(53546011)(52536014)(316002)(83380400001)(66899021)(55016003)(82950400001)(38100700002)(82960400001)(38070700005)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vi9nLy9HRU03MmtqNndReStMNytjNDNFSmk5Mml3cW1PL2Roc1JmOHRySFRx?=
 =?utf-8?B?ZjEwWjVISFl2Si9GeDkyTVFVNERqNytsK0VVTGQvbm9hSTloYWdGMmxLNVdy?=
 =?utf-8?B?Y0lwb0F6YnluQy9DNEdONnBnYjhUUmVZUDhaK21Tamp5a2tDZU1lMTcrT0xC?=
 =?utf-8?B?QnZqZkNscFQ2RURjN0pMSWZadzFLTk8za2VqdFFrZko2VnJ2aTlUajVwckxF?=
 =?utf-8?B?QnpuenR6RjgvblRRUlpNcEVsb2swRXVRMytDcUZ4c3kxRU5LRU43Lzc1UmNn?=
 =?utf-8?B?VlVwcXU3ajJiUXBETUNTTlE2aFRVc2l1SDJsank3cy9KeGtiamp2Z1ZYSXVS?=
 =?utf-8?B?dHYzd2tucERlWUJBcE4vY3ArVVcwVGF6dVhiTlk5RldhbG0rUG84Tk1KQmE3?=
 =?utf-8?B?WDVhdHRVWVRjSUdmVGZEV3RqKzJjVDVBWVh2aHUyc0tZUVYweEZSMmI2bGFK?=
 =?utf-8?B?bDE0dGJhc1E0Umw5czQ3cDdwbEdRTUkyMytxTTRiRHlXNERudDVRUFhESExt?=
 =?utf-8?B?ZnJqcjI2SU82U2wyUlptUXdoZ2pZRTVXTnR2QnpySzdORW1XbzlMeU5XcDhB?=
 =?utf-8?B?aGJmc3hrWVk5cG93dnZqNStENnJNUXQ1WVE4TlFyMUkwOStOVGlHaDZEMmYw?=
 =?utf-8?B?NVQ5ZXV3VEJJbURyR2x4VllvNUc0Ui9kam80cjVqN204TEV2bndsY0JXQmFY?=
 =?utf-8?B?M3RWTVdWNzNrU2lpam1vdUlibFlwRzRyc1JBNWJjaTVnYlVSTWZwVllwM21u?=
 =?utf-8?B?MDR2a3Z2ZUNQZCs2OEU0bk53VVRmaEFOUHJVei93QlN3RncweG9SWWZHTmJa?=
 =?utf-8?B?eGMwaDdOZHhLaGhnN1phV0g2cDJVRXpjQkhXNVkwVDNGVlV6OUtZc0hNUlhm?=
 =?utf-8?B?K2F6am0xak1tb1ZoRDdBVlRiN0d4S2UxSHlrRFNsRmw1bTJab1NMdzlMWU1B?=
 =?utf-8?B?QWltOHhSbVRJUldFYUgxVXRoaWJIbVR4Y09nZFltZGtpR0ovRlZ2VGpYRWJ6?=
 =?utf-8?B?MGRGNFNxTmRUNXRLL1JrMjJZMTJ4eElaWDRNZS9HQlhvS0o3Sk9IRUJKZ1NX?=
 =?utf-8?B?YkthaEJnOW1hekJXZVRaRDN4R3UrTXBSMU1VZUZQV1FjY3FleWpHcllKekpV?=
 =?utf-8?B?Wk5Pb1h6Uy9jL3E3U1B0VUZreEZpK2N3Z0MxNC9XOEkxYmFHOGh4Y2dCVVpy?=
 =?utf-8?B?V3VNS0R6cUhDZXIzWWJQYS9kbWpPYlhMbTNzNm1DV2p1VlRDS2RqZGdEaWhp?=
 =?utf-8?B?a3B2b1V3Uk4xZEdvOGpHaCtTc0JrQitmdnhIcXVxcHFYSXd2YkFUZ0ZsOWtM?=
 =?utf-8?B?M01sbUR6QWhuMjU3U2hWdW8vTXBJc2JkdXE0Rmx1STlwbXJ2N0ZIMXRBV1Bw?=
 =?utf-8?B?S3pXVk4rMEdWU0F2dmJwMEs5MDUyWFcvTjVReXd6bDZ5bzNrTktEU3EzdlhL?=
 =?utf-8?B?enFIakNLWHFPcEt6d3pJN2hSVm1na200UXF4L0VEbU9SR3FlVEpZUWVQNE5j?=
 =?utf-8?B?cS8yN01RdndvNGR4N2QwRUxZLzZGWUZKRkk0Rk1PWHgxU1QxUndaM1dlbnc5?=
 =?utf-8?B?WU5TM0tMN0J1Z2w5bGJ1ckg1QXBQeWNiRjl3Snl3MDAyZERqSzVHcnVCNWxv?=
 =?utf-8?B?c3RBZVlKMngrL0ZrbkljOFViRk9TQ0dSMURYbzlZSmVyaWROVk8wcXdHRWEw?=
 =?utf-8?B?b0RBOGlLZkJyNlFLTnM4TllVaTZvSmh1WWZ0TjlXSnplbEloUUVTMVl4YmFh?=
 =?utf-8?B?eWNEMXEwamtDM0NUemxKdGM0U0RDaTA1SEdzSW5KMnRuTnQzSmcvWkt0U1ZS?=
 =?utf-8?B?SHZCbFR4aXdxYVE4ZFhUYUZ3YlBJT1o1cjhQdkk4ZzFVUDNvejVtbWtoK2Vv?=
 =?utf-8?B?b3RqNklLVytVRFpXcVJDL0lTZ2J4UVJQM0IxTVlPR1duYnZPSFY0MDR0QVhL?=
 =?utf-8?B?WmRZMFl0UGF2MVlZTFM2TG5zN2QzTmlSRzBGUzU2Sk5hQnpHU1Y4ZHk0V3pv?=
 =?utf-8?B?V2F0SHV1ZU1xMDFWTzBJV01QSnpMYjJCbUNpUlJqOE9GT0tIVWQ0Nm1iOE02?=
 =?utf-8?B?US8vRXV1eW9QZklTS2JMeDNsZUFPMDNLNkx6T0V1N29UWWl4WUV2WXBHTGZl?=
 =?utf-8?Q?CiKA2UVtbp+W2FO+J0faPjxB7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3116.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb5ed98-d84e-4888-af49-08db7c94800e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 13:42:24.8137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z8EvPGwL+wBhB8nFkHJbeiIxgEou4r11wva0lgxexxxMTDCsLxcf3h5/NHPYb2XbcCZESy4N+7EThagVm44diA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3369
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU291cmFkZWVwIENoYWty
YWJhcnRpIDxzY2hha3JhYmFydGlAbWljcm9zb2Z0LmNvbT4NCj4gU2VudDogTW9uZGF5LCBKdWx5
IDMsIDIwMjMgMzo1NSBQTQ0KPiBUbzogQWxleGFuZGVyIExvYmFraW4gPGFsZWtzYW5kZXIubG9i
YWtpbkBpbnRlbC5jb20+OyBzb3VyYWRlZXAgY2hha3JhYmFydGkNCj4gPHNjaGFrcmFiYXJ0aUBs
aW51eC5taWNyb3NvZnQuY29tPg0KPiBDYzogS1kgU3Jpbml2YXNhbiA8a3lzQG1pY3Jvc29mdC5j
b20+OyBIYWl5YW5nIFpoYW5nDQo+IDxoYWl5YW5nekBtaWNyb3NvZnQuY29tPjsgd2VpLmxpdUBr
ZXJuZWwub3JnOyBEZXh1YW4gQ3VpDQo+IDxkZWN1aUBtaWNyb3NvZnQuY29tPjsgZGF2ZW1AZGF2
ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsNCj4ga3ViYUBrZXJuZWwub3JnOyBwYWJl
bmlAcmVkaGF0LmNvbTsgTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+OyBBamF5DQo+IFNo
YXJtYSA8c2hhcm1hYWpheUBtaWNyb3NvZnQuY29tPjsgbGVvbkBrZXJuZWwub3JnOw0KPiBjYWku
aHVvcWluZ0BsaW51eC5kZXY7IHNzZW5nYXJAbGludXgubWljcm9zb2Z0LmNvbTsgdmt1em5ldHNA
cmVkaGF0LmNvbTsNCj4gdGdseEBsaW51dHJvbml4LmRlOyBsaW51eC1oeXBlcnZAdmdlci5rZXJu
ZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsNCj4gc3RhYmxlQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBSRTogW0VYVEVSTkFMXSBSZTogW1BBVENIIFY0IG5ldF0gbmV0OiBt
YW5hOiBGaXggTUFOQSBWRiB1bmxvYWQNCj4gd2hlbiBob3N0IGlzIHVucmVzcG9uc2l2ZQ0KPiAN
Cj4gDQo+IA0KPiA+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPkZyb206IEFsZXhhbmRl
ciBMb2Jha2luIDxhbGVrc2FuZGVyLmxvYmFraW5AaW50ZWwuY29tPg0KPiA+U2VudDogTW9uZGF5
LCBKdWx5IDMsIDIwMjMgMTA6MTggUE0NCj4gPlRvOiBzb3VyYWRlZXAgY2hha3JhYmFydGkgPHNj
aGFrcmFiYXJ0aUBsaW51eC5taWNyb3NvZnQuY29tPg0KPiA+Q2M6IEtZIFNyaW5pdmFzYW4gPGt5
c0BtaWNyb3NvZnQuY29tPjsgSGFpeWFuZyBaaGFuZw0KPiA+PGhhaXlhbmd6QG1pY3Jvc29mdC5j
b20+OyB3ZWkubGl1QGtlcm5lbC5vcmc7IERleHVhbiBDdWkNCj4gPjxkZWN1aUBtaWNyb3NvZnQu
Y29tPjsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsNCj4gPmt1YmFA
a2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207IExvbmcgTGkgPGxvbmdsaUBtaWNyb3NvZnQu
Y29tPjsgQWpheQ0KPiA+U2hhcm1hIDxzaGFybWFhamF5QG1pY3Jvc29mdC5jb20+OyBsZW9uQGtl
cm5lbC5vcmc7DQo+ID5jYWkuaHVvcWluZ0BsaW51eC5kZXY7IHNzZW5nYXJAbGludXgubWljcm9z
b2Z0LmNvbTsgdmt1em5ldHNAcmVkaGF0LmNvbTsNCj4gPnRnbHhAbGludXRyb25peC5kZTsgbGlu
dXgtaHlwZXJ2QHZnZXIua2VybmVsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsNCj4gPmxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOw0K
PiA+c3RhYmxlQHZnZXIua2VybmVsLm9yZzsgU291cmFkZWVwIENoYWtyYWJhcnRpDQo+IDxzY2hh
a3JhYmFydGlAbWljcm9zb2Z0LmNvbT4NCj4gPlN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRD
SCBWNCBuZXRdIG5ldDogbWFuYTogRml4IE1BTkEgVkYgdW5sb2FkIHdoZW4NCj4gPmhvc3QgaXMg
dW5yZXNwb25zaXZlDQo+ID4NCj4gPkZyb206IFNvdXJhZGVlcCBDaGFrcmFiYXJ0aSA8c2NoYWty
YWJhcnRpQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+ID5EYXRlOiBNb24sICAzIEp1bCAyMDIzIDAx
OjQ5OjMxIC0wNzAwDQo+ID4NCj4gPj4gRnJvbTogU291cmFkZWVwIENoYWtyYWJhcnRpIDxzY2hh
a3JhYmFydGlAbGludXgubWljcm9zb2Z0LmNvbT4NCj4gPg0KPiA+UGxlYXNlIHN5bmMgeW91ciBH
aXQgbmFtZSBhbmQgR2l0IG1haWwgYWNjb3VudCBzZXR0aW5ncywgc28gdGhhdCB5b3VyIG93bg0K
PiA+cGF0Y2hlcyB3b24ndCBoYXZlICJGcm9tOiIgd2hlbiBzZW5kaW5nLiBGcm9tIHdoYXQgSSBz
ZWUsIHlvdSBuZWVkIHRvDQo+ID5jb3JyZWN0IGZpcnN0IGxldHRlcnMgb2YgbmFtZSBhbmQgc3Vy
bmFtZSB0byBjYXBpdGFsIGluIHRoZSBHaXQgZW1haWwgc2V0dGluZ3MNCj4gPmJsb2NrLg0KPiBU
aGFuayB5b3UgZm9yIHBvaW50aW5nLCBJIHdpbGwgZml4IGl0Lg0KPiA+DQo+ID4+DQo+ID4+IFdo
ZW4gdW5sb2FkaW5nIHRoZSBNQU5BIGRyaXZlciwgbWFuYV9kZWFsbG9jX3F1ZXVlcygpIHdhaXRz
IGZvciB0aGUNCj4gPj4gTUFOQSBoYXJkd2FyZSB0byBjb21wbGV0ZSBhbnkgaW5mbGlnaHQgcGFj
a2V0cyBhbmQgc2V0IHRoZSBwZW5kaW5nDQo+ID4+IHNlbmQgY291bnQgdG8gemVyby4gQnV0IGlm
IHRoZSBoYXJkd2FyZSBoYXMgZmFpbGVkLA0KPiA+PiBtYW5hX2RlYWxsb2NfcXVldWVzKCkgY291
bGQgd2FpdCBmb3JldmVyLg0KPiA+Pg0KPiA+PiBGaXggdGhpcyBieSBhZGRpbmcgYSB0aW1lb3V0
IHRvIHRoZSB3YWl0LiBTZXQgdGhlIHRpbWVvdXQgdG8gMTIwDQo+ID4+IHNlY29uZHMsIHdoaWNo
IGlzIGEgc29tZXdoYXQgYXJiaXRyYXJ5IHZhbHVlIHRoYXQgaXMgbW9yZSB0aGFuIGxvbmcNCj4g
Pj4gZW5vdWdoIGZvciBmdW5jdGlvbmFsIGhhcmR3YXJlIHRvIGNvbXBsZXRlIGFueSBzZW5kcy4N
Cj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogU291cmFkZWVwIENoYWtyYWJhcnRpDQo+ID4+IDxz
Y2hha3JhYmFydGlAbGludXgubWljcm9zb2Z0LmNvbT4NCj4gPg0KPiA+V2hlcmUncyAiRml4ZXM6
IiB0YWdnaW5nIHRoZSBibGFtZWQgY29tbWl0Pw0KPiBUaGlzIGlzIHByZXNlbnQgZnJvbSB0aGUg
ZGF5IHplcm8gb2YgdGhlIG1hbmEgZHJpdmVyIGNvZGUuDQo+IEl0IGhhcyBub3QgYmVlbiBpbnRy
b2R1Y2VkIGluIHRoZSBjb2RlIGJ5IGFueSBjb21taXQuDQo+ID4NCj4gPj4gLS0tDQo+ID4+IFYz
IC0+IFY0Og0KPiA+PiAqIEZpeGVkIHRoZSBjb21taXQgbWVzc2FnZSB0byBkZXNjcmliZSB0aGUg
Y29udGV4dC4NCj4gPj4gKiBSZW1vdmVkIHRoZSB2Zl91bmxvYWRfdGltZW91dCwgYXMgaXQgaXMg
bm90IHJlcXVpcmVkLg0KPiA+PiAtLS0NCj4gPj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L21pY3Jv
c29mdC9tYW5hL21hbmFfZW4uYyB8IDI2DQo+ID4+ICsrKysrKysrKysrKysrKystLS0NCj4gPj4g
IDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+Pg0K
PiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9zb2Z0L21hbmEvbWFu
YV9lbi5jDQo+ID4+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9zb2Z0L21hbmEvbWFuYV9l
bi5jDQo+ID4+IGluZGV4IGE0OTllNDYwNTk0Yi4uZDI2ZjFkYTcwNDExIDEwMDY0NA0KPiA+PiAt
LS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb3NvZnQvbWFuYS9tYW5hX2VuLmMNCj4gPj4g
KysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9zb2Z0L21hbmEvbWFuYV9lbi5jDQo+ID4+
IEBAIC0yMzQ2LDcgKzIzNDYsMTAgQEAgc3RhdGljIGludCBtYW5hX2RlYWxsb2NfcXVldWVzKHN0
cnVjdA0KPiA+PiBuZXRfZGV2aWNlICpuZGV2KSAgew0KPiA+PiAgCXN0cnVjdCBtYW5hX3BvcnRf
Y29udGV4dCAqYXBjID0gbmV0ZGV2X3ByaXYobmRldik7DQo+ID4+ICAJc3RydWN0IGdkbWFfZGV2
ICpnZCA9IGFwYy0+YWMtPmdkbWFfZGV2Ow0KPiA+PiArCXVuc2lnbmVkIGxvbmcgdGltZW91dDsN
Cj4gPj4gIAlzdHJ1Y3QgbWFuYV90eHEgKnR4cTsNCj4gPj4gKwlzdHJ1Y3Qgc2tfYnVmZiAqc2ti
Ow0KPiA+PiArCXN0cnVjdCBtYW5hX2NxICpjcTsNCj4gPj4gIAlpbnQgaSwgZXJyOw0KPiA+Pg0K
PiA+PiAgCWlmIChhcGMtPnBvcnRfaXNfdXApDQo+ID4+IEBAIC0yMzYzLDE1ICsyMzY2LDMyIEBA
IHN0YXRpYyBpbnQgbWFuYV9kZWFsbG9jX3F1ZXVlcyhzdHJ1Y3QNCj4gPm5ldF9kZXZpY2UgKm5k
ZXYpDQo+ID4+ICAJICogdG8gZmFsc2UsIGJ1dCBpdCBkb2Vzbid0IG1hdHRlciBzaW5jZSBtYW5h
X3N0YXJ0X3htaXQoKSBkcm9wcyBhbnkNCj4gPj4gIAkgKiBuZXcgcGFja2V0cyBkdWUgdG8gYXBj
LT5wb3J0X2lzX3VwIGJlaW5nIGZhbHNlLg0KPiA+PiAgCSAqDQo+ID4+IC0JICogRHJhaW4gYWxs
IHRoZSBpbi1mbGlnaHQgVFggcGFja2V0cw0KPiA+PiArCSAqIERyYWluIGFsbCB0aGUgaW4tZmxp
Z2h0IFRYIHBhY2tldHMuDQo+ID4+ICsJICogQSB0aW1lb3V0IG9mIDEyMCBzZWNvbmRzIGZvciBh
bGwgdGhlIHF1ZXVlcyBpcyB1c2VkLg0KPiA+PiArCSAqIFRoaXMgd2lsbCBicmVhayB0aGUgd2hp
bGUgbG9vcCB3aGVuIGgvdyBpcyBub3QgcmVzcG9uZGluZy4NCj4gPj4gKwkgKiBUaGlzIHZhbHVl
IG9mIDEyMCBoYXMgYmVlbiBkZWNpZGVkIGhlcmUgY29uc2lkZXJpbmcgbWF4DQo+ID4+ICsJICog
bnVtYmVyIG9mIHF1ZXVlcy4NCj4gPj4gIAkgKi8NCj4gPj4gKw0KPiA+PiArCXRpbWVvdXQgPSBq
aWZmaWVzICsgMTIwICogSFo7DQo+ID4NCj4gPldoeSBub3QgaW5pdGlhbGl6ZSBpdCByaWdodCB3
aGVuIGRlY2xhcmluZz8NCj4gSSB3aWxsIGZpeCBpdCBpbiBuZXh0IHZlcnNpb24uDQo+ID4NCj4g
Pj4gIAlmb3IgKGkgPSAwOyBpIDwgYXBjLT5udW1fcXVldWVzOyBpKyspIHsNCj4gPj4gIAkJdHhx
ID0gJmFwYy0+dHhfcXBbaV0udHhxOw0KPiA+PiAtDQo+ID4+IC0JCXdoaWxlIChhdG9taWNfcmVh
ZCgmdHhxLT5wZW5kaW5nX3NlbmRzKSA+IDApDQo+ID4+ICsJCXdoaWxlIChhdG9taWNfcmVhZCgm
dHhxLT5wZW5kaW5nX3NlbmRzKSA+IDAgJiYNCj4gPj4gKwkJICAgICAgIHRpbWVfYmVmb3JlKGpp
ZmZpZXMsIHRpbWVvdXQpKSB7DQo+ID4+ICAJCQl1c2xlZXBfcmFuZ2UoMTAwMCwgMjAwMCk7PiAr
CQl9DQo+ID4+ICAJfQ0KPiA+DQo+ID4xMjAgc2Vjb25kcyBieSAyIG1zZWMgc3RlcCBpcyA2MDAw
MCBpdGVyYXRpb25zLCBieSAxIG1zZWMgaXMgMTIwMDAwDQo+ID5pdGVyYXRpb25zLiBJIGtub3cg
dXNsZWVwX3JhbmdlKCkgb2Z0ZW4gaXMgbXVjaCBsZXNzIHByZWNpc2UsIGJ1dCBzdGlsbC4NCj4g
PkRvIHlvdSByZWFsbHkgbmVlZCB0aGF0IG11Y2ggdGltZT8gSGFzIHRoaXMgYmVlbiBtZWFzdXJl
ZCBkdXJpbmcgdGhlIHRlc3RzDQo+ID50aGF0IGl0IGNhbiB0YWtlIHVwIHRvIDEyMCBzZWNvbmRz
IG9yIGlzIGl0IGp1c3Qgc29tZSByYW5kb20gdmFsdWUgdGhhdCAic2hvdWxkDQo+ID5iZSBlbm91
Z2giPw0KPiA+SWYgeW91IHJlYWxseSBuZWVkIDEyMCBzZWNvbmRzLCBJJ2Qgc3VnZ2VzdCB1c2lu
ZyBhIHRpbWVyIC8gZGVsYXllZCB3b3JrDQo+IGluc3RlYWQNCj4gPm9mIHdhc3RpbmcgcmVzb3Vy
Y2VzLg0KPiBIZXJlIHRoZSBpbnRlbnQgaXMgbm90IHdhaXRpbmcgZm9yIDEyMCBzZWNvbmRzLCBy
YXRoZXIgdGhhbiBhdm9pZCBjb250aW51ZQ0KPiBjaGVja2luZyB0aGUNCj4gcGVuZGluZ19zZW5k
cyAgb2YgZWFjaCB0eCBxdWV1ZXMgZm9yIGFuIGluZGVmaW5pdGUgdGltZSwgYmVmb3JlIGZyZWVp
bmcNCj4gc2tfYnVmZnMuDQo+IFRoZSBwZW5kaW5nX3NlbmRzIGNhbiBvbmx5IGdldCBkZWNyZWFz
ZWQgZm9yIGEgdHggcXVldWUsICBpZiBtYW5hX3BvbGxfdHhfY3EoKQ0KPiBnZXRzIGNhbGxlZCBm
b3IgYSBjb21wbGV0aW9uIG5vdGlmaWNhdGlvbiBhbmQgaW5jcmVhc2VkIGJ5IHhtaXQuDQo+IA0K
PiBJbiB0aGlzIHBhcnRpY3VsYXIgYnVnLCBhcGMtPnBvcnRfaXNfdXAgaXMgbm90IHNldCB0byBm
YWxzZSwgY2F1c2luZw0KPiB4bWl0IHRvIGtlZXAgaW5jcmVhc2luZyB0aGUgcGVuZGluZ19zZW5k
cyBmb3IgdGhlIHF1ZXVlIGFuZA0KPiBtYW5hX3BvbGxfdHhfY3EoKQ0KPiBub3QgZ2V0dGluZyBj
YWxsZWQgZm9yIHRoZSBxdWV1ZS4NCj4gDQo+IElmIHdlIHNlZSB0aGUgY29tbWVudCBpbiB0aGUg
ZnVuY3Rpb24gbWFuYV9kZWFsbG9jX3F1ZXVlcygpLCBpdCBtZW50aW9ucyBpdCA6DQo+IA0KPiAy
MzQ2ICAgICAvKiBObyBwYWNrZXQgY2FuIGJlIHRyYW5zbWl0dGVkIG5vdyBzaW5jZSBhcGMtPnBv
cnRfaXNfdXAgaXMgZmFsc2UuDQo+IDIzNDcgICAgICAqIFRoZXJlIGlzIHN0aWxsIGEgdGlueSBj
aGFuY2UgdGhhdCBtYW5hX3BvbGxfdHhfY3EoKSBjYW4gcmUtZW5hYmxlDQo+IDIzNDggICAgICAq
IGEgdHhxIGJlY2F1c2UgaXQgbWF5IG5vdCB0aW1lbHkgc2VlIGFwYy0+cG9ydF9pc191cCBiZWlu
ZyBjbGVhcmVkDQo+IDIzNDkgICAgICAqIHRvIGZhbHNlLCBidXQgaXQgZG9lc24ndCBtYXR0ZXIg
c2luY2UgbWFuYV9zdGFydF94bWl0KCkgZHJvcHMgYW55DQo+IDIzNTAgICAgICAqIG5ldyBwYWNr
ZXRzIGR1ZSB0byBhcGMtPnBvcnRfaXNfdXAgYmVpbmcgZmFsc2UuDQo+IA0KPiBUaGUgdmFsdWUg
MTIwIHNlY29uZHMgaGFzIGJlZW4gZGVjaWRlZCBoZXJlIGJhc2VkIG9uIG1heGltdW0gbnVtYmVy
IG9mDQo+IHF1ZXVlcw0KPiBhcmUgYWxsb3dlZCBpbiB0aGlzIHNwZWNpZmljIGhhcmR3YXJlLCBp
dCBpcyBhIHNhZmUgYXNzdW1wdGlvbi4NCg0KSSBhZ3JlZS4gQWxzbywgdGhpcyB3YWl0aW5nIHRp
bWUgaXMgdXN1YWxseSBtdWNoIHNob3J0ZXIgdGhhbiAxMjAgc2VjLiBUaGUgbG9uZyANCndhaXQg
b25seSBoYXBwZW5zIGluIHJhcmUgYW5kIHVuZXhwZWN0ZWQgTklDIEhXIG5vbi1yZXNwb25kaW5n
IGNhc2VzLiBUbyANCmZ1cnRoZXIgcmVkdWNlIHRoZSByZXNvdXJjZSBjb25zdW1wdGlvbiwgd2Ug
Y2FuIGRvdWJsZSB0aGUgdXNsZWVwX3JhbmdlKCkgDQp0aW1lIGluIGV2ZXJ5IGl0ZXJhdGlvbi4g
U28sIHRoZSBudW1iZXIgb2YgaXRlcmF0aW9ucyB3aWxsIGJlIGdyZWF0bHkgcmVkdWNlZCANCmJl
Zm9yZSByZWFjaGluZyAxMjAgc2VjLg0KDQpUaGFua3MsDQotIEhhaXlhbmcNCg==
