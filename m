Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B0A73EBDF
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jun 2023 22:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjFZUdC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 26 Jun 2023 16:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFZUdB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 26 Jun 2023 16:33:01 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020027.outbound.protection.outlook.com [52.101.56.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35B31A2;
        Mon, 26 Jun 2023 13:32:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9c+Hxvbpv6+dvSgJ5u+TU8PKcFlIkKS+rBuPf36hEOxqNeZGSh0fUgZ0SaMdfIGJqCN1BXPIGabw+EkleaFtR8BwsnkfJNfTFNU1Qxwa/Lw27MWYPcEUFbUtpQ/4qBwWGk/ANU4ZkWTjNv8AjMyirwkLiaZZgAcXWQAgr+FxVFT7EuZ+ZEBS0ytp15+NGZAdS//P2eb0fXYxE2THh90NrVjh7/j9/eoLT+Sp6xGzrS4Zg8pqoVFCcZRWPJ4Pjy4EFpVo6nkVZ1v3cwmVbiZFufD/wmQCmLWIyP3t2epRRBqqErhHzCV/RcPjwYo2Wgivz4ZWRJTS5VYRk0KNt7ayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1q9YAakoZNYP+v/hruehTGLmgH0oWtKPT1q3VyeXBw=;
 b=fG8jr5tm3zKDJlZMTV0gf01Vt1zPE6q03aJXZIadHWo/9g5MDW4GhcN4fJvrO/iiep+2nar46nY5Cqd06Qt0xZYXzxXQjWAGjnRjxv+VoFAnYLwSbUtphlp3H3PT5CrZuipDMzK4iycyj0C26NzFpslqxTQIO+qS70ZMxKuf26d6KrHkO36o/ItYYDbHT2KBdcDq0d5e6cV0BFqcoO1Wy6flCbzpiTqT3zlQxyHBpqxLtwIsUXkNBZ2rxZHhrvcxyGzG11CJHzuaY0qFXF9tPLpI1I47yF7r5sbfYb6AmD8NtIVM0eK3f/7g83gDcOzikR5cj7iAlZz+G45iYgm+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1q9YAakoZNYP+v/hruehTGLmgH0oWtKPT1q3VyeXBw=;
 b=IG6epqN6R5LNg/C8WbvHOfaHsRjRgscZi9FGnvsm2K+yyoBMTGSP+by+24TzF21/g8wURYWG/NqUu2seNOrbjgdlEts1F+xYTPY14B9XuYV1MzVaJxTW8mYCCj3kH+nYhmEEIsDt53o8W8Mwhv0LD2inWdrmUkcxvMdHUyWZh8E=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by DM4PR21MB3707.namprd21.prod.outlook.com (2603:10b6:8:af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.1; Mon, 26 Jun
 2023 20:32:55 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::848b:6d47:841d:20ff]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::848b:6d47:841d:20ff%4]) with mapi id 15.20.6544.006; Mon, 26 Jun 2023
 20:32:55 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        souradeep chakrabarti <schakrabarti@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
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
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Souradeep Chakrabarti <schakrabarti@microsoft.com>
Subject: RE: [PATCH 2/2 V3 net] net: mana: Fix MANA VF unload when host is
 unresponsive
Thread-Topic: [PATCH 2/2 V3 net] net: mana: Fix MANA VF unload when host is
 unresponsive
Thread-Index: AQHZqA9znbKK9TI41UWeQtXPI5JlLq+dIImAgABm5eA=
Date:   Mon, 26 Jun 2023 20:32:55 +0000
Message-ID: <PH7PR21MB31163E61E2B3DABD2533F09BCA26A@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1687771098-26775-1-git-send-email-schakrabarti@linux.microsoft.com>
 <1687771224-27162-1-git-send-email-schakrabarti@linux.microsoft.com>
 <578faf91-35e6-d946-d9ec-c949e57eadef@linux.microsoft.com>
