Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDDD6F8E16
	for <lists+linux-hyperv@lfdr.de>; Sat,  6 May 2023 04:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjEFCiJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 5 May 2023 22:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjEFCiI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 May 2023 22:38:08 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020017.outbound.protection.outlook.com [52.101.56.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F23B1FC4;
        Fri,  5 May 2023 19:38:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnZMtCF5uHL0bz5wGbRRL6ArPHTcOPSM46JovwvnRgb51bnzCkWcSUj1wC3JMoNpdvqqNjym+ATko8fw3mLUQ8RBEhaK9E81YOr3zY3r122voLsC9R9MCoiBp7aoW4zwEbGOXeZaNd2dHOBnKwqX9PTkZaJmWCg7bLOQaJ4JLtvTqPJGAEUCPNiarewbCMb2JGHNmD+aiCK5p05Fa8B8DIC0rhCsEGnPffknDVUbz56swkdiLOrfRbGpA2kJaQzO4dbOGn8y8rIRWqP30XrxzyIzc1tL2oZ0FWLtxG744NSausyxsHoBGXV1VcUlwGAOkRWDF0vhOtF8iqt07OwCRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bw8YwDQbK6EBQtlfVTKDb+ykjELcRRk7vjZkuCR+WPM=;
 b=VwgRGTMxU+gt6Q3PoCKHWp7rIsFBu9zyaSDdzVYFTNHnxH31gtQ5yZIE7ley3qG664810mPZePPXhfStqq9uLhaJj45Wr92xx+5h2Kv5UDomHCm1Tir6j0nv4vx+L+sqjYta1d5JBlY4SasU93I/kK9iNodIp7h76sLAuXklNmjjod2ZQlspskiHBAs0PMajpKLlLpRlLr9m6XMd5k0AzeEgDPFzdXSE1j+69jDcqEE7IFUsha27atd+sC25c28u2Go4CvdWFFPGgvvqlxN1DJLWllZnIcOExgDxyE7UNxanVMrnIT1rhT0yMiLXu7TVVjII/brVY9FynhutlllX4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bw8YwDQbK6EBQtlfVTKDb+ykjELcRRk7vjZkuCR+WPM=;
 b=KkQ7H+/IyqP/GNMt7VbhYqLgKMMsXwAtyJe++dV2e8sSnvFboaniAl2Ctq66Gn02IQPM+9arYSAmPIESeq6RVYcgXnSDlnQiAx+mcNuc/DHHrW9nfqWOcGzpvNPo2+wVEsUm8RTZftfq1kjOO7s6JanGVWUJZrBzR6xx8l+0/sQ=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DM4PR21MB3394.namprd21.prod.outlook.com (2603:10b6:8:6e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.7; Sat, 6 May 2023 02:38:04 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c454:256a:ce51:e983]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c454:256a:ce51:e983%4]) with mapi id 15.20.6387.012; Sat, 6 May 2023
 02:38:04 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH] Drivers: hv: vmbus: Call hv_synic_free() if
 hv_synic_alloc() fails
Thread-Topic: [PATCH] Drivers: hv: vmbus: Call hv_synic_free() if
 hv_synic_alloc() fails
Thread-Index: AQHZftmyZlo283HZ4EioKMxfwa3sj69MY/9QgAAk5cA=
Date:   Sat, 6 May 2023 02:38:04 +0000
Message-ID: <SA1PR21MB13353DEBB073AB77C933C885BF739@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230504224155.10484-1-decui@microsoft.com>
 <BYAPR21MB168862E4608ACC6F734EECA4D7739@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB168862E4608ACC6F734EECA4D7739@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=07820dd1-dce5-498b-ae13-f4f0ea1ee9f5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-06T00:22:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DM4PR21MB3394:EE_
