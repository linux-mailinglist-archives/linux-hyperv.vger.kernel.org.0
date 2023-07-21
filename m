Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AA575C73E
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jul 2023 14:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjGUM6r (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Jul 2023 08:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGUM6q (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Jul 2023 08:58:46 -0400
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazon11020024.outbound.protection.outlook.com [52.101.128.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B598430FF;
        Fri, 21 Jul 2023 05:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ui1DYiDpRm7RY0eEB+f8ZJ1acJ4cAvSZXCbSR2KAch+awPMliv5zzxpe2IXTGf7IvObPjQfsbPEbP1dn+sWzuZK3Na4vVsWXY8mTlDUW2Xof65LzMMKeD0eGhNH+RZAt61C3FRqvu534fmdAbhiFcQAM1YnK0ruzehxlyhKRj9EWS33PBJmJ/74E/UxFgxI1vfCe/siNmb+GETdgsSbsEcrHXyht4qNwrhwg/DGomADJuQEQFo2/fKfAHxotQZ/nmvS1tZlHGV0jLJfdeWhawsg44i6NwXeV/O1KI3iVLzYgJHBMxLZnD/JPWX6AaKmPRyVDoZZZe4/nuTfYvOF/Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpnd3/6juiWKq0Muq2uVMEwhv/KTfs6l4bln1U494iU=;
 b=lC6nzD3fsa1wCBEr2w8VRJLeYlzmKRdWSaceefXJ3QJH4pGoooI7TtyT3mj3NE/8yo4JepImOxLhiwbUYRJFlkJepoXjM4RL2TjVcMQft7bLAhM9x5sPiznrJMZOh/sbWk4JFIH+j1yhaJQHdBjRb7NfwbiSU8w6lfqqQwSvoHv2w21vlL1zN4rjn9cOb3mIWIzr5qJ6Og4qdun1eoPQd5kcCi3mtVPY48UNEFEstqOxqW+Y/rRTcgWa1rZEYq1E3Zi3Cl3jckQGhTfHgiWN0CPgWinnvL9SyyF3e6aSJAbq05WfUW5S1TByabGe12YmDSG/B4a19/dIQmjQncQriQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpnd3/6juiWKq0Muq2uVMEwhv/KTfs6l4bln1U494iU=;
 b=PV6F9OGV7FKq9NyZZ4Dj1SJVUgYaeNCVjSq7/CGXAGx5cLnuaKtoUC2Ykxxk9LU+cOVZDibVgFDlm21qZ4KhzTVbBGEQxU9F+dcsI/w+UuguPqrVoz8LMC+kVlqyQPPUmQTLazXVBfMtzlaP32tIV0kkL/89IoTLJFGnDKLcq/0=
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e2::8) by
 KL1P153MB0962.APCP153.PROD.OUTLOOK.COM (2603:1096:820:cf::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.16; Fri, 21 Jul 2023 12:58:03 +0000
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::46af:847a:14d4:67f]) by PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::46af:847a:14d4:67f%3]) with mapi id 15.20.6631.014; Fri, 21 Jul 2023
 12:58:03 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [EXTERNAL] Re: [PATCH v3] x86/hyperv: add noop functions to
 x86_init mpparse functions
Thread-Topic: [EXTERNAL] Re: [PATCH v3] x86/hyperv: add noop functions to
 x86_init mpparse functions
Thread-Index: AQHZqeo2WlZ5UIAxR0aDcrQ0GzS+4a/EUOGA
Date:   Fri, 21 Jul 2023 12:58:01 +0000
Message-ID: <PUZP153MB06357202BB90D434C909DE8CBE3FA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
References: <1687537688-5397-1-git-send-email-ssengar@linux.microsoft.com>
 <ZJx02GzzoQ9E1TH9@liuwe-devbox-debian-v2>