In-Reply-To: <578faf91-35e6-d946-d9ec-c949e57eadef@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=de4712d4-d2ca-454d-8258-0ec26e5a9a14;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-26T20:21:23Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|DM4PR21MB3707:EE_
x-ms-office365-filtering-correlation-id: 4ede9cf8-957a-4cc0-3ea5-08db768485cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gSoON5ENIbyNgkxvbetrWFn1hTBPkMFCg8MEpum/AxCvXkq+av95fS9V21pc4KdxawBlYWkbUcFhMVIiqYLeYA3sHn6WBEZKFM87kjf3X6OYC/H79HecXVlXfoxN9oio50F8okXaazJcC9Fb15SR5+x2gZQpuq12xT6yJECfjCe7Mk8pX0waib0J7nL6psuFnr459FTWiRelAgeLEXIdE/Rk+K22EoWgpgaoDJR87qhQHLcsG6Wq49YXX+JTNcLOJ1qL3SWgaq6iLFWBr3tvLtw6wPNfo+uyPZLCeqeFq5Kc7fivdbFmm+uc5FaaoeGB3XlPI3+ZbAoUEyfWutBO9VeOHMte4S1wrOFqm2SDy/Qmr0owlQLajWyc78/mBCxoVLoY2wo/EyD8Ch6JFE/bwyHAn6P2CEcuTTTEME5vDIKQp/ATAc7m+hDp/q0yQuP29HqtEHT0R0Ul1j8Btnz1YK/L8VWB7zokVnLIBLJDEEVg+WC701ekikmcPczQyz5eaAGqDdR+g1qnKE7raKvRvnOWLilm3dEoEy9v/r5BkF9OaPuo45pL//oHPq6UGGfxnxknpm3YQ6Lt49vXVoeooAzWWrB/SM3vEw4RNeNSQxnFRVCx4JNXtghaVKRmwYT03TLYBpIqaF0VzTinppCG7iHF0I7vnvaYZE6vVRx7AGhbCRiUJFJLiHXR7zFPlEk8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(33656002)(921005)(8990500004)(7416002)(5660300002)(52536014)(86362001)(8936002)(8676002)(41300700001)(64756008)(4326008)(66556008)(55016003)(38100700002)(38070700005)(122000001)(316002)(66476007)(66946007)(76116006)(82950400001)(82960400001)(107886003)(6506007)(478600001)(53546011)(66446008)(9686003)(2906002)(186003)(26005)(83380400001)(7696005)(71200400001)(110136005)(54906003)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1lidlhGZXBFTFFqdnRnL01LWk9qZDV4YkxnbTJLeS9Gc0o1WVBiMCtUUVNw?=
 =?utf-8?B?eFd0WW9qaFVaUVF1QzB3OCtIUnhDdklpSXcvajF4OHdEeGN3cGNHZklxK3py?=
 =?utf-8?B?cWxDZnRRWkM5bG14anRCdDhsM0YxTXBsQVhGdHpWWVJDUU0yNHh2WnIycnhj?=
 =?utf-8?B?UGNpRFhMeXpMQUg4V3h1bW5TbkZEUU5DSnR0MXJRSHZrWms1dndWYlZVVGxV?=
 =?utf-8?B?dGprRWFuTnZUelI3Z0MvYUs3Mmc4ZU1VWGhGR0o0clFZd0poa1QrQk0rUHJQ?=
 =?utf-8?B?MDRvZGtaTDZPeXBFemdTeVR2QWFpNFZDc2pmdmhKUURycUxXWnZ6bFBubUQz?=
 =?utf-8?B?b0V1Z2ZMbEpPWDhEc2pFR0s5NEFuaG53a01CQTBleEx2bEdjWEF1ZUgxbzVj?=
 =?utf-8?B?aE9DY2xxNWE5aTF2RTV5dkRUQ0FkdVBQQ056Y3VWTStnUXlIeldCMXR5cXh0?=
 =?utf-8?B?Z0d2eVgzWVovSzgrY0hidzQ2UU9PeDdScktxMzdKVmRpUEQrcnZBLzIxVDB3?=
 =?utf-8?B?citIUHM2ODVQVFFkYmJuMzllbnpWbUNNUTFJckdmZHpQVUFyU3p5VXNFVS83?=
 =?utf-8?B?d3pyKys2dUthVUY3TTk2dkQ1cDhGcDA1dk1pVytHNUdhNE9EQjl3T2FZMk8x?=
 =?utf-8?B?L3BtSmIraEoycWdzV0lGSUoyWjFvOVhjSDM5Ynk2KytyengyTS9HZEhaNmRu?=
 =?utf-8?B?RS9oTW9YYVlmNjkwaEhXL09NUUswc25vVDl6bkVkNW9ZdE5NcDV1ZmNrb1la?=
 =?utf-8?B?Mk51d0gwS3RwVGluMjJEV0lRVStHQnVMSlZVRG5QaDlHZ3lhMmRwdkFqQThV?=
 =?utf-8?B?VWJqZFZDWVdmd0RIS2E4MlI1OVZnZU5iSmc4SG5EdHhZNnUwcWlsdTNYMlA2?=
 =?utf-8?B?cGJNQlRvb25YQlZ0VmlkckYrTENVc1BnWkNxc1BPM1ZsS21tN3BHR1JLV3VF?=
 =?utf-8?B?STJLcEtlKzNKZm9KRXFXc1VDVzd0U1hRQmE0WE4zWVRyZTEyRVVDblZ4QkFt?=
 =?utf-8?B?L2M2Y0d5dlVQcHZLeFhaMXhUSDJKcGNpMzNRTVBsOEhxTGNJUFVCVnZ0RE12?=
 =?utf-8?B?VVdMK1orRUp6UU1hQXhZcFBxK3A2Q0k5bGZMQUJJUnJlUWZmR0RCUmF5ejJQ?=
 =?utf-8?B?YXc3TmVzR1NEaXJBMkw1MkJQMy9CdjVYWUYrcW92dVZOWHNnM2hpWDR2c2hS?=
 =?utf-8?B?Uy8ra1M3bStoNnZlQTMrcStCZ0pIRDBMM2x0OHB3N0NpdTNtNWxvRFM3OFZY?=
 =?utf-8?B?T0dOMEdoNWxYSWNWR3lBRGF3d2w1MkNwWU1vS0tNQzQyTWF4dGVoa1hDOUR6?=
 =?utf-8?B?SytCa2NZRnZINFZvOWpMM0QrSUFyUXVBdUVReWwxZ3ZJMlFvM2pkRGN0dkhL?=
 =?utf-8?B?bUplN2VtU3FLUEI2c2kxQWd3UlNtYVZwRkI1M25zcW9NMkZtRHV2dVR6aXFv?=
 =?utf-8?B?MitpVmpjemZBYS9SbnlsMG1PNVJ1bXdJMGtBajNxUjZhYlRoSGlYRkFPYUI4?=
 =?utf-8?B?MDloNTMrZ0VEK0pmdDEraW9KNzZINzQ1aHJ5dndXaHBqTnQyR1ZCQ1RvNFpw?=
 =?utf-8?B?T2ZzN0hkTitmOXFsQmxxLzc5S2xwYTR2bWJCNGtXOXg4MkdRSVdDUUpUTGNS?=
 =?utf-8?B?aDZmRTIvbUVYWS8xdEZDWFo0TDdlMTBNeE1UOWRRVWZjMGtVclhVbnlRempK?=
 =?utf-8?B?eWY4cWlEK05USGQ0NGlJa3RDSXEzY29Hdk9xcTdZZVArR05LSmRqS0E0OXZo?=
 =?utf-8?B?YjJGbkE1SkFBRHJKcWU3T1FrT3dxNzVPRmhROWRYK3R1Z3orMGQ0cDVxTlNa?=
 =?utf-8?B?YURSYmtvZ2VzcHR4TVRSOER5c1dOWG5rMXBSeUxiMGEraUxtNHNJSmZlMGVo?=
 =?utf-8?B?cTlvMHVlZkx2cVJXWDRMc2loRCtBSGlJcnBmVDBtOUhWQlRqZGRNNGJacmUw?=
 =?utf-8?B?M0VtRmxob3lZYm9DVUlVMDlYRFpxdEp2N2IwT1BXYmZzR1NGTUUxRExyT09r?=
 =?utf-8?B?R20xZVVsUVAxc1hRaTIwUm0yTmZ6YjB0amVtRTkyUFRiN0R1LzJ0bDJVRVc4?=
 =?utf-8?B?VThMbzJVNE51NlI0TXNIZVZRYTRhbWZaZXBXcmhROGF1QXBUTkdXZFR4RERB?=
 =?utf-8?Q?H5JWaEOH+t+o0fQvWEykBAIKn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3116.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ede9cf8-957a-4cc0-3ea5-08db768485cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 20:32:55.5162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BP9IV8oby5JlGyiHUZi1Ik1XPFXTO1g8smcyxeAXvzi7Y7Z430fbeyf0/NFyDn4rvRIhkAYxqUNjhcMDm/UKjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3707
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUHJhdmVlbiBLdW1hciA8
a3VtYXJwcmF2ZWVuQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSnVuZSAy
NiwgMjAyMyAxMDoxMyBBTQ0KPiBUbzogc291cmFkZWVwIGNoYWtyYWJhcnRpIDxzY2hha3JhYmFy
dGlAbGludXgubWljcm9zb2Z0LmNvbT47IEtZIFNyaW5pdmFzYW4NCj4gPGt5c0BtaWNyb3NvZnQu
Y29tPjsgSGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT47DQo+IHdlaS5saXVA
a2VybmVsLm9yZzsgRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT47DQo+IGRhdmVtQGRh
dmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFi
ZW5pQHJlZGhhdC5jb207IExvbmcgTGkgPGxvbmdsaUBtaWNyb3NvZnQuY29tPjsgQWpheSBTaGFy
bWENCj4gPHNoYXJtYWFqYXlAbWljcm9zb2Z0LmNvbT47IGxlb25Aa2VybmVsLm9yZzsgY2FpLmh1
b3FpbmdAbGludXguZGV2Ow0KPiBzc2VuZ2FyQGxpbnV4Lm1pY3Jvc29mdC5jb207IHZrdXpuZXRz
QHJlZGhhdC5jb207IHRnbHhAbGludXRyb25peC5kZTsgbGludXgtDQo+IGh5cGVydkB2Z2VyLmtl
cm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnDQo+IENjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnOyBTb3VyYWRlZXAgQ2hha3JhYmFydGkNCj4gPHNjaGFrcmFiYXJ0aUBtaWNyb3Nv
ZnQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMiBWMyBuZXRdIG5ldDogbWFuYTogRml4
IE1BTkEgVkYgdW5sb2FkIHdoZW4gaG9zdCBpcw0KPiB1bnJlc3BvbnNpdmUNCj4gDQo+IE9uIDYv
MjYvMjAyMyAyOjUwIFBNLCBzb3VyYWRlZXAgY2hha3JhYmFydGkgd3JvdGU6DQo+ID4gRnJvbTog
U291cmFkZWVwIENoYWtyYWJhcnRpIDxzY2hha3JhYmFydGlAbGludXgubWljcm9zb2Z0LmNvbT4N
Cj4gPg0KPiA+IFRoaXMgaXMgdGhlIHNlY29uZCBwYXJ0IG9mIHRoZSBmaXguDQo+ID4NCj4gPiBB
bHNvIHRoaXMgcGF0Y2ggYWRkcyBhIG5ldyBhdHRyaWJ1dGUgaW4gbWFuYV9jb250ZXh0LCB3aGlj
aCBnZXRzIHNldCB3aGVuDQo+ID4gbWFuYV9od2Nfc2VuZF9yZXF1ZXN0KCkgaGl0cyBhIHRpbWVv
dXQgYmVjYXVzZSBvZiBob3N0IHVucmVzcG9uc2l2ZW5lc3MuDQo+ID4gVGhpcyBmbGFnIHRoZW4g
aGVscHMgdG8gYXZvaWQgdGhlIHRpbWVvdXRzIGluIHN1Y2Nlc3NpdmUgY2FsbHMuDQo+ID4NCj4g
PiBGaXhlczogY2E5YzU0ZDJkNmE1YWIyNDMwYzRlZGEzNjRjNzcxMjVkNjJlNWUwZiAobmV0OiBt
YW5hOiBBZGQgYQ0KPiBkcml2ZXIgZm9yDQo+ID4gTWljcm9zb2Z0IEF6dXJlIE5ldHdvcmsgQWRh
cHRlcikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBTb3VyYWRlZXAgQ2hha3JhYmFydGkgPHNjaGFrcmFi
YXJ0aUBsaW51eC5taWNyb3NvZnQuY29tPg0KPiA+IC0tLQ0KPiA+IFYyIC0+IFYzOg0KPiA+ICog
UmVtb3ZlZCB0aGUgaW5pdGlhbGl6YXRpb24gb2YgdmZfdW5sb2FkX3RpbWVvdXQNCj4gPiAqIFNw
bGl0dGVkIHRoZSBwYXRjaCBpbiB0d28uDQo+ID4gKiBGaXhlZCBleHRyYSBzcGFjZSBmcm9tIHRo
ZSBjb21taXQgbWVzc2FnZS4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWlj
cm9zb2Z0L21hbmEvZ2RtYV9tYWluLmMgIHwgIDQgKysrLQ0KPiA+ICBkcml2ZXJzL25ldC9ldGhl
cm5ldC9taWNyb3NvZnQvbWFuYS9od19jaGFubmVsLmMgfCAxMiArKysrKysrKysrKy0NCj4gPiAg
aW5jbHVkZS9uZXQvbWFuYS9tYW5hLmggICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKysN
Cj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21pY3Jvc29mdC9tYW5h
L2dkbWFfbWFpbi5jDQo+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9zb2Z0L21hbmEvZ2Rt
YV9tYWluLmMNCj4gPiBpbmRleCA4ZjNmNzhiNjg1OTIuLjY0MTFmMDFiZTBkOSAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb3NvZnQvbWFuYS9nZG1hX21haW4uYw0K
PiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21pY3Jvc29mdC9tYW5hL2dkbWFfbWFpbi5j
DQo+ID4gQEAgLTk0NiwxMCArOTQ2LDEyIEBAIGludCBtYW5hX2dkX2RlcmVnaXN0ZXJfZGV2aWNl
KHN0cnVjdCBnZG1hX2Rldg0KPiAqZ2QpDQo+ID4gIAlzdHJ1Y3QgZ2RtYV9jb250ZXh0ICpnYyA9
IGdkLT5nZG1hX2NvbnRleHQ7DQo+ID4gIAlzdHJ1Y3QgZ2RtYV9nZW5lcmFsX3Jlc3AgcmVzcCA9
IHt9Ow0KPiA+ICAJc3RydWN0IGdkbWFfZ2VuZXJhbF9yZXEgcmVxID0ge307DQo+ID4gKwlzdHJ1
Y3QgbWFuYV9jb250ZXh0ICphYzsNCj4gPiAgCWludCBlcnI7DQo+ID4NCj4gPiAgCWlmIChnZC0+
cGRpZCA9PSBJTlZBTElEX1BESUQpDQo+ID4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gKwlhYyA9
IGdkLT5kcml2ZXJfZGF0YTsNCj4gPg0KPiA+ICAJbWFuYV9nZF9pbml0X3JlcV9oZHIoJnJlcS5o
ZHIsIEdETUFfREVSRUdJU1RFUl9ERVZJQ0UsDQo+IHNpemVvZihyZXEpLA0KPiA+ICAJCQkgICAg
IHNpemVvZihyZXNwKSk7DQo+ID4gQEAgLTk1Nyw3ICs5NTksNyBAQCBpbnQgbWFuYV9nZF9kZXJl
Z2lzdGVyX2RldmljZShzdHJ1Y3QgZ2RtYV9kZXYgKmdkKQ0KPiA+ICAJcmVxLmhkci5kZXZfaWQg
PSBnZC0+ZGV2X2lkOw0KPiA+DQo+ID4gIAllcnIgPSBtYW5hX2dkX3NlbmRfcmVxdWVzdChnYywg
c2l6ZW9mKHJlcSksICZyZXEsIHNpemVvZihyZXNwKSwgJnJlc3ApOw0KPiA+IC0JaWYgKGVyciB8
fCByZXNwLmhkci5zdGF0dXMpIHsNCj4gPiArCWlmICgoZXJyIHx8IHJlc3AuaGRyLnN0YXR1cykg
JiYgIWFjLT52Zl91bmxvYWRfdGltZW91dCkgew0KPiA+ICAJCWRldl9lcnIoZ2MtPmRldiwgIkZh
aWxlZCB0byBkZXJlZ2lzdGVyIGRldmljZTogJWQsIDB4JXhcbiIsDQo+ID4gIAkJCWVyciwgcmVz
cC5oZHIuc3RhdHVzKTsNCj4gDQo+IFdpdGggIWFjLT52Zl91bmxvYWRfdGltZW91dCBvcHRpb24s
IHRoaXMgbWVzc2FnZSBtYXkgbm90IGJlIGNvcnJlY3RseQ0KPiBzaG93aW5nIGVyciwgc3RhdHVz
LiBQcm9iYWJseSB5b3Ugd2FudCB0byBhZGQgZXhwbGljaXQgaW5mb3JtYXRpb24gZHVyaW5nDQo+
IHRpbWVvdXRzIHNvIHRoYXQgaXQgZ2l2ZSByaWdodCBpbmZvcm1hdGlvbiA/IE9yIGhhdmUgdGhl
IGVyciwgc3RhdHVzIGZpZWxkIHByb3Blcmx5DQo+IHVwZGF0ZWQuDQo+IA0KPiA+ICAJCWlmICgh
ZXJyKQ0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb3NvZnQvbWFu
YS9od19jaGFubmVsLmMNCj4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb3NvZnQvbWFuYS9o
d19jaGFubmVsLmMNCj4gPiBpbmRleCA5ZDE1MDdlYmE1YjkuLjQ5MmNiMmM2ZTJjYiAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb3NvZnQvbWFuYS9od19jaGFubmVs
LmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9taWNyb3NvZnQvbWFuYS9od19jaGFu
bmVsLmMNCj4gPiBAQCAtMSw4ICsxLDEwIEBADQo+ID4gIC8vIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wIE9SIEJTRC0zLUNsYXVzZQ0KPiA+ICAvKiBDb3B5cmlnaHQgKGMpIDIwMjEs
IE1pY3Jvc29mdCBDb3Jwb3JhdGlvbi4gKi8NCj4gPg0KPiA+ICsjaW5jbHVkZSAiYXNtLWdlbmVy
aWMvZXJybm8uaCINCj4gPiAgI2luY2x1ZGUgPG5ldC9tYW5hL2dkbWEuaD4NCj4gPiAgI2luY2x1
ZGUgPG5ldC9tYW5hL2h3X2NoYW5uZWwuaD4NCj4gPiArI2luY2x1ZGUgPG5ldC9tYW5hL21hbmEu
aD4NCj4gPg0KPiA+ICBzdGF0aWMgaW50IG1hbmFfaHdjX2dldF9tc2dfaW5kZXgoc3RydWN0IGh3
X2NoYW5uZWxfY29udGV4dCAqaHdjLCB1MTYNCj4gKm1zZ19pZCkNCj4gPiAgew0KPiA+IEBAIC03
ODYsMTIgKzc4OCwxOSBAQCBpbnQgbWFuYV9od2Nfc2VuZF9yZXF1ZXN0KHN0cnVjdA0KPiBod19j
aGFubmVsX2NvbnRleHQgKmh3YywgdTMyIHJlcV9sZW4sDQo+ID4gIAlzdHJ1Y3QgaHdjX3dxICp0
eHEgPSBod2MtPnR4cTsNCj4gPiAgCXN0cnVjdCBnZG1hX3JlcV9oZHIgKnJlcV9tc2c7DQo+ID4g
IAlzdHJ1Y3QgaHdjX2NhbGxlcl9jdHggKmN0eDsNCj4gPiArCXN0cnVjdCBtYW5hX2NvbnRleHQg
KmFjOw0KPiA+ICAJdTMyIGRlc3RfdnJjcSA9IDA7DQo+ID4gIAl1MzIgZGVzdF92cnEgPSAwOw0K
PiA+ICAJdTE2IG1zZ19pZDsNCj4gPiAgCWludCBlcnI7DQo+ID4NCj4gPiAgCW1hbmFfaHdjX2dl
dF9tc2dfaW5kZXgoaHdjLCAmbXNnX2lkKTsNCj4gPiArCWFjID0gaHdjLT5nZG1hX2Rldi0+ZHJp
dmVyX2RhdGE7DQo+IA0KPiBJcyB0aGVyZSBhIGNhc2Ugd2hlcmUgZ2RtYV9kZXYgYmUgaW52YWxp
ZCBoZXJlID8gSWYgc28sIGxldHMgY2hlY2sgdGhlIHN0YXRlIGFuZA0KPiB0aGVuIHByb2NlZWQg
ZnVydGhlciA/DQoNClllcywgaHdjLT5nZG1hX2RldiBpcyBhc3NpZ25lZCBzaG9ydGx5IGFmdGVy
IGl0J3MgYWxsb2NhdGVkIC0gc2VlIHRoZSBjb2RlIGJlbG93LiBTbw0KaXQncyB2YWxpZC4NCkJ1
dCBod2MtPmdkbWFfZGV2LT5kcml2ZXJfZGF0YSBpcyBod2MsIG5vdCAibWFuYV9jb250ZXh0ICph
YyIuIFRoZXJlIGFyZSB0d28gDQpnZG1hX2RldiBpbiBnZG1hX2NvbnRleHQ6IGh3YyAmIG1hbmEu
DQoNCllvdSBjYW4gZ2V0IGFjIGZyb206IGh3Yy0+Z2RtYV9kZXYtPmdkbWFfY29udGV4dC0+bWFu
YS5kcml2ZXJfZGF0YQ0KT3IsIHRvIGF2b2lkIHRvbyBtYW55IHBvaW50ZXIgZGVmZXJlbmNlLCBJ
IHN1Z2dlc3QgdG8gcHV0IHRoZSB2Zl91bmxvYWRfdGltZW91dCANCmludG8gZ2RtYV9jb250ZXh0
Lg0KDQppbnQgbWFuYV9od2NfY3JlYXRlX2NoYW5uZWwoc3RydWN0IGdkbWFfY29udGV4dCAqZ2Mp
DQp7DQogICAgICAgIGh3YyA9IGt6YWxsb2Moc2l6ZW9mKCpod2MpLCBHRlBfS0VSTkVMKTsNCi4u
Lg0KICAgICAgICBnZC0+Z2RtYV9jb250ZXh0ID0gZ2M7DQogICAgICAgIGdkLT5kcml2ZXJfZGF0
YSA9IGh3YzsNCiAgICAgICAgaHdjLT5nZG1hX2RldiA9IGdkOw0KICAgICAgICBod2MtPmRldiA9
IGdjLT5kZXY7DQoNCg0KQWxzbywgbWFuYV9nZF9zZW5kX3JlcXVlc3QvbWFuYV9od2Nfc2VuZF9y
ZXF1ZXN0KCkgaXMgdXNlZCBpbiBtYW55IHBsYWNlcywNCm5vdCBqdXN0IHVubG9hZGluZy4NClNo
b3VsZCB5b3UgdXNlIHRpbWVvdXQgdmFsdWUgNSBzZWMsIGFuZCB0aGUgdmZfdW5sb2FkX3RpbWVv
dXQgZmxhZyBpbiB1bmxvYWRpbmcNCnBhdGggb25seSwgYW5kIGF2b2lkIHRvdWNoaW5nIG90aGVy
IGNvZGUgcGF0aHM/IFBsZWFzZSBjaGVjayB3aXRoIGhvc3RuZXQgdGVhbSBmb3INCnN1Z2dlc3Rp
b25zLg0KDQpJZiB3ZSBkZWNpZGUgdG8gbGV0IHRoZSB2Zl91bmxvYWRfdGltZW91dCBmbGFnIGFm
ZmVjdCBhbGwgY29kZSBwYXRocywgbm90IGp1c3QgDQp1bmxvYWRpbmcsIHRoZW4gaXQgc2hvdWxk
IGJlIHJlbmFtZWQgdG8gaHdjX3RpbWVvdXQsIGFuZCBzdWJtaXQgdGhlIHNlY29uZCBwYXRjaA0K
c2VwYXJhdGVseS4NCklmIGp1c3QgdXNlIGl0IGZvciB1bmxvYWRpbmcsIHNpbmNlIG1hbmFfZ2Rf
ZGVyZWdpc3Rlcl9kZXZpY2UoKSBpcyB1c2VkIGJ5IFBGIHRvbywgDQpuYW1lIGl0IGxpa2U6IHVu
bG9hZF9od2NfdGltZW91dC4NCg0KVGhhbmtzLA0KLUhhaXlhbmcNCg0KDQo=
