Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3B276E7F7
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Aug 2023 14:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbjHCMMk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Aug 2023 08:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbjHCMMj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Aug 2023 08:12:39 -0400
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazon11020018.outbound.protection.outlook.com [52.101.128.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDF62D49;
        Thu,  3 Aug 2023 05:12:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dy5mPszwQjM63g/e/0xIueJMS71gTrScc2OatpbvKSqrFjsTreR+86FWjr3aCqocQda5ewjxOd17fviShSdmTJL8KJmoD5mRSp6CuTcMuEtH5Ern69oFxP9l41Sl6P0ujlRMJHrdqA+9Lz9o0g8FkdOCvkWGmMiHHtnnhZgWOofcOTQ2lCwlXCThxiRnFEdnFVl5idWsQG/lsS3o9gX7cUTmRo9x3QOzBHiI7hr+UNsbSZUGW+0Cw1U4pKVsIBI0m/1H4RgGShL3pxU7YH43tR1B9YWuOZS1RAbvVPrpqTavXidpAPYK7+bZi1s6ctTVDTHtBcbOYByl1ya63VL/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElIVnpOySsY0Xn7vr0R0q6/pGpv25GV5UhcW4STL3eM=;
 b=QDyD+TufSbLhX7hxxwfDqLXMb++yWN8kcmjPAF8JOR3ZV7Dvi977SKEXxSkoi7LMhHsG5NpSFy+8sZLE9k6fC9bqXVfbPeHyk453CEO1msGrlTNHJtBDywl1s5aed//2LvQjNfErTpIa5lx3izFpunogJc+bY5Hv/xrkrGO9qzwxtUNaP2+JYrq0AwywDbFeX6qNhjatz57pWN5RIvFDHuJvD0fdyWyq9yYCi0420ZUWLUMObF+EN3dZt8+YUu9hlYCQynW5gopEEUkjplgonIy6ZM8E/SZiIYdsOv7dft2F1d6opeEs5wDAYsXg1y5Vs3kYc02jZB1eR4BA9pqTCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElIVnpOySsY0Xn7vr0R0q6/pGpv25GV5UhcW4STL3eM=;
 b=KZGF9oU0HW62JaFEXQU/DNttQ7/u7Oqr3BALVoXbys2uyeNJOUlhc4njGPUU3GN8HM8181VpJbxpyN15aqZkjXrbfCVd3iYvSpby2sYQRHAzn2mi2QzpY3lsmPk8/pobFCzPjOJ+S7ODwdd59E2fQpcyb0DM5GItRrBQW3tkcLU=
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e2::8) by
 TYZP153MB0722.APCP153.PROD.OUTLOOK.COM (2603:1096:400:258::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.9; Thu, 3 Aug 2023 12:12:18 +0000
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::46af:847a:14d4:67f]) by PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::46af:847a:14d4:67f%4]) with mapi id 15.20.6678.005; Thu, 3 Aug 2023
 12:12:18 +0000
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
Subject: RE: [PATCH v3 3/3] tools: hv: Add new fcopy application based on uio
 driver
Thread-Topic: [PATCH v3 3/3] tools: hv: Add new fcopy application based on uio
 driver
Thread-Index: AQHZxYqo0cHbfERbbE667WM37dcqOa/YernA
Date:   Thu, 3 Aug 2023 12:12:17 +0000
Message-ID: <PUZP153MB06350DD380716098B3677F02BE08A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
References: <1689330346-5374-1-git-send-email-ssengar@linux.microsoft.com>
 <1689330346-5374-4-git-send-email-ssengar@linux.microsoft.com>
 <BYAPR21MB16884ABB3DAD7B8213EF5D6DD70BA@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB16884ABB3DAD7B8213EF5D6DD70BA@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7a2f2bef-00c7-44e0-9159-1e8fedfdb809;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-02T21:29:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0635:EE_|TYZP153MB0722:EE_
