Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0065720B1
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Jul 2022 18:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiGLQYQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Jul 2022 12:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiGLQYQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Jul 2022 12:24:16 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021014.outbound.protection.outlook.com [52.101.57.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDE1C9959;
        Tue, 12 Jul 2022 09:24:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxPYWgWOjlIvCA4GYxG8/ct5CtXEynpsRAUQAhF6CaZ/DzPsh1BVmuBItVsvIJl1aTXHc1LkxM0HZd4B35iSE3RIlJ0d1YcAlu56jZc+E/LhGG1O9OUPIX72gopaFqXac9orr+Vb6h+jfpTxJWDIviVbdS37UqUHSH0cwnawn1+WXH9t6TqzGgHKU0iSCLc97nBo75cpTWDqtA61XGoefMnIVErIpOlW5obrQrHM/ApZwiWYAFHbDQ9IwckbDT9gfpVxGLbDU1c0ssv+bk1WC1iZnlbjlAvxYIsIGCOCbBA4DjH0hYVXV5CC2NU5hjhEWcQK7YH7TikV/DqSCCw4mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KoZ4XI9d77tn+ssn0z3WU064VTkec6DnZJc2oVboqY=;
 b=DRDjfw99GLY5hivgGoEPeXthRExQWdVoudxFN3yzGJ95QNvH/m7JYckX/m7+pmN6AcISW0Tp84zwZIaw/fdRWskFgEgMlZRj6fsm5l95f+a0XHvV6RKs5rOjh5B3AmpgIR6i6jC/Undzl6GpYKWBBd/c7tXSOmv/S9wp0PId5LWweowo36M6HzmzLjDJxmWL6js577l2ZLsyHcCVrPxDFNhztHxbcEow12hcYDKo4x1K7k6KDdWtrztCdI0//JyOmoYjwhQLjkiGXQOTDH5WugJ/hiWkTRAL0ufZd02PPxHqtXKiKLUYAdv9O9fTx0+J2/4zTLxy2ZwYU+H0x8bWWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KoZ4XI9d77tn+ssn0z3WU064VTkec6DnZJc2oVboqY=;
 b=BYpr+A9lHG3c4Yly1Ntjb6CdWyMhUVzzLJV93fKyJDCbE7j7hDkQFDPXntB0ktFzoI8CEQYQpb/kpJHhJK3H5W/VlM4B3bBvclJA/mSRPNh4inrDDok/yzjB7NfAlBFYv81o/fbBQQ+2yZQ7dsRaHtd45b4ZsHYkDj7QXsnrZUg=
Received: from BY3PR21MB3033.namprd21.prod.outlook.com (2603:10b6:a03:3b3::5)
 by SA1PR21MB1318.namprd21.prod.outlook.com (2603:10b6:806:1f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.4; Tue, 12 Jul
 2022 16:24:12 +0000
Received: from BY3PR21MB3033.namprd21.prod.outlook.com
 ([fe80::4867:9c4e:6d50:9323]) by BY3PR21MB3033.namprd21.prod.outlook.com
 ([fe80::4867:9c4e:6d50:9323%7]) with mapi id 15.20.5458.002; Tue, 12 Jul 2022
 16:24:12 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC:     "kernel@openvz.org" <kernel@openvz.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] Create debugfs file with hyper-v balloon usage
 information
Thread-Topic: [PATCH v3 1/1] Create debugfs file with hyper-v balloon usage
 information
Thread-Index: AQHYlVK9mP9UMt9phU6FgKvzfTQela167G3A
Date:   Tue, 12 Jul 2022 16:24:12 +0000
Message-ID: <BY3PR21MB30335CDAD39F927427DEF4EAD7869@BY3PR21MB3033.namprd21.prod.outlook.com>
References: <PH0PR21MB3025D1111824156FB6B9D0DCD7819@PH0PR21MB3025.namprd21.prod.outlook.com>
 <20220711181825.52318-1-alexander.atanasov@virtuozzo.com>
In-Reply-To: <20220711181825.52318-1-alexander.atanasov@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fc4d1312-d8fb-41d7-9751-c856eb9b477a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-07-12T16:22:10Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b9bb701-e2e1-44bd-3461-08da6422f491
x-ms-traffictypediagnostic: SA1PR21MB1318:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EqR6BwSKB4/KKvN3xQMACllZVj2CAWlgzG68CuD93Ib37JBKYYoXvZholkZFXYvHI54Sjpprdzrfu9VKGdzbE4mZI8Dxmq4IgvGNbybZgZ8Nj17n263mxCMxvUtbiwCvvGQC8Z/n3z3pTYywkIV5+33Zwxj8htN9QRxPEssKxHWRb4m9UgxkCGJdPbIs7KEQFAesrkSlUS4Kol4AErLyedxJbMnA4kMbQTbdxTYRAtoZej+mVn4mAHUPyYUXDTWGayY9YS8+N0QbERso3gHVcSR5Oz6coSikW5Eu1wNL3rLN7roDbx/ylI/tdfXhlTSi7yrGHLkhTd8CnVz2cXazQPh15QVT1XoAyd5BKA9AMzdQOmE0TTFwt+R64AYOp8qUsO5tdo70iXZQRGAUDSnTBNLvDKSzil7+33b7obQXwRY/3kUaRODY+IoE7qSB0IW+T2cJN3bBh6A19J9hqhnVAF7mFsvUzNrrYqgl4g6oJIu9FuPEwOrBNh5rLH4fm8cxXEGalUexAZR3ZjL9pDV6LK5qf8K7voTM+cnMf7Iy89yyOmV9xIA+p4sSsG0ZEjWtlHeGGBmB4XgntxVu8Xo8oJwQwBAg/HxuNd7cGoJFuJ8t95gyoeX85jJr6V+EmI7rz1pmFg4cmlBIT81XiMaDDEwvtPGldTP1597nWXMM/7L0M8ZNhiKmSKCKYlnQNoOVxSMEp9RK8BfgrDYgltVYD2SV2gb1bsjxwY9y+VLc1yKsDcCm4mZXVHW8QAcC5UWjrg0lWLZc7bF6gxdWUztPi21JakiSy7G8/yPtQGxs/t/n+mS839D125zjbwHPu5zR//h22DYB6pEpwvVD4TMbMUt27kFkhDN0LKB14oh9aac=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR21MB3033.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199009)(6636002)(71200400001)(66476007)(478600001)(54906003)(76116006)(8676002)(316002)(41300700001)(66446008)(2906002)(110136005)(66946007)(66556008)(8936002)(64756008)(4326008)(83380400001)(5660300002)(10290500003)(52536014)(4744005)(9686003)(186003)(55016003)(8990500004)(26005)(6506007)(82950400001)(33656002)(38070700005)(86362001)(122000001)(38100700002)(82960400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mwDoN198vHLWiOtPzmQUac2+ISchGR78V3HechXbrVVmZ/VzTUN9LLAfqbca?=
 =?us-ascii?Q?03o8Kel2QvHVIjrer1E9L9grHUcIjmMB6QoYwvYhYyKC9NF3OmmGlyvrBTFd?=
 =?us-ascii?Q?EIZHSwaTaKTZDARxESzCa6UixeVz58bc63b6aEH8JLioeUEWPaB2IzdHL7UX?=
 =?us-ascii?Q?hngnxA3Ln2VuLVruEo2Y56bjSTEX5ZVhHCly7hxruJVIMD0l9QcNVrcdu2fe?=
 =?us-ascii?Q?Q7Pel9smLnC7dCEh/3nzkBhwIZH0Ai5cwh5b0WGga9U+I2dpvo2FgknhJC2e?=
 =?us-ascii?Q?y8TZP+rvQsMArQVPB8xKVDKIz1aJXTQh0ky+BUw41AoHGv1r3NMR3y4Zuv7W?=
 =?us-ascii?Q?tFwzr4dc/vJVqKb/EJcCqPU6ntWStnpdRKmOXyRzt+lbh5UafGugSiU5wlBX?=
 =?us-ascii?Q?Q6i57guf2jqLhhICAz/szxQ0cCsxvzNJPs2erzqprsgOopg3X+QebkmmW+B4?=
 =?us-ascii?Q?qQ5QD3cu+jtQYDrl640DorCIRsg9Bkl7L26OxFc08hyFa8JeKCHifQdIPqWC?=
 =?us-ascii?Q?FqnXMAUqDKEeNCsJW5dT1ZmfhulAt7tn5pmj+FDkcFr1dB4vmdrbahsxDBXz?=
 =?us-ascii?Q?GEsX17mtWcAQABrQ3bnucgzLdxHsCPSVFqTtkiqaCrBX3nljc7j+25xD7HVE?=
 =?us-ascii?Q?3AUoTIl4Ft/bcz/kbkfO1oByPS01rbxbP0CqXITR7ZEiQQRaaR0j9yUaZZlI?=
 =?us-ascii?Q?9MfKRAkBTQCniQmCy4+QHGn5+9eM2qvs91uDkhgLxxq3VNAAZIvpmgLjjpJd?=
 =?us-ascii?Q?Q1bykLjjdpHim8bbRhVnQkg3XAkwYyVFx4MaxsGtTSCGNmOqai+rz850ffFg?=
 =?us-ascii?Q?wDVaqsP+XNhR9dfvHOy196nFURNHd4cSInLncRUtaTv5ExAUfJ/hhbZInd2s?=
 =?us-ascii?Q?eF+NfB9WbbuLn+QAzj+NGXJbl+1Oyn3x+A7ND0sOngpgBUz+lrYWkevy5dNQ?=
 =?us-ascii?Q?DpmeAPmVlaHy5H/I3+njYOWF3qrfAOOySObEkND0qyS6P976TL4XqoZkI8XP?=
 =?us-ascii?Q?TmGptf3aWBh2oxlNwMvWZUwfcyASVeNc9VMMskOhBfRVigVaiUg15+u2T/mI?=
 =?us-ascii?Q?V1SywfWti54LXmq4pMhmKn092duoiLVeZVWO+HIhvG4mw8bMCb4+xu0ygA0G?=
 =?us-ascii?Q?ApHcGSj0aLKU9HmYSri0QnOvc1NoJ4Q2uEfjRwkZbfnXhDS3XUHDEp+77BT7?=
 =?us-ascii?Q?sM/PE5KkE307/EUavoLblASHlGAJ0GnbtNAh6NVutLGTT4Gm9O+F8kBb24nb?=
 =?us-ascii?Q?2vuRNaLCcimWRUc3qh4809+wnxGH04TiSOFLZ4ugB79wrHsarmbsBzycal6R?=
 =?us-ascii?Q?+x2bRiU7+GnUppuU2pNLv0rFbU6TfEj6dsM0NA/va4sGEebpR8tc6EK9IOS/?=
 =?us-ascii?Q?FYgTamoS7fWdYf2Sl5CDQUapxInUxMV5aTQAMUCh/SCNb0irSFpTghJSv7Ug?=
 =?us-ascii?Q?Kph1oLJ7oCFXQpLMVDHCnuX4F/UYtL5CcTPdM0QuFFnVN0cgk/MrPaPCvcCM?=
 =?us-ascii?Q?Y4jMWQTDxfkxOz0apScfboj7uwNedvmuymwr0DTTkFIZY3aE4mztmHF3AB3d?=
 =?us-ascii?Q?nahjytX9OAchQ21nS7hdxoPeDoB3I/3BYNd5KLYAyhkXK3nfo6zuFbmA8RLh?=
 =?us-ascii?Q?xQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR21MB3033.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9bb701-e2e1-44bd-3461-08da6422f491
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 16:24:12.0805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qMw/2gkCiUa7t5ThWNH9K1id5f9jzfhyU/iHfDqV7vnupKwhK3BvHahM7i5YjYmTI30jQ2fEWi6H5UzvRkf/T3GNmQocpxr9SIrp5vjGnUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB1318
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Alexander Atanasov <alexander.atanasov@virtuozzo.com> Sent: Monday, J=
uly 11, 2022 11:18 AM
>=20
> Allow the guest to know how much it is ballooned by the host.
> It is useful when debugging out of memory conditions.
>=20
> When host gets back memory from the guest it is accounted
> as used memory in the guest but the guest have no way to know
> how much it is actually ballooned.
>=20
> Expose current state, flags and max possible memory to the guest.
> While at it - fix a 10+ years old typo.
>=20
> Signed-off-by: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
> ---
>  drivers/hv/hv_balloon.c | 135 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 129 insertions(+), 6 deletions(-)
>=20
> V1->V2:
>  - Fix C&P errors
> V2->V3:
>  - Move computation to a separate funcion
>  - Remove ifdefs to reduce code clutter
>=20
> This patch addresses your suggestions. Once again, sorry i have missed
> your email reply last time.
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