x-ms-office365-filtering-correlation-id: 74a1237e-4d7a-477d-bce5-08db4ddaeafc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hmo6sV2ebCL9aU6Bi5ip6ImbGbgBmzJpcE9ZoBMTUiqeWjc+6r5Lwi24lDQF/txK7evLSC1HyVnVlpU7ylKkXADq5hJWwwVi/x7gCCkUsAQEXGXd52WzZGsYsLU6t6kp8e1Nk6cfqmBs9JnqFbR7DSwlKNbmzWwrGCRoDqyyedZp5jyF3eWxnmlkhAq/nd4w+SnNlz8qAhnev5lUu9D72KoFUYlMjMddxJDaxDJ9wNo9QSy2Y2GqUf1tRSteQicVKolWgA5vFIhYTyLNtxwUgENuY98mopKA8n4jKY49H9rSY8yrW4q4owSj+UCZnuut8EwYndazdiTANQ11maibY8o7Ei0bd+MuBe25FOb9N7rztEvglMcqUT6qfC7U2Ut0dfFhrBbyN+G3bt/QhnqvZjsZQPUkHg2et6rTWd7XWz0ZPsZgm8vf8JmGoDxim39vmQlzbk4BUAMEZ7EGDaD1RlFJd1hzHP6mqvpkU+7WoGy8fwrBkRFOSQKb2lHF8d02p7W72ixKSjNfzXP2HLUNAh5Gd4wdVJ0Lxf3W27Z4KuoHqBJ6x9z1lk4dQTIjR8WO6EGPbA+IvcGlk40lR6VVrGktyMdPcAD0dL7S5wt5cEkrqSrd2et4TpcsDGOSychqUwQz6TiItKoZ2JnicKBqaVFtIF20eOcUwNSeKpD8PT8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199021)(38100700002)(2906002)(52536014)(41300700001)(122000001)(8936002)(8676002)(38070700005)(5660300002)(8990500004)(33656002)(86362001)(71200400001)(55016003)(54906003)(66946007)(478600001)(83380400001)(26005)(6506007)(186003)(9686003)(7696005)(66476007)(82950400001)(64756008)(66446008)(316002)(110136005)(786003)(10290500003)(66556008)(82960400001)(76116006)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lvOhq78g269SjhWDSPezqHj+pGDkFrJ0oaVLS7RFyvhcmdDjRexGGf2Q872w?=
 =?us-ascii?Q?MBh9eqN0l48CHnLEnUQ4bLCvcZ97MelSm/jjlz5yFjWbjBAiaCcz2WZXDCxl?=
 =?us-ascii?Q?2GdmRwZkAQdL3VfnLONYAg5Hh0yFp6zb7uTjghy1cnV0DUz4cSJlY6VgMWjL?=
 =?us-ascii?Q?VcbEaFr0KzdJQtR4BtMzNMOD1Pjpc1q0ELl16xAfS0/V1y4M3NAoq88QPB1s?=
 =?us-ascii?Q?csqmczI4JmaSOW9fRGKFfhv5iJfbfAGaquJAaAAFJIDDzbCZ13zK52BzJiqn?=
 =?us-ascii?Q?LpimbJf877L6ShWKaKyPaoreCyQydUBtRVkHYDURd8Ddrzhk/3xA53lIRCo4?=
 =?us-ascii?Q?gR5oFp6p4+C8yNi8IIFbe7vGAeXxaB45W6h8N+MLeYDYd+ZB3tLJjCyq1ey9?=
 =?us-ascii?Q?F9S0xzskHP4m9kJVu2zYwNgtgHAlqwIuScm5QC1Zayc41SaTyXisHAW6IOKW?=
 =?us-ascii?Q?8AXdmjXaIzxuAkFKSFgoi4g4MwBOQ1BYKoaGo5ifGiOh0Zu93DQ9lQAP4evq?=
 =?us-ascii?Q?xDBGaaSIrMlvVZDgpucnNJCXWty2bJqkPXrm6uFIy8e9qbITQnbwDxwYPr1u?=
 =?us-ascii?Q?CEJ+WBSQ8xJiy24dBRwYhwxnfS4/m49/QRpoJdO5PtgORWNOKRhMUiUi8Tt4?=
 =?us-ascii?Q?PKZ8lq1Tkj6K918ImbmBg6QGRRSIddIT98MiIPg0ba0VfFH3HRO90sUUKtOV?=
 =?us-ascii?Q?0cVXTG8HyHuYhmrbY9eu6dl8cGL+JCR9pb7OY3lZcruTEFFhzzbUotmBUxTi?=
 =?us-ascii?Q?JlvFFhgvTmZ0c7GaqelYC5123ikGwnfw3fm7kJFGLFUwgK0v2RaOC9zawaiN?=
 =?us-ascii?Q?HXYIZA3XI1nzUdeSDamnkKFxi6wK+luXE1FLkIJ2AyQU5czEvJjdv6wTRcfr?=
 =?us-ascii?Q?RJfZC59TkCOejkFAf9DJToEyX2ifZ6C+28QLPyT3Dbx15es5M/Y8LHDAc01i?=
 =?us-ascii?Q?Y8I6nFxKFq3zmEJRsuBUwb7mOmX3z8K0T9OeIQWHz51JU6AD/lWynWAlPWD3?=
 =?us-ascii?Q?H1OkVH0BGpOZFJy1CRJ8aaRWVrv2i5BG8bsdxJc10sWvxzDQXhpUvDPQF4y8?=
 =?us-ascii?Q?K4krRz1D09fEn/kjZjPk+AeXZ3F7EtA3rw2xZGarGHPORMEk+xdp2Dha1VtM?=
 =?us-ascii?Q?RaIJ6pfw/q3GbPUZ1L+R/UD4kC8b6X28uJo9jDSOqCoN9ybqfj04VcqbNmqJ?=
 =?us-ascii?Q?x5pDqKvwRnOdkvNWApNWpkPrPgT32VO7Lzf/92pqV3VB/n6SWhc2iVkSKkqp?=
 =?us-ascii?Q?vihs8nrf2vvOVfFxTmwdwPn2pOWUOYvHWF7SQ9BqHgCGxPzBPlEE35JgXvVL?=
 =?us-ascii?Q?PaFxE6vFWzZS4+RS5YvBGCuZUAdbt2FbMc/NFB0gOmgk6JHf/mI1ZewO+0LL?=
 =?us-ascii?Q?7FR3Tr1k2ewjX8tSt0VOkCsySf5yjiL16KIybpVAJBLBO7mjPI8w76jKfAV9?=
 =?us-ascii?Q?p9x8YOujjMTVvqlqnjT4xo2DqHPF490Og4DbV1exYLz018D21KC+7l+XtPMq?=
 =?us-ascii?Q?/vtAi/armbUKkC/eRgIpgjnPO/RHKz8sou+C2Et3ItF2gEfZNMRxBbOCezC1?=
 =?us-ascii?Q?1Qqg6yp3VuPywY6iI+7UwSzFnrscKXzGNgqAlBL/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a1237e-4d7a-477d-bce5-08db4ddaeafc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2023 02:38:04.3478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nf+kfV93r9CF/+0UT0lHF9cKGeh0xyPB4bVA1wtKuVPMP/4os3//7OXTF1alC2uYxKdxti/AwuvXov0SBov2jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3394
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Friday, May 5, 2023 5:30 PM
> ...
> From: Dexuan Cui <decui@microsoft.com> Sent: Thursday, May 4, 2023 3:42
> PM
> >
> > Commit 572086325ce9 ("Drivers: hv: vmbus: Cleanup synic memory free
> > path")
> > says "Any memory allocations that succeeded will be freed when the call=
er
> > cleans up by calling hv_synic_free()", but if the get_zeroed_page() in
> > hv_synic_alloc() fails, currently hv_synic_free() is not really called
> > in vmbus_bus_init(), consequently there will be a memory lead, e.g.
>=20
> s/lead/leak/

Sorry for the typo. Wei, can you please help fix this?
=20
> > hv_context.hv_numa_map is not freed in the error path. Fix this by
> > updating the goto lables.
>=20
> s/lables/labels/
Ditto.
=20
> The statement in commit 572086325ce9 was true at the time of that
> commit.  But I broke things in commit 4df4cb9e99f8.  Should add a
> "Fixes:" tag for 4df4cb9e99f8.

I suppose Wei can help add the line:
Fixes: 4df4cb9e99f8 ("x86/hyperv: Initialize clockevents earlier in CPU onl=
ining")

> Nits notwithstanding,
>=20
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Thanks!
