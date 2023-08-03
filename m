Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD13E76E7D5
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Aug 2023 14:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbjHCMHH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Aug 2023 08:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbjHCMHD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Aug 2023 08:07:03 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2100.outbound.protection.outlook.com [40.107.117.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438C630D3;
        Thu,  3 Aug 2023 05:06:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvzxDIRmufm+bBl+0pslSyERwsxY3NiEbZcwqfmpafFsu9pUG7qYCssOw5Ta9QftWRqVEvAmpwL8/y3an/cZXITxStiOc1ARKWqPwtUjE3g3k+L40mAUd7mn16p52+X7bhAyrc+mh5bKvWLS09H/9Hwrp9Ie3bYV59EUGBwRcfHSftg+HYlEXUHIDl65rFa2WyXRHvqjpNhNjJQd+LWLMbs68lGfoVX3ThZQ+QgYmphUJElE8fysm/85fyQhakagj+KDI6mVr3nFn4FNDMgGzN0W/67gizVJAQPVtN1NE1lwpboBRGucxR83f7kLQeDHfxchmlEenvDv1c/qqq43vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWFvWinIRAyHjBVskFkwhCdeKMDO2jAHSCVCEkjw2Oc=;
 b=LeMgwT7AwepomZQ9J2A7ktw0nVBznBLXrzOgH6R2BCCF7gSatiO2nAjNhfrk5M7XWCvVOAwNYqW8Xybmhv8rbTbEj7qZ05PiK+6kVotMHVa9Kp+EkaD/8gzGltTKy4fs0CT+7DYo9TRMZdU7pXn0AIWrL1n13OswzwGqH+QSpYjHKclYZfWmfDdDs6v8JwFrFnMo92dvJt0B1yG2AoQBLavxYqUzYeTyRZCI/tDpXvZlQ6k92UVx7/aHdGtkZWpENcH6nqG5DhfT/LSizKMtlrN//tS29DLEi5CwQ++7Ngl3znnlZouNKPA6FOgq4ERwYn7hQ1YT3kSwp1iHwz01tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWFvWinIRAyHjBVskFkwhCdeKMDO2jAHSCVCEkjw2Oc=;
 b=WO0W9icimRjP/nGiggYJLz0xhsUgdhzA9Xmy6u7/Fnm2Qqg127htsbINRyNusWlmxVI6uZIIzNsfafAiEU2EhCmzso48q0R9BlOaTsfum1EjfFXw88KjM2bMNfFX6/J4N+k4+FtfVOwy8lgVOHP4gJTYMbGCe2CKWWUln7afprk=
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e2::8) by
 TYSP153MB0982.APCP153.PROD.OUTLOOK.COM (2603:1096:400:417::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.6; Thu, 3 Aug 2023 12:06:20 +0000
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::46af:847a:14d4:67f]) by PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::46af:847a:14d4:67f%4]) with mapi id 15.20.6678.005; Thu, 3 Aug 2023
 12:06:19 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v3 2/3] tools: hv: Add vmbus_bufring
Thread-Topic: [PATCH v3 2/3] tools: hv: Add vmbus_bufring
Thread-Index: AQHZxYp4ScKyNg4DEUCY5ohV8EBLF6/Yc/4w
Date:   Thu, 3 Aug 2023 12:06:18 +0000
Message-ID: <PUZP153MB0635B50C34F01E7581832744BE08A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
References: <1689330346-5374-1-git-send-email-ssengar@linux.microsoft.com>
 <1689330346-5374-3-git-send-email-ssengar@linux.microsoft.com>
 <BYAPR21MB1688F11EF5924D8D69F97203D70BA@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB1688F11EF5924D8D69F97203D70BA@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2aa72647-c4ef-4bbc-b80d-0558ac66f7d4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-02T21:05:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0635:EE_|TYSP153MB0982:EE_