x-ms-office365-filtering-correlation-id: 5cb1fb8f-3e6b-4ff9-9aa4-08db941ae1a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZWM5035wpXJ14rHADaZEGX9wWsY018UPy6Pcf1nolTdd6fl6U1qjQKtwUK10V9IzlA07i7+0LRKS9Y2ikZAH4dDMm1N8B7ydxVJd+my8tVItjJcvxaCKlMKYo5HyzUsiIi2v4Ph5xB5PewyRRDY0dJ9xANOzwL+RIknDG8wR7As+RWLG+yRsfy75Dc2xWGqSDae8AmuVWcmgxqFq/nCtkRQbodATRMMpROsN7qr5pf+5DMpmZeVqM3659wbA5xC3CTREhBEgIeIvlxhPm5x77Dh8cFjrrt1KwaaQuBr7rbTNmicCfXtp1ZYGxkQ9ZpyzTa+RWDdzeD/CrwEpRDm1R5UzI+56uhMLYVL9k5m/VIT9wUcZXQtajjo07Xbh4b/PN1bCrzZvO5jX057xxddGSRLs824OhWPjLIj8UiwB8UtyQcz66viQWuLXcbLgE6cCPiZr5BWvPD0oWat1HNXPSf+YC9pE6yLIKzqsfGhFEsZgbzyOHxU16xk+xYWE1j5MW6Vex2Yg8xPnvTbOnqg7MQNCOkM/BIzlJsJ1SnH39G2Nv6vUtqZTF6LEaBdHFjfsuje3G7jlahieVME9K0L7Jd5gMMRKRzIyjUz4CMGPYyARbtf4fp0mvrtnNOWCIdeua7A//xXwoM/tRZs/qB83mi1Hln0klvFSul4iJHaBWt/aiGmbobdjp5QVM63I4Aez
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0635.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199021)(30864003)(478600001)(33656002)(10290500003)(8990500004)(86362001)(71200400001)(966005)(7696005)(9686003)(786003)(8936002)(8676002)(41300700001)(316002)(5660300002)(66556008)(66476007)(66446008)(64756008)(52536014)(83380400001)(55016003)(110136005)(38100700002)(76116006)(66946007)(38070700005)(6506007)(82960400001)(921005)(82950400001)(122000001)(186003)(2906002)(53546011)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Joq4iYmrY7mueVh7d8Dnemvvy5YJX8hIApB6Wmo7Z/J1QFi1e+n9SRyFx+Vv?=
 =?us-ascii?Q?3ERZMNl15L24jBeHr9NtcEUllnZk7FDeTixZtdCd0f/WRZXCLfJhZvbpl5Hl?=
 =?us-ascii?Q?38/J/l47hIhmwT+bqsrWHhzq5yPOCiIfzQhjiGQbRxXTN+y4QixqTuXRNEGq?=
 =?us-ascii?Q?DY4e6n6IuKNDACjxXIDobjDa3hMatX3G06oEC/O2EuM/aejewCIvreg2t8R+?=
 =?us-ascii?Q?1fTZ2YLwqnI2a+gPaBKRsnIskRRTe0ZLYnJRPIrZ9kCea6/TalGM4aK72Nv0?=
 =?us-ascii?Q?1jQvYjj1knEG7dPnWrVmWlh4bmKgMXrQLAxUOEi8IWDua9dLq8RmLK4zQ1s/?=
 =?us-ascii?Q?MlG79+NxFmHuBhMeaDumMY9gfxhlZg1CCyKvv75vKT77Yl4X6o3JTg0MVHU+?=
 =?us-ascii?Q?xOWc2xNfA1TvF+aA8PLQGtJyxcNS3XH1dlUdgUKSkfClUeUfw8MGFgjhPFAc?=
 =?us-ascii?Q?y+SJhT3l73I3hoRXj87JyKuMRlp5ZlqBBjBl+h0fcpYHqf2rd5En9AmeEDTV?=
 =?us-ascii?Q?5HljHDOQricL/2yzytcu7K6ygZaH1RzdApCP3q/mrmlafLVCPkJo+bLG2WZ7?=
 =?us-ascii?Q?SwQFYOMp2fZhWwgqcSsrzn3xc33y4X8cSrma3Y/g7KFKx4xOIi7Fo2Ke9Aa9?=
 =?us-ascii?Q?PFPu2ZrypyJ0A6j2mCkbAJpBEQrs95kM8as7McML3uosAm4SfReaKz47Hf8m?=
 =?us-ascii?Q?rDn6shvo6YKaXLOF570bUKcn0gn6Bk/LSPoGCuZGdjS/SRLbOwH7a0yNla9h?=
 =?us-ascii?Q?V7eZPD2iSY1iqRl3CqNVB0zirsippyKa76llWZfGnMAeTAZ5tFgAOEefuQ7n?=
 =?us-ascii?Q?wjUPNzMCgU9//0gYsFZKgkmi6Y0YVgWeGLdBc8HWH4aJLWWcB1CLTDeoyxke?=
 =?us-ascii?Q?YkloLFBsG1HvuUp4O4DRGqSMGkCyEr+LXdv+xTFyITa2du/UWviO8K3ceelm?=
 =?us-ascii?Q?hec3QD/nckVdfSeNHjLoxE8Xc3mjLC9KBLrpNkdC+YItG32+ay9qYXKs1p4I?=
 =?us-ascii?Q?DT1+tlgSS34N/frN6U+OdWvLIv5WuEZ/+ZM0K/KoPscq97MPcWAYkRGGHcNf?=
 =?us-ascii?Q?LDBJsjbRAcfJuPeUqilkaYs28LH2HRwIrmldmFIahakFLhHYKeDKK+XE+kjq?=
 =?us-ascii?Q?xBdBN6RNyqgcZYPkhFt+juomMvTs6TaeiRxeeemn1zf8j0Wc8GgALJ1E1AvP?=
 =?us-ascii?Q?/tJ5dPlurdSonuu2UYBv8+9eyiHBCvD5AdOgKDOfIgRDj8sWSTjunFhOttsV?=
 =?us-ascii?Q?lJKMkwZ6ZoJknGyd3NsHyal0npUg9E6+H3KMyBUeweFktJAEvDyS5tbuNhg1?=
 =?us-ascii?Q?Elv/WiFC5OIpvt9a+ehwTxW/PUSUu2BtU3f3ujg7gKbECZnksVyCwfQX0M4J?=
 =?us-ascii?Q?5W3lTRaeivgBNnXbKZzsElsqxvNEsgN85QUtIr6WuRk+kYcGi8tJ/k8OS47x?=
 =?us-ascii?Q?qJ78noZ7iX372JyEcmMIP81XNNByymCaSj+rz+FP6vrVRBu85pcM97o7t2Z0?=
 =?us-ascii?Q?kjda6o0e6hw6AcpeNE/24QvBySh5F7G0uQdWX7wdYNMEzsu9ZBQskBQ8P4A4?=
 =?us-ascii?Q?ijkiTfsdZFZENvp9JCAvIx0y1n8kQOU99h/ZIkmo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb1fb8f-3e6b-4ff9-9aa4-08db941ae1a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 12:12:17.8545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wG+FXBP1ssZW9D1AQGfGakN4OQ3S6s9iJCNsTn3XU/jEU7G9giNCkyxDVw2wWvI692yp+yl1VBQNN8eCDZxGkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZP153MB0722
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
> Sent: Thursday, August 3, 2023 3:15 AM
> To: Saurabh Sengar <ssengar@linux.microsoft.com>; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
> wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>;
> gregkh@linuxfoundation.org; corbet@lwn.net; linux-kernel@vger.kernel.org;
> linux-hyperv@vger.kernel.org; linux-doc@vger.kernel.org
> Subject: [EXTERNAL] RE: [PATCH v3 3/3] tools: hv: Add new fcopy applicati=
on
> based on uio driver
>=20
> From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Friday, July 14,
> 2023 3:26 AM
> >
> > Implement the file copy service for Linux guests on Hyper-V. This
> > permits the host to copy a file (over VMBus) into the guest. This
> > facility is part of "guest integration services" supported on the
> > Hyper-V platform.
> >
> > Here is a link that provides additional details on this functionality:
> >
> > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flea=
r
> > n.microsoft.com%2Fen-us%2Fpowershell%2Fmodule%2Fhyper-v%2Fcopy-
> vmfile%
> > 3Fview%3Dwindowsserver2022-
> ps&data=3D05%7C01%7Cssengar%40microsoft.com%7
> >
> Ca5edc1b9d6574e2e6e3108db93a1c558%7C72f988bf86f141af91ab2d7cd011
> db47%7
> >
> C1%7C0%7C638266095311741847%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMD
> >
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C
> &sdata
> > =3DVudSwIKYJJJgPKxNbbfCnOjia1lfKCdijnSn94OWm8Q%3D&reserved=3D0
> >
> > This new fcopy application uses uio_hv_vmbus_client driver which makes
> > the earlier hv_util based driver and application obsolete.
> >
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> > [V3]
> > - Improve cover letter and commit messages
> > - Improve debug prints
> > - Instead of hardcoded instance id, query from class id sysfs
> > - Set the ring_size value from application
> > - Update the application to mmap /dev/uio instead of sysfs
> > - new application compilation dependent on x86
> >
> > [V2]
> > - simpler sysfs path
> >
> >  tools/hv/Build                 |   1 +
> >  tools/hv/Makefile              |  10 +-
> >  tools/hv/hv_fcopy_uio_daemon.c | 578
> > +++++++++++++++++++++++++++++++++
> >  3 files changed, 588 insertions(+), 1 deletion(-)  create mode 100644
> > tools/hv/hv_fcopy_uio_daemon.c
> >
> > diff --git a/tools/hv/Build b/tools/hv/Build index
> > 2a667d3d94cb..efcbb74a0d23 100644
> > --- a/tools/hv/Build
> > +++ b/tools/hv/Build
> > @@ -2,3 +2,4 @@ hv_kvp_daemon-y +=3D hv_kvp_daemon.o
> hv_vss_daemon-y +=3D
> > hv_vss_daemon.o  hv_fcopy_daemon-y +=3D hv_fcopy_daemon.o
> > vmbus_bufring-y +=3D vmbus_bufring.o
> > +hv_fcopy_uio_daemon-y +=3D hv_fcopy_uio_daemon.o
> > diff --git a/tools/hv/Makefile b/tools/hv/Makefile index
> > 33cf488fd20f..678c6c450a53 100644
> > --- a/tools/hv/Makefile
> > +++ b/tools/hv/Makefile
> > @@ -21,8 +21,10 @@ override CFLAGS +=3D -O2 -Wall -g -D_GNU_SOURCE -
> > I$(OUTPUT)include
> >
> >  ifeq ($(SRCARCH),x86)
> >  ALL_LIBS :=3D libvmbus_bufring.a
> > -endif
> > +ALL_TARGETS :=3D hv_kvp_daemon hv_vss_daemon hv_fcopy_daemon
> > hv_fcopy_uio_daemon
> > +else
> >  ALL_TARGETS :=3D hv_kvp_daemon hv_vss_daemon hv_fcopy_daemon
> > +endif
> >  ALL_PROGRAMS :=3D $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS)) $(patsubst
> > %,$(OUTPUT)%,$(ALL_LIBS))
> >
> >  ALL_SCRIPTS :=3D hv_get_dhcp_info.sh hv_get_dns_info.sh
> > hv_set_ifconfig.sh @@ -56,6 +58,12 @@ $(HV_FCOPY_DAEMON_IN):
> FORCE
> >  $(OUTPUT)hv_fcopy_daemon: $(HV_FCOPY_DAEMON_IN)
> >  	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
> >
> > +HV_FCOPY_UIO_DAEMON_IN :=3D $(OUTPUT)hv_fcopy_uio_daemon-in.o
> > +$(HV_FCOPY_UIO_DAEMON_IN): FORCE
> > +	$(Q)$(MAKE) $(build)=3Dhv_fcopy_uio_daemon
> > +$(OUTPUT)hv_fcopy_uio_daemon: $(HV_FCOPY_UIO_DAEMON_IN)
> > libvmbus_bufring.a
> > +	$(QUIET_LINK)$(CC) -lm $< -L. -lvmbus_bufring -o $@
> > +
> >  clean:
> >  	rm -f $(ALL_PROGRAMS)
> >  	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
> > diff --git a/tools/hv/hv_fcopy_uio_daemon.c
> > b/tools/hv/hv_fcopy_uio_daemon.c new file mode 100644 index
> > 000000000000..e8618a30dc7e
> > --- /dev/null
> > +++ b/tools/hv/hv_fcopy_uio_daemon.c
> > @@ -0,0 +1,578 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * An implementation of host to guest copy functionality for Linux.
> > + *
> > + * Copyright (C) 2023, Microsoft, Inc.
> > + *
> > + * Author : K. Y. Srinivasan <kys@microsoft.com>
> > + * Author : Saurabh Sengar <ssengar@microsoft.com>
> > + *
> > + */
> > +
> > +#include <dirent.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <getopt.h>
> > +#include <locale.h>
> > +#include <stdbool.h>
> > +#include <stddef.h>
> > +#include <stdint.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <syslog.h>
> > +#include <unistd.h>
> > +#include <sys/mman.h>
> > +#include <sys/stat.h>
> > +#include <linux/hyperv.h>
> > +#include "vmbus_bufring.h"
> > +
> > +#define ICMSGTYPE_NEGOTIATE	0
> > +#define ICMSGTYPE_FCOPY		7
> > +
> > +#define WIN8_SRV_MAJOR		1
> > +#define WIN8_SRV_MINOR		1
> > +#define WIN8_SRV_VERSION	(WIN8_SRV_MAJOR << 16 |
> WIN8_SRV_MINOR)
> > +
> > +#define MAX_PATH_LEN		300
> > +#define MAX_LINE_LEN		40
> > +#define DEVICES_SYSFS		"/sys/bus/vmbus/devices"
> > +#define FCOPY_CLASS_ID		"34d14be3-dee4-41c8-9ae7-
> 6b174977c192"
> > +
> > +#define FCOPY_VER_COUNT		1
> > +static const int fcopy_versions[] =3D {
> > +	WIN8_SRV_VERSION
> > +};
> > +
> > +#define FW_VER_COUNT		1
> > +static const int fw_versions[] =3D {
> > +	UTIL_FW_VERSION
> > +};
> > +
> > +#define HV_RING_SIZE		(4 * 4096)
> > +
> > +unsigned char desc[HV_RING_SIZE];
> > +
> > +static int target_fd;
> > +static char target_fname[PATH_MAX];
> > +static unsigned long long filesize;
> > +
> > +static int hv_fcopy_create_file(char *file_name, char *path_name,
> > +__u32 flags) {
> > +	int error =3D HV_E_FAIL;
> > +	char *q, *p;
> > +
> > +	filesize =3D 0;
> > +	p =3D (char *)path_name;
> > +	snprintf(target_fname, sizeof(target_fname), "%s/%s",
> > +		 (char *)path_name, (char *)file_name);
> > +
> > +	/*
> > +	 * Check to see if the path is already in place; if not,
> > +	 * create if required.
> > +	 */
> > +	while ((q =3D strchr(p, '/')) !=3D NULL) {
> > +		if (q =3D=3D p) {
> > +			p++;
> > +			continue;
> > +		}
> > +		*q =3D '\0';
> > +		if (access(path_name, F_OK)) {
> > +			if (flags & CREATE_PATH) {
> > +				if (mkdir(path_name, 0755)) {
> > +					syslog(LOG_ERR, "Failed to create
> %s",
> > +					       path_name);
> > +					goto done;
> > +				}
> > +			} else {
> > +				syslog(LOG_ERR, "Invalid path: %s",
> path_name);
> > +				goto done;
> > +			}
> > +		}
> > +		p =3D q + 1;
> > +		*q =3D '/';
> > +	}
> > +
> > +	if (!access(target_fname, F_OK)) {
> > +		syslog(LOG_INFO, "File: %s exists", target_fname);
> > +		if (!(flags & OVER_WRITE)) {
> > +			error =3D HV_ERROR_ALREADY_EXISTS;
> > +			goto done;
> > +		}
> > +	}
> > +
> > +	target_fd =3D open(target_fname,
> > +			 O_RDWR | O_CREAT | O_TRUNC | O_CLOEXEC,
> 0744);
> > +	if (target_fd =3D=3D -1) {
> > +		syslog(LOG_INFO, "Open Failed: %s", strerror(errno));
> > +		goto done;
> > +	}
> > +
> > +	error =3D 0;
> > +done:
> > +	if (error)
> > +		target_fname[0] =3D '\0';
> > +	return error;
> > +}
> > +
> > +static int hv_copy_data(struct hv_do_fcopy *cpmsg) {
> > +	ssize_t bytes_written;
> > +	int ret =3D 0;
> > +
> > +	bytes_written =3D pwrite(target_fd, cpmsg->data, cpmsg->size,
> > +			       cpmsg->offset);
> > +
> > +	filesize +=3D cpmsg->size;
> > +	if (bytes_written !=3D cpmsg->size) {
> > +		switch (errno) {
> > +		case ENOSPC:
> > +			ret =3D HV_ERROR_DISK_FULL;
> > +			break;
> > +		default:
> > +			ret =3D HV_E_FAIL;
> > +			break;
> > +		}
> > +		syslog(LOG_ERR, "pwrite failed to write %llu bytes: %ld (%s)",
> > +		       filesize, (long)bytes_written, strerror(errno));
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +/*
> > + * Reset target_fname to "" in the two below functions for
> > +hibernation: if
> > + * the fcopy operation is aborted by hibernation, the daemon should
> > +remove the
> > + * partially-copied file; to achieve this, the hv_utils driver always
> > +fakes a
> > + * CANCEL_FCOPY message upon suspend, and later when the VM
> resumes
> > +back,
> > + * the daemon calls hv_copy_cancel() to remove the file; if a file is
> > +copied
> > + * successfully before suspend, hv_copy_finished() must reset
> > +target_fname to
> > + * avoid that the file can be incorrectly removed upon resume, since
> > +the faked
> > + * CANCEL_FCOPY message is spurious in this case.
> > + */
> > +static int hv_copy_finished(void)
> > +{
> > +	close(target_fd);
> > +	target_fname[0] =3D '\0';
> > +	return 0;
> > +}
> > +
> > +static void print_usage(char *argv[]) {
> > +	fprintf(stderr, "Usage: %s [options]\n"
> > +		"Options are:\n"
> > +		"  -n, --no-daemon        stay in foreground, don't
> daemonize\n"
> > +		"  -h, --help             print this help\n", argv[0]);
> > +}
> > +
> > +static bool vmbus_prep_negotiate_resp(struct icmsg_hdr *icmsghdrp,
> unsigned char *buf,
> > +				      unsigned int buflen, const int *fw_version,
> int fw_vercnt,
> > +				const int *srv_version, int srv_vercnt,
> > +				int *nego_fw_version, int *nego_srv_version)
> {
> > +	int icframe_major, icframe_minor;
> > +	int icmsg_major, icmsg_minor;
> > +	int fw_major, fw_minor;
> > +	int srv_major, srv_minor;
> > +	int i, j;
> > +	bool found_match =3D false;
> > +	struct icmsg_negotiate *negop;
> > +
> > +	/* Check that there's enough space for icframe_vercnt, icmsg_vercnt
> */
> > +	if (buflen < ICMSG_HDR + offsetof(struct icmsg_negotiate, reserved)) =
{
> > +		syslog(LOG_ERR, "Invalid icmsg negotiate");
> > +		return false;
> > +	}
> > +
> > +	icmsghdrp->icmsgsize =3D 0x10;
> > +	negop =3D (struct icmsg_negotiate *)&buf[ICMSG_HDR];
> > +
> > +	icframe_major =3D negop->icframe_vercnt;
> > +	icframe_minor =3D 0;
> > +
> > +	icmsg_major =3D negop->icmsg_vercnt;
> > +	icmsg_minor =3D 0;
> > +
> > +	/* Validate negop packet */
> > +	if (icframe_major > IC_VERSION_NEGOTIATION_MAX_VER_COUNT ||
> > +	    icmsg_major > IC_VERSION_NEGOTIATION_MAX_VER_COUNT ||
> > +	    ICMSG_NEGOTIATE_PKT_SIZE(icframe_major, icmsg_major) >
> buflen) {
> > +		syslog(LOG_ERR, "Invalid icmsg negotiate - icframe_major:
> %u, icmsg_major: %u\n",
> > +		       icframe_major, icmsg_major);
> > +		goto fw_error;
> > +	}
> > +
> > +	/*
> > +	 * Select the framework version number we will
> > +	 * support.
> > +	 */
> > +
> > +	for (i =3D 0; i < fw_vercnt; i++) {
> > +		fw_major =3D (fw_version[i] >> 16);
> > +		fw_minor =3D (fw_version[i] & 0xFFFF);
> > +
> > +		for (j =3D 0; j < negop->icframe_vercnt; j++) {
> > +			if (negop->icversion_data[j].major =3D=3D fw_major &&
> > +			    negop->icversion_data[j].minor =3D=3D fw_minor) {
> > +				icframe_major =3D negop-
> >icversion_data[j].major;
> > +				icframe_minor =3D negop-
> >icversion_data[j].minor;
> > +				found_match =3D true;
> > +				break;
> > +			}
> > +		}
> > +
> > +		if (found_match)
> > +			break;
> > +	}
> > +
> > +	if (!found_match)
> > +		goto fw_error;
> > +
> > +	found_match =3D false;
> > +
> > +	for (i =3D 0; i < srv_vercnt; i++) {
> > +		srv_major =3D (srv_version[i] >> 16);
> > +		srv_minor =3D (srv_version[i] & 0xFFFF);
> > +
> > +		for (j =3D negop->icframe_vercnt;
> > +			(j < negop->icframe_vercnt + negop->icmsg_vercnt);
> > +			j++) {
> > +			if (negop->icversion_data[j].major =3D=3D srv_major &&
> > +			    negop->icversion_data[j].minor =3D=3D srv_minor) {
> > +				icmsg_major =3D negop-
> >icversion_data[j].major;
> > +				icmsg_minor =3D negop-
> >icversion_data[j].minor;
> > +				found_match =3D true;
> > +				break;
> > +			}
> > +		}
> > +
> > +		if (found_match)
> > +			break;
> > +	}
> > +
> > +	/*
> > +	 * Respond with the framework and service
> > +	 * version numbers we can support.
> > +	 */
> > +fw_error:
> > +	if (!found_match) {
> > +		negop->icframe_vercnt =3D 0;
> > +		negop->icmsg_vercnt =3D 0;
> > +	} else {
> > +		negop->icframe_vercnt =3D 1;
> > +		negop->icmsg_vercnt =3D 1;
> > +	}
> > +
> > +	if (nego_fw_version)
> > +		*nego_fw_version =3D (icframe_major << 16) | icframe_minor;
> > +
> > +	if (nego_srv_version)
> > +		*nego_srv_version =3D (icmsg_major << 16) | icmsg_minor;
> > +
> > +	negop->icversion_data[0].major =3D icframe_major;
> > +	negop->icversion_data[0].minor =3D icframe_minor;
> > +	negop->icversion_data[1].major =3D icmsg_major;
> > +	negop->icversion_data[1].minor =3D icmsg_minor;
> > +
> > +	return found_match;
> > +}
> > +
> > +static void wcstoutf8(char *dest, const __u16 *src, size_t dest_size)
> > +{
> > +	size_t len =3D 0;
> > +
> > +	while (len < dest_size) {
> > +		if (src[len] < 0x80)
> > +			dest[len++] =3D (char)(*src++);
> > +		else
> > +			dest[len++] =3D 'X';
> > +	}
> > +
> > +	dest[len] =3D '\0';
> > +}
> > +
> > +static int hv_fcopy_start(struct hv_start_fcopy *smsg_in) {
> > +	setlocale(LC_ALL, "en_US.utf8");
> > +	size_t file_size, path_size;
> > +	char *file_name, *path_name;
> > +	char *in_file_name =3D (char *)smsg_in->file_name;
> > +	char *in_path_name =3D (char *)smsg_in->path_name;
> > +
> > +	file_size =3D wcstombs(NULL, (const wchar_t *restrict)in_file_name, 0=
) +
> 1;
> > +	path_size =3D wcstombs(NULL, (const wchar_t *restrict)in_path_name,
> 0)
> > ++ 1;
> > +
> > +	file_name =3D (char *)malloc(file_size * sizeof(char));
> > +	path_name =3D (char *)malloc(path_size * sizeof(char));
> > +
> > +	wcstoutf8(file_name, (__u16 *)in_file_name, file_size);
> > +	wcstoutf8(path_name, (__u16 *)in_path_name, path_size);
> > +
> > +	return hv_fcopy_create_file(file_name, path_name,
> > +smsg_in->copy_flags); }
> > +
> > +static int hv_fcopy_send_data(struct hv_fcopy_hdr *fcopy_msg, int
> > +recvlen) {
> > +	int operation =3D fcopy_msg->operation;
> > +
> > +	/*
> > +	 * The  strings sent from the host are encoded in
> > +	 * utf16; convert it to utf8 strings.
> > +	 * The host assures us that the utf16 strings will not exceed
> > +	 * the max lengths specified. We will however, reserve room
> > +	 * for the string terminating character - in the utf16s_utf8s()
> > +	 * function we limit the size of the buffer where the converted
> > +	 * string is placed to W_MAX_PATH -1 to guarantee
> > +	 * that the strings can be properly terminated!
> > +	 */
> > +
> > +	switch (operation) {
> > +	case START_FILE_COPY:
> > +		return hv_fcopy_start((struct hv_start_fcopy *)fcopy_msg);
> > +	case WRITE_TO_FILE:
> > +		return hv_copy_data((struct hv_do_fcopy *)fcopy_msg);
> > +	case COMPLETE_FCOPY:
> > +		return hv_copy_finished();
> > +	}
> > +
> > +	return HV_E_FAIL;
> > +}
> > +
> > +/* process the packet recv from host */ static int
> > +fcopy_pkt_process(struct vmbus_br *txbr) {
> > +	int ret, offset, pktlen;
> > +	int fcopy_srv_version;
> > +	const struct vmbus_chanpkt_hdr *pkt;
> > +	struct hv_fcopy_hdr *fcopy_msg;
> > +	struct icmsg_hdr *icmsghdr;
> > +
> > +	pkt =3D (const struct vmbus_chanpkt_hdr *)desc;
> > +	offset =3D pkt->hlen << 3;
> > +	pktlen =3D (pkt->tlen << 3) - offset;
> > +	icmsghdr =3D (struct icmsg_hdr *)&desc[offset + sizeof(struct
> vmbuspipe_hdr)];
> > +	icmsghdr->status =3D HV_E_FAIL;
> > +
> > +	if (icmsghdr->icmsgtype =3D=3D ICMSGTYPE_NEGOTIATE) {
> > +		if (vmbus_prep_negotiate_resp(icmsghdr, desc + offset,
> pktlen, fw_versions,
> > +					      FW_VER_COUNT, fcopy_versions,
> FCOPY_VER_COUNT,
> > +					      NULL, &fcopy_srv_version)) {
> > +			syslog(LOG_INFO, "FCopy IC version %d.%d",
> > +			       fcopy_srv_version >> 16, fcopy_srv_version &
> 0xFFFF);
> > +			icmsghdr->status =3D 0;
> > +		}
> > +	} else if (icmsghdr->icmsgtype =3D=3D ICMSGTYPE_FCOPY) {
> > +		/* Ensure recvlen is big enough to contain hv_fcopy_hdr */
> > +		if (pktlen < ICMSG_HDR + sizeof(struct hv_fcopy_hdr)) {
> > +			syslog(LOG_ERR, "Invalid Fcopy hdr. Packet length too
> small: %u",
> > +			       pktlen);
> > +			return -ENOBUFS;
> > +		}
> > +
> > +		fcopy_msg =3D (struct hv_fcopy_hdr *)&desc[offset +
> ICMSG_HDR];
> > +		icmsghdr->status =3D hv_fcopy_send_data(fcopy_msg, pktlen);
> > +	}
> > +
> > +	icmsghdr->icflags =3D ICMSGHDRFLAG_TRANSACTION |
> ICMSGHDRFLAG_RESPONSE;
> > +	ret =3D rte_vmbus_chan_send(txbr, 0x6, desc + offset, pktlen, 0);
> > +	if (ret) {
> > +		syslog(LOG_ERR, "Write to ringbuffer failed err: %d", ret);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void fcopy_get_first_folder(char *path, char *chan_no) {
> > +	DIR *dir =3D opendir(path);
> > +	struct dirent *entry;
> > +
> > +	if (!dir) {
> > +		syslog(LOG_ERR, "Failed to open directory (errno=3D%s).\n",
> strerror(errno));
> > +		return;
> > +	}
> > +
> > +	while ((entry =3D readdir(dir)) !=3D NULL) {
> > +		if (entry->d_type =3D=3D DT_DIR && strcmp(entry->d_name, ".")
> !=3D 0 &&
> > +		    strcmp(entry->d_name, "..") !=3D 0) {
> > +			strcpy(chan_no, entry->d_name);
> > +			break;
> > +		}
> > +	}
> > +
> > +	closedir(dir);
> > +}
> > +
> > +static void fcopy_set_ring_size(char *path, char *inst, int size) {
> > +	char ring_size_path[MAX_PATH_LEN] =3D {0};
> > +	FILE *fd;
> > +
> > +	snprintf(ring_size_path, sizeof(ring_size_path), "%s/%s/%s", path, in=
st,
> "ring_size");
> > +	fd =3D fopen(ring_size_path, "w");
> > +	if (!fd) {
> > +		syslog(LOG_WARNING, "Failed to open ring_size file
> (errno=3D%s).\n", strerror(errno));
> > +		return;
> > +	}
> > +	fprintf(fd, "%d", size);
>=20
> Check for and log an error if the new value isn't accepted by the kernel
> driver?
> The code is using a ring size value that should be accepted by the kernel
> driver, but weird stuff happens and it's probably better to know about it=
.

Ok, will add error check.

>=20
> > +	fclose(fd);
> > +}
> > +
> > +static char *fcopy_read_sysfs(char *path, char *buf, int len) {
> > +	FILE *fd;
> > +	char *ret;
> > +
> > +	fd =3D fopen(path, "r");
> > +	if (!fd)
> > +		return NULL;
> > +
> > +	ret =3D fgets(buf, len, fd);
> > +	fclose(fd);
> > +
> > +	return ret;
> > +}
> > +
> > +static int fcopy_get_instance_id(char *path, char *class_id, char
> > +*inst) {
> > +	DIR *dir =3D opendir(path);
> > +	struct dirent *entry;
> > +	char tmp_path[MAX_PATH_LEN] =3D {0};
> > +	char line[MAX_LINE_LEN];
> > +
> > +	if (!dir) {
> > +		syslog(LOG_ERR, "Failed to open directory (errno=3D%s).\n",
> strerror(errno));
> > +		return -EINVAL;
> > +	}
> > +
> > +	while ((entry =3D readdir(dir)) !=3D NULL) {
> > +		if (entry->d_type =3D=3D DT_LNK && strcmp(entry->d_name, ".")
> !=3D 0 &&
> > +		    strcmp(entry->d_name, "..") !=3D 0) {
> > +			/* search for the sysfs path with matching class_id */
> > +			snprintf(tmp_path, sizeof(tmp_path), "%s/%s/%s",
> > +				 path, entry->d_name, "class_id");
> > +			if (!fcopy_read_sysfs(tmp_path, line, MAX_LINE_LEN))
> > +				continue;
> > +
> > +			/* class id matches, now fetch the instance id from
> device_id */
> > +			if (strstr(line, class_id)) {
> > +				snprintf(tmp_path, sizeof(tmp_path),
> "%s/%s/%s",
> > +					 path, entry->d_name, "device_id");
> > +				if (!fcopy_read_sysfs(tmp_path, line,
> MAX_LINE_LEN))
> > +					continue;
> > +				/* remove braces */
> > +				strncpy(inst, line + 1, strlen(line) - 3);
> > +				break;
> > +			}
> > +		}
> > +	}
> > +
> > +	closedir(dir);
> > +	return 0;
>=20
> If this function doesn't find a matching class_id, it appears that it ret=
urns 0,
> but with the "inst" parameter unset.  The caller will then proceed as if =
"inst"
> was set when it is actually an uninitialized stack variable.  Probably ne=
ed
> some better error detection and handling.

Good point !
Let me fix it in next version.

>=20
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +	int fcopy_fd =3D -1, tmp =3D 1;
> > +	int daemonize =3D 1, long_index =3D 0, opt, ret =3D -EINVAL;
> > +	struct vmbus_br txbr, rxbr;
> > +	void *ring;
> > +	uint32_t len =3D HV_RING_SIZE;
> > +	char uio_name[10] =3D {0};
> > +	char uio_dev_path[15] =3D {0};
> > +	char uio_path[MAX_PATH_LEN] =3D {0};
> > +	char inst[MAX_LINE_LEN] =3D {0};
> > +
> > +	static struct option long_options[] =3D {
> > +		{"help",	no_argument,	   0,  'h' },
> > +		{"no-daemon",	no_argument,	   0,  'n' },
> > +		{0,		0,		   0,  0   }
> > +	};
> > +
> > +	while ((opt =3D getopt_long(argc, argv, "hn", long_options,
> > +				  &long_index)) !=3D -1) {
> > +		switch (opt) {
> > +		case 'n':
> > +			daemonize =3D 0;
> > +			break;
> > +		case 'h':
> > +		default:
> > +			print_usage(argv);
> > +			exit(EXIT_FAILURE);
> > +		}
> > +	}
> > +
> > +	if (daemonize && daemon(1, 0)) {
> > +		syslog(LOG_ERR, "daemon() failed; error: %s",
> strerror(errno));
> > +		exit(EXIT_FAILURE);
> > +	}
> > +
> > +	openlog("HV_UIO_FCOPY", 0, LOG_USER);
> > +	syslog(LOG_INFO, "starting; pid is:%d", getpid());
> > +
> > +	/* get instance id */
> > +	if (fcopy_get_instance_id(DEVICES_SYSFS, FCOPY_CLASS_ID, inst))
> > +		exit(EXIT_FAILURE);
>=20
> Per above, need better error handling.  And since the syslog is now open,=
 any
> errors should be logged rather than having the process just mysteriously =
exit.

OK.

- Saurabh

