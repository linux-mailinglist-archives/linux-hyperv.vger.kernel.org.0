Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB38616D72
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Nov 2022 20:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiKBTHi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Nov 2022 15:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbiKBTHP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Nov 2022 15:07:15 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11020025.outbound.protection.outlook.com [52.101.51.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E615CE36;
        Wed,  2 Nov 2022 12:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ic+86Bzezn0ZmNYjaq0+JpTZL3YMS+lqyRgHPUuHUuIUm/bohSefOHjrVlfW2fEO6CRvRjANwJWHN6wf6+MQQ0C4arfpA6CbAWLTvm6w3nQIjRH3J9gTlCmsdHx0R8CZ6INMmL7AfHvaoYz6389lahgVCyC8bavoF5KGjpzijSg/gFidMPG4jvJWSGWJGiTItZvfDF8RljhfLqSIl7NZkJ338K8pfNV9FH7IE4YRJSDP0q1aoMHXq4G6bCEFZwq10ojT8rCbmYwvz9i1CSZ+yNpgYqs6BdqiN+i41CELIKC1z+JnTcI/YVIN6wI4bcubpF5UMV8WzHOO469MC7Kcpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmCa7tW4Fyash/CTNYlqoSzAOAmZxwRJMG9t3KhPD3s=;
 b=f0wHdDk+sHhkZTbfbcCcing7IqyQI8JKBjrabEPHi95mXIoLtvIZGHlvx9PqrNKJY/ILZONDVopWL6HT4AWI/K+EyFz9Lzk0JHxDlQTwnFdZ2UNBnuZPI4atB4/KIiO6fnNlI2MIvaXGwQRNfJEdEo+wyOWU2YGFvNmDaVBfwH2IYTqhXNRewJ2lZdd1suS9hDd4rcrqdpYt2MgjJF+10Z0lL6g9DHhZW0Vi2li2tWkK2ZYvq/Yps7iZ1iKpdBVANsh3vdgmhrW7Uy0jB5dQWxG7TGohttAtTDItWfh5Ffp+5PkP+VurnqR6S0sHnoyYliB1yHIjGwDNcuKjLuulcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmCa7tW4Fyash/CTNYlqoSzAOAmZxwRJMG9t3KhPD3s=;
 b=bxxJwyNQl5sQuMnDbG+rU6wVg/BVZpcpBJcV9LqqiVyHQ8+9UDcUmd0I5svMMqbHnSIoigUGsKqfvLLOML7XruQwaelzBTdBd0vGeB/blo47WOSWb7T1BTKz6ILejEPXDJxmhNmJiNK+f0wfsEIfAXJp82IdQibxPr27OgklTeE=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3105.namprd21.prod.outlook.com (2603:10b6:8:61::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.4; Wed, 2 Nov
 2022 19:06:59 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.004; Wed, 2 Nov 2022
 19:06:59 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC:     Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] drivers/clocksource/hyper-v: Introduce TSC MSR
 register structure
Thread-Topic: [PATCH 2/4] drivers/clocksource/hyper-v: Introduce TSC MSR
 register structure
Thread-Index: AQHY7hfGdFg8W+TW4UePjgHc2LBts64r/kcQ
Date:   Wed, 2 Nov 2022 19:06:59 +0000
Message-ID: <BYAPR21MB1688C426F44E40E1415DCD21D7399@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <166732356767.9827.4925884794177179249.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <166732386986.9827.12356845572628674464.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: <166732386986.9827.12356845572628674464.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e711509c-b112-4000-960e-fda98246dad4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-02T18:59:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3105:EE_
x-ms-office365-filtering-correlation-id: ef34b515-4feb-4fdf-66b4-08dabd056b0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NmEH4LVD3oIiY2owr8dA1jAFhqWdYhUhsYUA15LfSK8YvRjcvRYtbftpAoc0tNc0hAXGLza545JtDs5Fz61oLT7W7ZsMW6vBYLiEfOLC/0RePsqhny3XiSP4e03sK064bhKMIvUVktlj64B6QMc1W0ofeMvcYxuJAAm0aMgUNOGamjNi0Wop0xgtGgPnFYHR4aW7YL7E4BXk0Stv2E7uJ1sqUNQMQ0ckYZjlOJt3uMbHvACkuGv87EOOhEy4wCc2voSZbeWsCMJ039qJk6fldIBsBhlqu+XXjXqQ1PIfrCd/KKP21CzipDx9y8ipbmD8BfEZnk+PB05WcRWSRBZDtS3IPz+lKFKpyrnmIq4MWqkjpJyN7shU3h17Kf6dR2j5wqG43bYO/S5rnNBwVutpLjQehrKJaqGV8/jSyZu5hCTB2H/xyCo3sN2mXnepRG4JY6PJu7RoklrSC6apx4QnqeZ8gdON+6uQwq4kuwmNezm0YhqMIXnpPuVmy2zytc6uZPdM6TljocnQQCz5bBG71acELaG7zBfYqPgDhmedsrXSeQ2pibKTlSgP0ssxCq0YapJCfnEmjUeaCf6N5FL4e0SbYXCP3+OxdIGFiLyo81O0pbdUilOO1ITworJkuGVCeSrPUnzYT3zPa42VxkuUYFJQl+Q1OfB9dmwS4gPnJwWQ9KTrwUnc/+uPDCkj4br5JEdVjS3hVNybE+IoCwARHUTdAuohY0/6MOy1AlEY75DdVzWnjLZLrWkvo1bP1VfLjhyVw/BYg6mej5nZudYW55VAvG1hlywtge2L1clA4KzCwMAmc9cZzNAh1tzDUXOs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199015)(55016003)(83380400001)(316002)(33656002)(186003)(82960400001)(82950400001)(2906002)(66446008)(6862004)(38070700005)(5660300002)(52536014)(8936002)(66556008)(4326008)(38100700002)(66946007)(66476007)(64756008)(76116006)(122000001)(8676002)(478600001)(71200400001)(10290500003)(6506007)(8990500004)(54906003)(7696005)(41300700001)(26005)(9686003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmF1SEpSZXlDZWtJbEZsUU1OWHVUTTRuUktkdHUwSFY1NS9XSXp3T3h0dDVw?=
 =?utf-8?B?aW95Zkk3SDdaY01kTTdyQkpjam1FNXh3K2UxeW02MVpTeU5OR3BsRDFDZGFp?=
 =?utf-8?B?aDBMWWNYV0ZSb1ZBcmNrYll2TTJRTDRnazhmeGlBbjZPM3BGcWpGWkNYVERk?=
 =?utf-8?B?Z0VycXNtNU1IWHR1UFE2aEtRWEV4eWxiU1JNbGpHQWppb1RFWVh0aFpQOFVl?=
 =?utf-8?B?eW5NY0d2dkVBTWxMK084U0thdVM4ZUxmZWFIZUhaWWlHUEhCYW5MWGpaYzhX?=
 =?utf-8?B?RDZzbDdTcjhZcnUzMUJxaTRLWDZKcm9wVjg0MkxBRk1CdnoxS28vMEpZNjJC?=
 =?utf-8?B?NGpKcmhQNVNROTRkd2hYdkZDZElvczRtZVczWWdYV0dJbnhJNU9KU0xxN0gx?=
 =?utf-8?B?U1hGMVozM3k4VlMvbjZZalVJMS81eUIxb3pjbG4rWjlkMGJRakc0bEovYzZB?=
 =?utf-8?B?MVQwaHM1cFlLelFiWjdzdldrejUwTENIUjNUVjVxMVVadlQrTUNrQ1lzcnFW?=
 =?utf-8?B?dXM2ZzdqNXlpYm9UWFNaQjlBelErTHVoenlUMmMvZzg0clF2OEVjazZkaTc5?=
 =?utf-8?B?MkJBcm5pWmxKU05UdFB6a09qVzZ1RHBEbSt0L1VjQUdYczlrTkR4clNSeGJK?=
 =?utf-8?B?WkhnMVN6bVJGdVZwZ3pwY2ZNTldBNk1zWkVJYktpYTRmeG1sV20yMThtSFhF?=
 =?utf-8?B?MFY5dGk2Zk03cXRIUFQ0LzhOVnVPemQwRHNTZzk0UWxFVm5kMGVrMjhEYUNX?=
 =?utf-8?B?cU1MK3pza1N2VE9TZmhubFBCcFBTZTZ0YW5YQ0FPTks3a2dpMHVtajZKNmNx?=
 =?utf-8?B?a282SG0xS1MvcC9nV0Zmb0ZacE4xdUdxWTlVVWJDeGJ5NnU4TzVoeHAvZ09C?=
 =?utf-8?B?bnNHTTdjMG4yaVpLQWQzK3dOY0I3ZTVDL2ZxWWhjY29zdmp5MXREdEpIZytW?=
 =?utf-8?B?L3FXUVJmRFVCTWEwMHoxTEZCdUdZbUMxazhGcG9JbUlKdjArNkdhMHNoSWNZ?=
 =?utf-8?B?a01iVkhUN3Q3Nkx5TzNrbmtUbmpaejI3cDB6SVBYTjZOL3ZYTFVrcUlKNGxW?=
 =?utf-8?B?TlpWLzVOVjRvUnk5Y3R4UE9VWlFJb0NuajVBdkN1SHlCMUhWK2JqalVySmNk?=
 =?utf-8?B?TlR2N1NFMTlLUmRpSEpFMHlNaEliZEllNnBBeGUzU3RiMXdITmJOTHBIdnRp?=
 =?utf-8?B?NldRM29tOW5RTG1BeWVTZnR2ajBHS2VuTTFybFlGSGFSbUgvcWhVRlRydThH?=
 =?utf-8?B?cWxyUlhkdTN4T3hYN2dJeTVkcW9LWEhFeDZjR3RNdkxkdTdjelMvZ1RveGtJ?=
 =?utf-8?B?TVR4cmNUY3RYUFJ6V0hBYjA1K2h1RUVHOCsybS84VTlzV0dCcFZsMncyS3dJ?=
 =?utf-8?B?NVMvcDR2M2RYQ2c3T05pVWNtUGJyZXp0RHRXKyswWmRvalc2MFdMOCtPbXl3?=
 =?utf-8?B?MVRtMiszNVNBWjdDMlk0Y0xlaUsvclEzbjh4TU90K3RCZ2w0MTBTeEpqRzNh?=
 =?utf-8?B?NjdERHRYV0YyU0FLT2o3cTlnWnBoMzVXVG90cVZCVmpTZ0FKM09BemYrWnk3?=
 =?utf-8?B?S2JHYU9vTjZYd0pSMjdPQTRidmJuSWZFeThkNHM2MUtWbVdmQTRiVDFWZytM?=
 =?utf-8?B?UEVFc1AyUEFwdHNyTzNGMmNrSUNyUHJWaDlNOE5qWVZiWkphcGhlb1d0eDdj?=
 =?utf-8?B?cy9NSm1GVFB4TkY0c3R4aVlidVl1Ym9PcGFsR1orUXV6Z3hocnd0NGlhcDRr?=
 =?utf-8?B?MDhZMXBKZU9hY0tWMCtHdUFYeCtJSFpoMHQ0RjdoL3p0QUdnOE5CRGwvc1B5?=
 =?utf-8?B?ZlVpcHNEM2dQdUUwMStteXI4cHBmc0FoaVA3NU1jd2JYaFJER1g4NXNRVW1i?=
 =?utf-8?B?QnRYeXZETW1LNTBnbE8rSmZBdkZIaEFCcmNvV1FxTnVLeW5yWWRWK0xFdE5J?=
 =?utf-8?B?bFA1bFpHV28yY3V5L3pzMlRhamJpd2xKVVBSQXdhMFBiZnVmTjBqSVNNT0xG?=
 =?utf-8?B?Z3VrRlNid083RDU0azdqdFRmc3pXdE1oNzg4RDU5ZURFRElGV3RLUlVsV3pR?=
 =?utf-8?B?UXVOS2xhOGcvYUVvYzdDVkl3OGpzNXIvdFpEdlN6QXEyTy9YeklmK3Q5OHlM?=
 =?utf-8?B?WmlPWWN3T1pKbGRFbUV6T1hDcVVrYVZ6UVpWQWk2dk8zOC9obzZYeWtLaFIx?=
 =?utf-8?B?VGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef34b515-4feb-4fdf-66b4-08dabd056b0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 19:06:59.4495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Yedap/DsZAm3596aJZqoMxZc24d/fu74kpWuNWG6lGPdx588xj67HrTGWocpJ3kjqb6xSXoA6X8gNXhO8aB2p71hrDwc0V1w5ohEdS19JY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3105
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMSwgMjAyMiAxMDozMSBBTQ0KPiANCj4gQW5k
IHJld29yayB0aGUgY29kZSB0byB1c2UgaXQgaW5zdGVhZCBvZiB0aGUgcGh5c2ljYWwgYWRkcmVz
cy4NCj4gVGhpcyBpcyBhIGNsZWFudXAgYW5kIHByZWN1cnNvciBwYXRjaCBmb3IgdXBjb21pbmcg
c3VwcG9ydCBmb3IgVFNDIHBhZ2UNCj4gbWFwcGluZyBpbnRvIGh5cGVyLXYgcm9vdCBwYXJ0aXRp
b24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTdGFuaXNsYXYgS2luc2J1cnNraXkgPHN0YW5pc2xh
di5raW5zYnVyc2tpeUBnbWFpbC5jb20+DQo+IENDOiAiSy4gWS4gU3Jpbml2YXNhbiIgPGt5c0Bt
aWNyb3NvZnQuY29tPg0KPiBDQzogSGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNv
bT4NCj4gQ0M6IFdlaSBMaXUgPHdlaS5saXVAa2VybmVsLm9yZz4NCj4gQ0M6IERleHVhbiBDdWkg
PGRlY3VpQG1pY3Jvc29mdC5jb20+DQo+IENDOiBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNh
bm9AbGluYXJvLm9yZz4NCj4gQ0M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRl
Pg0KPiBDQzogbGludXgtaHlwZXJ2QHZnZXIua2VybmVsLm9yZw0KPiBDQzogbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0KPiAtLS0NCj4gIGRyaXZlcnMvY2xvY2tzb3VyY2UvaHlwZXJ2X3Rp
bWVyLmMgfCAgIDE0ICsrKysrKysrKy0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xvY2tz
b3VyY2UvaHlwZXJ2X3RpbWVyLmMgYi9kcml2ZXJzL2Nsb2Nrc291cmNlL2h5cGVydl90aW1lci5j
DQo+IGluZGV4IGM0ZGJmNDBhM2QzZS4uZDQ0N2JjOTlhMzk5IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2Nsb2Nrc291cmNlL2h5cGVydl90aW1lci5jDQo+ICsrKyBiL2RyaXZlcnMvY2xvY2tzb3Vy
Y2UvaHlwZXJ2X3RpbWVyLmMNCj4gQEAgLTM2Nyw2ICszNjcsMTIgQEAgc3RhdGljIHVuaW9uIHsN
Cj4gIH0gdHNjX3BnIF9fYWxpZ25lZChQQUdFX1NJWkUpOw0KPiANCj4gIHN0YXRpYyBzdHJ1Y3Qg
bXNfaHlwZXJ2X3RzY19wYWdlICp0c2NfcGFnZSA9ICZ0c2NfcGcucGFnZTsNCj4gK3N0YXRpYyB1
bnNpZ25lZCBsb25nIHRzY19wZm47DQo+ICsNCj4gK3N0YXRpYyB1bnNpZ25lZCBsb25nIGh2X2dl
dF90c2NfcGZuKHZvaWQpDQo+ICt7DQo+ICsJcmV0dXJuIHRzY19wZm47DQo+ICt9DQoNCkl0IG1h
a2VzIHNlbnNlIHRvIGhhdmUgdGhlIHRzY19wYWdlIGdsb2JhbCB2YXJpYWJsZSBzbyB0aGF0IHdl
IGNhbg0KaGFuZGxlIHRoZSByb290IHBhcnRpdGlvbiBhbmQgZ3Vlc3QgcGFydGl0aW9uIGNhc2Vz
IHdpdGggY29tbW9uIGNvZGUsDQpldmVuIHRob3VnaCB0aGUgVFNDIHBhZ2UgbWVtb3J5IG9yaWdp
bmF0ZXMgZGlmZmVyZW50bHkgaW4gdGhlIHR3byBjYXNlcy4NCg0KQnV0IGRvIHdlIGFsc28gbmVl
ZCBhIHRzY19wZm4gZ2xvYmFsIHZhcmlhYmxlIGFuZCBnZXR0ZXIgZnVuY3Rpb24/ICBXaGVuDQp0
aGUgUEZOIGlzIG5lZWRlZCwgY29udmVyc2lvbiBmcm9tIHRoZSB0c2NfcGFnZSB2aXJ0dWFsIGFk
ZHJlc3MgdG8gdGhlIFBGTg0KaXNuJ3QgaGFyZCwgYW5kIHN1Y2ggYSBjb252ZXJzaW9uIGlzIG5l
ZWRlZCBpbiBvbmx5IGEgY291cGxlIG9mIHBsYWNlcy4gIFRvIG1lLA0KaXQncyBzaW1wbGVyIHRv
IGtlZXAgYSBzaW5nbGUgZ2xvYmFsIHZhcmlhYmxlIGFuZCBnZXR0ZXIgZnVuY3Rpb24gKGkuZS4s
DQpodl9nZXRfdHNjX3BhZ2UpLCBhbmQgZG8gdGhlIGNvbnZlcnNpb25zIHdoZXJlIG5lZWRlZC4g
ICBBZGRpbmcgdHNjX3Bmbg0KYW5kIHRoZSBnZXR0ZXIgZnVuY3Rpb24gaW50cm9kdWNlcyBhIGZh
aXIgYW1vdW50IG9mIGNvZGUgY2h1cm4gZm9yIG5vdCBtdWNoDQpiZW5lZml0LiAgSXQncyBhIGp1
ZGdtZW50IGNhbGwsIGJ1dCB0aGF0J3MgbXkgJC4wMi4NCg0KSSB0aGluayB0aGlzIG1heSBiZSB0
aGUgc2FtZSBhcyB3aGF0IEFuaXJ1ZGggaXMgc2F5aW5nIGluIGhpcyBjb21tZW50cyBvbg0KUGF0
Y2ggNC80IGluIHRoaXMgc2VyaWVzLg0KDQpNaWNoYWVsDQoNCj4gDQo+ICBzdHJ1Y3QgbXNfaHlw
ZXJ2X3RzY19wYWdlICpodl9nZXRfdHNjX3BhZ2Uodm9pZCkNCj4gIHsNCj4gQEAgLTQwOCwxMyAr
NDE0LDEyIEBAIHN0YXRpYyB2b2lkIHN1c3BlbmRfaHZfY2xvY2tfdHNjKHN0cnVjdCBjbG9ja3Nv
dXJjZSAqYXJnKQ0KPiANCj4gIHN0YXRpYyB2b2lkIHJlc3VtZV9odl9jbG9ja190c2Moc3RydWN0
IGNsb2Nrc291cmNlICphcmcpDQo+ICB7DQo+IC0JcGh5c19hZGRyX3QgcGh5c19hZGRyID0gdmly
dF90b19waHlzKHRzY19wYWdlKTsNCj4gIAl1bmlvbiBodl9yZWZlcmVuY2VfdHNjX21zciB0c2Nf
bXNyOw0KPiANCj4gIAkvKiBSZS1lbmFibGUgdGhlIFRTQyBwYWdlICovDQo+ICAJdHNjX21zci5h
c191aW50NjQgPSBodl9nZXRfcmVnaXN0ZXIoSFZfUkVHSVNURVJfUkVGRVJFTkNFX1RTQyk7DQo+
ICAJdHNjX21zci5lbmFibGUgPSAxOw0KPiAtCXRzY19tc3IucGZuID0gX19waHlzX3RvX3Bmbihw
aHlzX2FkZHIpOw0KPiArCXRzY19tc3IucGZuID0gdHNjX3BmbjsNCj4gIAlodl9zZXRfcmVnaXN0
ZXIoSFZfUkVHSVNURVJfUkVGRVJFTkNFX1RTQywgdHNjX21zci5hc191aW50NjQpOw0KPiAgfQ0K
PiANCj4gQEAgLTQ5OCw3ICs1MDMsNiBAQCBzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQgaHZf
c2V0dXBfc2NoZWRfY2xvY2sodm9pZA0KPiAqc2NoZWRfY2xvY2spIHt9DQo+ICBzdGF0aWMgYm9v
bCBfX2luaXQgaHZfaW5pdF90c2NfY2xvY2tzb3VyY2Uodm9pZCkNCj4gIHsNCj4gIAl1bmlvbiBo
dl9yZWZlcmVuY2VfdHNjX21zciB0c2NfbXNyOw0KPiAtCXBoeXNfYWRkcl90CXBoeXNfYWRkcjsN
Cj4gDQo+ICAJaWYgKCEobXNfaHlwZXJ2LmZlYXR1cmVzICYgSFZfTVNSX1JFRkVSRU5DRV9UU0Nf
QVZBSUxBQkxFKSkNCj4gIAkJcmV0dXJuIGZhbHNlOw0KPiBAQCAtNTIzLDcgKzUyNyw3IEBAIHN0
YXRpYyBib29sIF9faW5pdCBodl9pbml0X3RzY19jbG9ja3NvdXJjZSh2b2lkKQ0KPiAgCX0NCj4g
DQo+ICAJaHZfcmVhZF9yZWZlcmVuY2VfY291bnRlciA9IHJlYWRfaHZfY2xvY2tfdHNjOw0KPiAt
CXBoeXNfYWRkciA9IHZpcnRfdG9fcGh5cyhodl9nZXRfdHNjX3BhZ2UoKSk7DQo+ICsJdHNjX3Bm
biA9IF9fcGh5c190b19wZm4odmlydF90b19waHlzKHRzY19wYWdlKSk7DQo+IA0KPiAgCS8qDQo+
ICAJICogVGhlIEh5cGVyLVYgVExGUyBzcGVjaWZpZXMgdG8gcHJlc2VydmUgdGhlIHZhbHVlIG9m
IHJlc2VydmVkDQo+IEBAIC01MzQsNyArNTM4LDcgQEAgc3RhdGljIGJvb2wgX19pbml0IGh2X2lu
aXRfdHNjX2Nsb2Nrc291cmNlKHZvaWQpDQo+ICAJICovDQo+ICAJdHNjX21zci5hc191aW50NjQg
PSBodl9nZXRfcmVnaXN0ZXIoSFZfUkVHSVNURVJfUkVGRVJFTkNFX1RTQyk7DQo+ICAJdHNjX21z
ci5lbmFibGUgPSAxOw0KPiAtCXRzY19tc3IucGZuID0gX19waHlzX3RvX3BmbihwaHlzX2FkZHIp
Ow0KPiArCXRzY19tc3IucGZuID0gdHNjX3BmbjsNCj4gIAlodl9zZXRfcmVnaXN0ZXIoSFZfUkVH
SVNURVJfUkVGRVJFTkNFX1RTQywgdHNjX21zci5hc191aW50NjQpOw0KPiANCj4gIAljbG9ja3Nv
dXJjZV9yZWdpc3Rlcl9oeigmaHlwZXJ2X2NzX3RzYywgTlNFQ19QRVJfU0VDLzEwMCk7DQo+IA0K
DQo=