x-ms-office365-filtering-correlation-id: 3f6cd0c4-9d16-44b6-f1e0-08db941a0b71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j7za3evZfpvBmIaGCTOmvDik4Ad4aZLultxE0kVePwpDcf2YHIY+To33fgJNfPRwoLvni0TGfL0UVIQjSfmUU3q/B3ACS0A0+pSiy/VizudNR1hCT2uaKKWjnQlzk8balg3qic1XTVVf+buKcIO9675F7iyJUvXNTaoFRuIi4Dr/kmflxiIRWmWWT2BhRWK7XaYh+3ZrLeHKsB9WOz9RdQhJZ2t63PYdnoJ5FrE8Bnv3xGntxYiVbppwvATpKuZe/ZKyODm16t0Vs0ayxbyqWgBqnaRNnM70Wx+0HDXzLOMts19uiXBBvmGd3pCZAvSLFGgqZXxpZMJXCzcAEy201LoyjKSjkLBB1yIwn9BgsxdPn8KK5gzeZl1jNv0a++JyGCdSv8/x9TUNxumIvRqonkSJHTlnub4zig7WV3m61Cxv1X8gDo478hx3Bz36z9c3D0d/6DZAWJw/mzR81YErJHve2AzcSIJsz64lUKFYL1z+JwqNU+MFdxk33l6gkKk+/d82rWuWz1qAJwJ5sDX+55m2Chv07G4f8ykI/LylqyjTrYNXQyKACmGfXTEy9x9sNP7JHppX/gzQYxe1riJTEEomBGLpTQpl7zp2sYJtwZvAffJkuzUOs2Fi01Djy13ghnTtDALk0QBBxE4plre1+aaUqDnz/6jIOcsrHDeN8tbARFMIa8gP1G849Etx6YKt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0635.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199021)(921005)(53546011)(52536014)(41300700001)(186003)(8936002)(8676002)(5660300002)(6506007)(122000001)(33656002)(86362001)(10290500003)(38070700005)(82950400001)(82960400001)(38100700002)(83380400001)(478600001)(9686003)(110136005)(7696005)(966005)(64756008)(66446008)(71200400001)(66946007)(76116006)(66556008)(66476007)(316002)(786003)(55016003)(2906002)(8990500004)(30864003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zn6w2nB5QjBMjK/1vT5MUZQ4WMnisO3t6qCkMNE0nwBJuol3aVlcX/1KQH6K?=
 =?us-ascii?Q?hDl4Yp6IhQCr3rcbYzoRwwVVfCaoLYTWWf/3v6ofpqqM0Z1XQJYoW0tS/Wy9?=
 =?us-ascii?Q?/9HV8UwtKjJEd8vtShmZ4PDH63eHNzz91Mp1qZ8h2XvCHW0tMApFNYqRqfaO?=
 =?us-ascii?Q?EffVbRsy7ySMQ0qFHksxHGTheNLUtrEy/5Q7sI1rfJJwVWBXc/bwAznaR5IB?=
 =?us-ascii?Q?+/Xeohkq+Zpa/jJnhFOhPxMiO8n0dtYo2qFc2y4ZLxmDRpXyf/OGcTejYrPP?=
 =?us-ascii?Q?e4OwfKMbAsEahCfx0rU2crYyA0w64lIUhQgiTH9eF1MSy65pndk01fee7y2k?=
 =?us-ascii?Q?hh6YAxX5uGnzVhEDOJ1NCpMLBSVbRuGueUpVMt73D+k3VEjky2jwDGrT+XHL?=
 =?us-ascii?Q?tOWVV12P7lGbCqZeq0qzxqQNClkRP78lxfsup3c4sNMMBW8IBrm8c0lQpTIX?=
 =?us-ascii?Q?RTCZMlisC1SUr9TgyEc/B1cnXOGOIB+DEJrn/ROBDLUItDV7c3zgn4aB5pKy?=
 =?us-ascii?Q?Ms68gBMWETG9pMJy+c8z0orHUHsJhL4hiLPgel5SdJqKWaBbotpp6LBUzMHJ?=
 =?us-ascii?Q?zUXtKFa7SYjNZ1Ew8Xa5H483NdElFib7Vwmi4zbVwAykPPGXJRYdNH1h418X?=
 =?us-ascii?Q?F1k5sl74fFmRzYdll6KpAk5+OlcDx9zYbAgVWWCz5Mbuw85qUuNy7ii2Nk/B?=
 =?us-ascii?Q?YtotxdwfVhL9FGkmubNGUzxUAdB/phOCqOpOV1aoYdFLDCaUrFaoQuj6a4zr?=
 =?us-ascii?Q?h+wrRbzsq3kELl/zep1G9Xnt6VDigDj7nKYEGgeYppZyBrU49o5ecuRs6gfP?=
 =?us-ascii?Q?/HEeKn5IEr7A0Wy7PDawHzuVwL6rdif6m5bxTqtQOCjxLvf6IKWzCJwSaCVc?=
 =?us-ascii?Q?TTL6VueTRUb2V95l2hb5DNDCFDxJs6fvaDhvguKbSZzgNBPUGVPppkuOrqF2?=
 =?us-ascii?Q?jZEInZA0eV2EbaP2+zCcic98TCk9lUvpKVxdO1+i/41/zQcLthMh9laWaN3Z?=
 =?us-ascii?Q?Huk28fetYNi+4bLGFF64GmCZrXa1E/WBK3KOnndVE+skjjkSC4fOSyoI/3sY?=
 =?us-ascii?Q?b51bUjHCeueytVEQqR83cHy3rT6Vnm5OeMa5BVHFT9LvqLg5AZJ+MQA/FMuV?=
 =?us-ascii?Q?xDrTSN2+eGpP1remBdq8YdscJSiAf7bLNXKrSDVUE2KpnAT+m8NnXjODy7Zo?=
 =?us-ascii?Q?480rieWxSZ4i9aG2MuPqOsfT7ygQ10eoAjdJ8ytm1x94Ut07sd//q9F3Nj1T?=
 =?us-ascii?Q?uO2B4lCV8mRGHUbXkKqv/Dpc2oDcVa8zQLFL2Ai8YIaOJwT6MbwjAxP7djEc?=
 =?us-ascii?Q?HK9fZhQyDKuzDWocmGcE9hqHsyEi7CI6yIIpCt38iJiJSewXeHHPT7uEevhl?=
 =?us-ascii?Q?rA0M7pakvqqanCCTMi96r9GrRfMbFpUJ8UyTcbuQxxF5ZSGD7/aA+hzS3UJj?=
 =?us-ascii?Q?U4yt0FrNxzhsOdO3jigNvf6b60cUQZ0PVP1SlckPbNoBRdR47Ml4SV3gpBYw?=
 =?us-ascii?Q?CSBr8pgLiGHjBlvAH7GAxtrBscfVVaMT23WSe0Z3q93fdSK/4EQ3Tu2Oa8jp?=
 =?us-ascii?Q?p99sITz75Q8TD2H6dlsahdxvKBY+/4h9tBIBdY32?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6cd0c4-9d16-44b6-f1e0-08db941a0b71
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 12:06:18.5125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nXxy9OtMh/Ho8dOfXK/rTXdcJqiVSrSPEEkqBqusK8CoHK5LF9+//dBOs2rGG1mQU0khNEgasDRogGFLnKr6cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSP153MB0982
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Thursday, August 3, 2023 3:14 AM
> To: Saurabh Sengar <ssengar@linux.microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
> wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>;
> gregkh@linuxfoundation.org; corbet@lwn.net; linux-kernel@vger.kernel.org;
> linux-hyperv@vger.kernel.org; linux-doc@vger.kernel.org
> Subject: [EXTERNAL] RE: [PATCH v3 2/3] tools: hv: Add vmbus_bufring
>=20
> From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Friday, July 14,
> 2023 3:26 AM
> >
> > Provide a userspace interface for userspace drivers or applications to
> > read/write a VMBus ringbuffer. A significant part of this code is
> > borrowed from DPDK[1]. Current library is supported exclusively for
> > the x86 architecture.
> >
> > To build this library:
> > make -C tools/hv libvmbus_bufring.a
> >
> > Applications using this library can include the vmbus_bufring.h header
> > file and libvmbus_bufring.a statically.
> >
> > [1]
> > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> >
> ub.com%2FDPDK%2Fdpdk%2F&data=3D05%7C01%7Cssengar%40microsoft.com
> %7C7aa6d
> >
> 4dbbcb44895db5008db93a193c9%7C72f988bf86f141af91ab2d7cd011db47%7
> C1%7C0
> >
> %7C638266094508922046%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQ
> >
> IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata
> =3DO0cvl
> > EWlbNS51VoaBHo5l2wWDDjAFJVdfDeT3t%2FR36Y%3D&reserved=3D0
> >
> > Signed-off-by: Mary Hardy <maryhardy@microsoft.com>
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> > [V3]
> > - Made ring buffer data offset depend on page size
> > - remove rte_smp_rwmb macro and reused rte_compiler_barrier instead
> > - Added legal counsel sign-off
> > - Removed "Link:" tag
> > - Improve commit messages
> > - new library compilation dependent on x86
> > - simplify mmap
> >
> > [V2]
> > - simpler sysfs path, less parsing
> >
> >  tools/hv/Build           |   1 +
> >  tools/hv/Makefile        |  13 +-
> >  tools/hv/vmbus_bufring.c | 297
> > +++++++++++++++++++++++++++++++++++++++
> >  tools/hv/vmbus_bufring.h | 154 ++++++++++++++++++++
> >  4 files changed, 464 insertions(+), 1 deletion(-)  create mode 100644
> > tools/hv/vmbus_bufring.c  create mode 100644 tools/hv/vmbus_bufring.h
> >
> > diff --git a/tools/hv/Build b/tools/hv/Build index
> > 6cf51fa4b306..2a667d3d94cb 100644
> > --- a/tools/hv/Build
> > +++ b/tools/hv/Build
> > @@ -1,3 +1,4 @@
> >  hv_kvp_daemon-y +=3D hv_kvp_daemon.o
> >  hv_vss_daemon-y +=3D hv_vss_daemon.o
> >  hv_fcopy_daemon-y +=3D hv_fcopy_daemon.o
> > +vmbus_bufring-y +=3D vmbus_bufring.o
> > diff --git a/tools/hv/Makefile b/tools/hv/Makefile index
> > fe770e679ae8..33cf488fd20f 100644
> > --- a/tools/hv/Makefile
> > +++ b/tools/hv/Makefile
> > @@ -11,14 +11,19 @@ srctree :=3D $(patsubst %/,%,$(dir $(CURDIR)))
> > srctree :=3D $(patsubst %/,%,$(dir $(srctree)))  endif
> >
> > +include $(srctree)/tools/scripts/Makefile.arch
> > +
> >  # Do not use make's built-in rules
> >  # (this improves performance and avoids hard-to-debug behaviour);
> > MAKEFLAGS +=3D -r
> >
> >  override CFLAGS +=3D -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
> >
> > +ifeq ($(SRCARCH),x86)
> > +ALL_LIBS :=3D libvmbus_bufring.a
> > +endif
> >  ALL_TARGETS :=3D hv_kvp_daemon hv_vss_daemon hv_fcopy_daemon
> > -ALL_PROGRAMS :=3D $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
> > +ALL_PROGRAMS :=3D $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS)) $(patsubst
> > %,$(OUTPUT)%,$(ALL_LIBS))
> >
> >  ALL_SCRIPTS :=3D hv_get_dhcp_info.sh hv_get_dns_info.sh
> > hv_set_ifconfig.sh
> >
> > @@ -27,6 +32,12 @@ all: $(ALL_PROGRAMS)  export srctree OUTPUT CC LD
> > CFLAGS  include $(srctree)/tools/build/Makefile.include
> >
> > +HV_VMBUS_BUFRING_IN :=3D $(OUTPUT)vmbus_bufring.o
> > +$(HV_VMBUS_BUFRING_IN): FORCE
> > +	$(Q)$(MAKE) $(build)=3Dvmbus_bufring
> > +$(OUTPUT)libvmbus_bufring.a : vmbus_bufring.o
> > +	$(AR) rcs $@ $^
> > +
> >  HV_KVP_DAEMON_IN :=3D $(OUTPUT)hv_kvp_daemon-in.o
> >  $(HV_KVP_DAEMON_IN): FORCE
> >  	$(Q)$(MAKE) $(build)=3Dhv_kvp_daemon
> > diff --git a/tools/hv/vmbus_bufring.c b/tools/hv/vmbus_bufring.c new
> > file mode 100644 index 000000000000..fb1f0489c625
> > --- /dev/null
> > +++ b/tools/hv/vmbus_bufring.c
> > @@ -0,0 +1,297 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) 2009-2012,2016,2023 Microsoft Corp.
> > + * Copyright (c) 2012 NetApp Inc.
> > + * Copyright (c) 2012 Citrix Inc.
> > + * All rights reserved.
> > + */
> > +
> > +#include <errno.h>
> > +#include <emmintrin.h>
> > +#include <stdio.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <sys/uio.h>
> > +#include "vmbus_bufring.h"
> > +
> > +#define	rte_compiler_barrier()	({ asm volatile ("" : : : "memory"); })
> > +#define RINGDATA_START_OFFSET	(getpagesize())
> > +#define VMBUS_RQST_ERROR	0xFFFFFFFFFFFFFFFF
> > +#define ALIGN(val, align)	((typeof(val))((val) & (~((typeof(val))((ali=
gn) -
> 1)))))
> > +
> > +/* Increase bufring index by inc with wraparound */ static inline
> > +uint32_t vmbus_br_idxinc(uint32_t idx, uint32_t inc, uint32_t sz) {
> > +	idx +=3D inc;
> > +	if (idx >=3D sz)
> > +		idx -=3D sz;
> > +
> > +	return idx;
> > +}
> > +
> > +void vmbus_br_setup(struct vmbus_br *br, void *buf, unsigned int
> > +blen) {
> > +	br->vbr =3D buf;
> > +	br->windex =3D br->vbr->windex;
> > +	br->dsize =3D blen - RINGDATA_START_OFFSET; }
> > +
> > +static inline __always_inline void
> > +rte_smp_mb(void)
> > +{
> > +	asm volatile("lock addl $0, -128(%%rsp); " ::: "memory"); }
> > +
> > +static inline int
> > +rte_atomic32_cmpset(volatile uint32_t *dst, uint32_t exp, uint32_t
> > +src) {
> > +	uint8_t res;
> > +
> > +	asm volatile("lock ; "
> > +		     "cmpxchgl %[src], %[dst];"
> > +		     "sete %[res];"
> > +		     : [res] "=3Da" (res),     /* output */
> > +		     [dst] "=3Dm" (*dst)
> > +		     : [src] "r" (src),      /* input */
> > +		     "a" (exp),
> > +		     "m" (*dst)
> > +		     : "memory");            /* no-clobber list */
> > +	return res;
> > +}
> > +
> > +static inline uint32_t
> > +vmbus_txbr_copyto(const struct vmbus_br *tbr, uint32_t windex,
> > +		  const void *src0, uint32_t cplen) {
> > +	uint8_t *br_data =3D (uint8_t *)tbr->vbr + RINGDATA_START_OFFSET;
> > +	uint32_t br_dsize =3D tbr->dsize;
> > +	const uint8_t *src =3D src0;
> > +
> > +	if (cplen > br_dsize - windex) {
> > +		uint32_t fraglen =3D br_dsize - windex;
> > +
> > +		/* Wrap-around detected */
> > +		memcpy(br_data + windex, src, fraglen);
> > +		memcpy(br_data, src + fraglen, cplen - fraglen);
> > +	} else {
> > +		memcpy(br_data + windex, src, cplen);
> > +	}
> > +
> > +	return vmbus_br_idxinc(windex, cplen, br_dsize); }
> > +
> > +/*
> > + * Write scattered channel packet to TX bufring.
> > + *
> > + * The offset of this channel packet is written as a 64bits value
> > + * immediately after this channel packet.
> > + *
> > + * The write goes through three stages:
> > + *  1. Reserve space in ring buffer for the new data.
> > + *     Writer atomically moves priv_write_index.
> > + *  2. Copy the new data into the ring.
> > + *  3. Update the tail of the ring (visible to host) that indicates
> > + *     next read location. Writer updates write_index
> > + */
> > +static int
> > +vmbus_txbr_write(struct vmbus_br *tbr, const struct iovec iov[], int i=
ovlen,
> > +		 bool *need_sig)
> > +{
> > +	struct vmbus_bufring *vbr =3D tbr->vbr;
> > +	uint32_t ring_size =3D tbr->dsize;
> > +	uint32_t old_windex, next_windex, windex, total;
> > +	uint64_t save_windex;
> > +	int i;
> > +
> > +	total =3D 0;
> > +	for (i =3D 0; i < iovlen; i++)
> > +		total +=3D iov[i].iov_len;
> > +	total +=3D sizeof(save_windex);
> > +
> > +	/* Reserve space in ring */
> > +	do {
> > +		uint32_t avail;
> > +
> > +		/* Get current free location */
> > +		old_windex =3D tbr->windex;
> > +
> > +		/* Prevent compiler reordering this with calculation */
> > +		rte_compiler_barrier();
> > +
> > +		avail =3D vmbus_br_availwrite(tbr, old_windex);
> > +
> > +		/* If not enough space in ring, then tell caller. */
> > +		if (avail <=3D total)
> > +			return -EAGAIN;
> > +
> > +		next_windex =3D vmbus_br_idxinc(old_windex, total, ring_size);
> > +
> > +		/* Atomic update of next write_index for other threads */
> > +	} while (!rte_atomic32_cmpset(&tbr->windex, old_windex,
> > +next_windex));
> > +
> > +	/* Space from old..new is now reserved */
> > +	windex =3D old_windex;
> > +	for (i =3D 0; i < iovlen; i++)
> > +		windex =3D vmbus_txbr_copyto(tbr, windex, iov[i].iov_base,
> > +iov[i].iov_len);
> > +
> > +	/* Set the offset of the current channel packet. */
> > +	save_windex =3D ((uint64_t)old_windex) << 32;
> > +	windex =3D vmbus_txbr_copyto(tbr, windex, &save_windex,
> > +				   sizeof(save_windex));
> > +
> > +	/* The region reserved should match region used */
> > +	if (windex !=3D next_windex)
> > +		return -EINVAL;
> > +
> > +	/* Ensure that data is available before updating host index */
> > +	rte_compiler_barrier();
> > +
> > +	/* Checkin for our reservation. wait for our turn to update host */
> > +	while (!rte_atomic32_cmpset(&vbr->windex, old_windex,
> next_windex))
> > +		_mm_pause();
> > +
> > +	return 0;
> > +}
> > +
> > +int rte_vmbus_chan_send(struct vmbus_br *txbr, uint16_t type, void
> *data,
> > +			uint32_t dlen, uint32_t flags)
> > +{
> > +	struct vmbus_chanpkt pkt;
> > +	unsigned int pktlen, pad_pktlen;
> > +	const uint32_t hlen =3D sizeof(pkt);
> > +	bool send_evt =3D false;
> > +	uint64_t pad =3D 0;
> > +	struct iovec iov[3];
> > +	int error;
> > +
> > +	pktlen =3D hlen + dlen;
> > +	pad_pktlen =3D ALIGN(pktlen, sizeof(uint64_t));
>=20
> This ALIGN function rounds down.  So pad_pktlen could be less than pktlen=
.

Thanks for pointing this, will fix.

>=20
> > +
> > +	pkt.hdr.type =3D type;
> > +	pkt.hdr.flags =3D flags;
> > +	pkt.hdr.hlen =3D hlen >> VMBUS_CHANPKT_SIZE_SHIFT;
> > +	pkt.hdr.tlen =3D pad_pktlen >> VMBUS_CHANPKT_SIZE_SHIFT;
> > +	pkt.hdr.xactid =3D VMBUS_RQST_ERROR; /* doesn't support multiple
> > +requests at same time */
> > +
> > +	iov[0].iov_base =3D &pkt;
> > +	iov[0].iov_len =3D hlen;
> > +	iov[1].iov_base =3D data;
> > +	iov[1].iov_len =3D dlen;
> > +	iov[2].iov_base =3D &pad;
> > +	iov[2].iov_len =3D pad_pktlen - pktlen;
>=20
> Given the way your ALIGN function works, the above could produce a
> negative value for iov[2].iov_len.  Then bad things will happen. :-(

Got it.

>=20
> > +
> > +	error =3D vmbus_txbr_write(txbr, iov, 3, &send_evt);
> > +
> > +	return error;
> > +}
> > +

<snip>

> > +	 * we can request that the receiver interrupt the sender
> > +	 * when the ring transitions from being full to being able
> > +	 * to handle a message of size "pending_send_sz".
> > +	 *
> > +	 * Add necessary state for this enhancement.
> > +	 */
> > +	volatile uint32_t pending_send;
> > +	uint32_t reserved1[12];
> > +
> > +	union {
> > +		struct {
> > +			uint32_t feat_pending_send_sz:1;
> > +		};
> > +		uint32_t value;
> > +	} feature_bits;
> > +
> > +	/*
> > +	 * Ring data starts here + RingDataStartOffset
>=20
> This mention of RingDataStartOffset looks stale.  I could not find it def=
ined
> anywhere.

Will correct it to:
Ring data starts after PAGE_SIZE offset from the start of this struct (RING=
DATA_START_OFFSET).

- Saurabh