In-Reply-To: <ZJx02GzzoQ9E1TH9@liuwe-devbox-debian-v2>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7d7a7021-0499-46e6-bdea-c449b05693e1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-21T12:53:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0635:EE_|KL1P153MB0962:EE_
x-ms-office365-filtering-correlation-id: 523351d8-8b8c-49b2-db4f-08db89ea1d80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6xIPrxM8JLjwn44o0qHtF6WIAWDJo5+/JhHP/GLzJvznl7swsOdpBGhil4D3k4epWI+MgY7/Ddaum9YzeE/ntm5P2aGrzZ7Ksjp1Cz2wMedSRu9GIOnotd6gXu6aElLEDdVZEOdyHsXsmV+dJYh9GDK6SCVSDTTTJ/ALFlP7q1sWXUnq1/gLbfpRV2lejp0n2zxKVQlOBY5XcJzY5Gw+8f+a4wYn6r8jK8u6auzMauQ0/DlAfOfvVUTzEXCicf8DUxjJywS8yyZfKkCmi4cYC10saj0Cpf9F1GX1RUr9ajQ34W0WR60ULYIafzPTUNjJGTJrxvdnohPl6TtnnxC0NabcLlOY+JRT9wtBj3MFwGmAGfDE3vNLRw4Hm0JBHNEsiW608MJCc442Eg+4RgvREZERTry8UO4U/zmAVV+f1ynXlVxmsl6JjXTHw1CGbQjRzVuesmsCo49IpdfNQbbM2eGtztZc5a2Jra9JaCt0f1NJEYlOXF8q082HptislKhKfyES1y/JByEG+av7gSHGeCwCD1YdkkbDe4pnNXgig4L0vVRLqM7GimiFBU3jvNgJaBQMforcgCzEeUjxunHOPeaY9dT7FvajFnXfGgqL7h/K34IMGOyYe6+3riBnPwJQJnAaLPbFxgXi93Air4KrqByyoaPSckSoYLQSUjRlAzw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0635.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(33656002)(53546011)(52536014)(5660300002)(55016003)(38100700002)(86362001)(6506007)(41300700001)(186003)(83380400001)(9686003)(71200400001)(7696005)(478600001)(82960400001)(2906002)(82950400001)(110136005)(54906003)(122000001)(10290500003)(316002)(8676002)(8936002)(66556008)(64756008)(66446008)(76116006)(66476007)(66946007)(8990500004)(38070700005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aT8PBdWLUULPCHUbmybcCg2NXc8TK49CYr0fJBb5K0C+RL5Hw0oE1U3RCIok?=
 =?us-ascii?Q?3d+1hJpg8F0zpfp2OSXdkBknCpqCmR91unk5mYxiuxbSU4//ipeGAPXhED5+?=
 =?us-ascii?Q?DXNtUQHVPW7s3HxQUUxr+D+E+Ak/0m4mJUehQsAASKIpBNBiev27z1It2GN2?=
 =?us-ascii?Q?zRq7Rw7XUsKvx8CZxiEE0hVOxUSYiuw3kDPEViMpDzFL7yWAyhSEWm4qDlV0?=
 =?us-ascii?Q?qVO+p1UvQUokx1QjoqgMyvLXQkfkBiEPj94pOPz6dkNhW7iV2WhW87M8sFyz?=
 =?us-ascii?Q?U3lEZtZQEp4CGAswGCs7Wg0jkSFhCRMUY43D6Ljt98pstQEBEISDWfm9Srtc?=
 =?us-ascii?Q?8j/TT5rPHE+ZT7ixNfsMqazPNiE2iOV7/KdqbxNvEweXp3aDhCkDKXC0drtP?=
 =?us-ascii?Q?d00Xe50GyANiJkeBZdXiTEBWQ/kseNQkFxxOI7HC1YAK4Zi897EBakmK23ID?=
 =?us-ascii?Q?ND5eeeSB6JYuH+si+wAKEA5dGH7ZTBdGpzbBubu2Qb0vqaE8d/BZuQ1DcOXV?=
 =?us-ascii?Q?Cg+YCzPF4NDmzrU/X0PqUVBn8Lrfs9cwObaUjSenzDEfAGHGxCI5Lfv3YE1W?=
 =?us-ascii?Q?rKtPzyGDHSYhaC4J19ovK74QWLLtClmQ95xk73g/wFxYBMll+NO8m3/1zryN?=
 =?us-ascii?Q?4LEYRTPGyxBhwOahfyIplS9MkJx2XZju8IGZDEQibJLVbsegqF9nKxz3zwQw?=
 =?us-ascii?Q?Vulxuj7OkrdD7x0V7+cYFljO6g0sCe5m2TdHRolexaZmES4k1plVFBz49eb2?=
 =?us-ascii?Q?hGTuuFGxwND+Pjcd4O7p3DKrhZeYS/1jKECjxvugZMA1Lt7/LtOwZuGAuFZd?=
 =?us-ascii?Q?sG7WjQdKfFrmCOXXw6a0hWXVcf5Y/Xxrxnrg73Z9HxQoeenTpGoiu6guXF0d?=
 =?us-ascii?Q?mWEeMsqvUVV0J0C06UM/ltDyRE5a+gqUR/88MoLCyZuBl9jgjcQIJY4iE0NQ?=
 =?us-ascii?Q?r7ndgY22K2TTu+GDyN0uuTFTiX56iSBwsJ8FGOSe3djB1QZ2fPoUxPd6NyR0?=
 =?us-ascii?Q?9kRe0PirLnbnmrf5/2epiOmuaOkam+Guo442OuGEukRYwIjPWBDMd7nQbsQ2?=
 =?us-ascii?Q?jKZe9Zq+d8uhgSa6RvQ5kyShA/B2T43C0vJwg3vYBCS2cNMqbPiDCc7H4ZS/?=
 =?us-ascii?Q?+yfdqTDprbfFMU5m1h21VnmRrnEjL0ebKfrjvJQfBqhGhaNeCSKkXUzWaCHd?=
 =?us-ascii?Q?VZeLJPjx/RaGjMabW2uMNQKlhVDLw7z5y3H57kFsyw++1ZhZcDI+UEvTk+I2?=
 =?us-ascii?Q?hiTQ7Vimb7FWk1NwpJ4Kna8klE1H/aLwwn2C13sPW3gRSOlxl5pFpkQLXWlA?=
 =?us-ascii?Q?hrM+HLY0MHj9fusZyG4vPwa6bZEQjAXWd9HMyQrwPIZkRE1MzBxcqG53OEd9?=
 =?us-ascii?Q?/GPBC178dBcJWBC5GwDw+zb5kgNRtj5H8svUEZeb1Jgd/Q1jM2BA0RiK42Ss?=
 =?us-ascii?Q?R+VjcEgCJfyEHcQQ3kpCB4K5FjYE3QRxmT6Vvlnufwm18fNPrd41EyKbVt0W?=
 =?us-ascii?Q?82SUB7DHm6UbpgIMNYtJAHy0OP213RD6yoQKtOOCfJnTlvyvZGSGkkARBRFn?=
 =?us-ascii?Q?+TRykYWuoL1myNVPAyeoVZOCV8KMCKnPHLYgMX2r?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 523351d8-8b8c-49b2-db4f-08db89ea1d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 12:58:01.2829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kIkKkXvY+KgY+be+lTBC+kGB7sIox69Ne4FSmgFSs1mBB2vHySJsbODmdtuDn9QJbTNYofVY2MErzLxcQCXUkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P153MB0962
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Wei Liu <wei.liu@kernel.org>
> Sent: Wednesday, June 28, 2023 11:29 PM
> To: Saurabh Sengar <ssengar@linux.microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; tglx@linutronix.de; mingo@redhat.com;
> bp@alien8.de; dave.hansen@linux.intel.com; x86@kernel.org; Michael Kelley
> (LINUX) <mikelley@microsoft.com>; linux-kernel@vger.kernel.org; linux-
> hyperv@vger.kernel.org; hpa@zytor.com
> Subject: [EXTERNAL] Re: [PATCH v3] x86/hyperv: add noop functions to
> x86_init mpparse functions
>=20
> On Fri, Jun 23, 2023 at 09:28:08AM -0700, Saurabh Sengar wrote:
> > Hyper-V can run VMs at different privilege "levels" known as Virtual
> > Trust Levels (VTL). Sometimes, it chooses to run two different VMs at
> > different levels but they share some of their address space. In such
> > setups VTL2 (higher level VM) has visibility of all of the
> > VTL0 (level 0) memory space.
> >
> > When the CONFIG_X86_MPPARSE is enabled for VTL2, the VTL2 kernel
> > performs a search within the low memory to locate MP tables. However,
> > in systems where VTL0 manages the low memory and may contain valid
> > tables, this scanning can result in incorrect MP table information
> > being provided to the VTL2 kernel, mistakenly considering VTL0's MP
> > table as its own
> >
> > Add noop functions to avoid MP parse scan by VTL2.
> >
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>=20
> Hi Dave, are you happy with the commit message?

HI Dave,

If there is no concern, can I get your ack

- Saurabh

>=20
> > ---
> > [V3]
> >  - modify commit message.
> >
> >  arch/x86/hyperv/hv_vtl.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c index
> > 85d38b9f3586..db5d2ea39fc0 100644
> > --- a/arch/x86/hyperv/hv_vtl.c
> > +++ b/arch/x86/hyperv/hv_vtl.c
> > @@ -25,6 +25,10 @@ void __init hv_vtl_init_platform(void)
> >  	x86_init.irqs.pre_vector_init =3D x86_init_noop;
> >  	x86_init.timers.timer_init =3D x86_init_noop;
> >
> > +	/* Avoid searching for BIOS MP tables */
> > +	x86_init.mpparse.find_smp_config =3D x86_init_noop;
> > +	x86_init.mpparse.get_smp_config =3D x86_init_uint_noop;
> > +
> >  	x86_platform.get_wallclock =3D get_rtc_noop;
> >  	x86_platform.set_wallclock =3D set_rtc_noop;
> >  	x86_platform.get_nmi_reason =3D hv_get_nmi_reason;
> > --
> > 2.34.1
> >
