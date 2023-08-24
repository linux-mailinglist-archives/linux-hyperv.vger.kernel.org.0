Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93207877C7
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Aug 2023 20:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238588AbjHXS1p (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Aug 2023 14:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243048AbjHXS1o (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Aug 2023 14:27:44 -0400
X-Greylist: delayed 527 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Aug 2023 11:27:42 PDT
Received: from mxo2.nje.dmz.twosigma.com (mxo2.nje.dmz.twosigma.com [208.77.214.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25394198D
        for <linux-hyperv@vger.kernel.org>; Thu, 24 Aug 2023 11:27:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTP id 4RWrv26HwSz21BM
        for <linux-hyperv@vger.kernel.org>; Thu, 24 Aug 2023 18:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=twosigma.com;
        s=202008; t=1692901134;
        bh=MXQLPD0OICS3MSfagzaeBJqg/lZ9CakMcmNAXiDUPUU=;
        h=From:To:CC:Subject:Date:From;
        b=XGDzhlISFUPcNK+q9qLorTtrebRhyPVz4S5wYNOgE242+jlqXCWDge9FCfEe3OpCN
         MkIDUQsLz82TKW9GAFfnzd6jHrjICq4+BBySO0yIkW1ZVK6UTyn2AnHRriXjaIqMYI
         czR1HGIjrLH583gVs1fRpwB9wNLbLd/bFWEjzfq0OG4cudk11nV8C0+AfwTalLgcB7
         o4ikH6G0n8vEG2TfPJy5soKEfXwijnrPirc70n53xgvOqp80MLyMOpN9a0MRQWEO3B
         B01Q32SK9N6poKz9dAJSd9nSFlakgWxdrGlQ2kauY1xDdy905lMlKztew8jZq5NITk
         cg3TtmBwmi0bg==
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LNwYK0JQ2hCm for <linux-hyperv@vger.kernel.org>;
        Thu, 24 Aug 2023 18:18:54 +0000 (UTC)
Received: from gsdft-exhy02.ad.twosigma.com (gsdft-exhy02.ad.twosigma.com [172.22.36.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTPS id 4RWrv25zwRz1xnP
        for <linux-hyperv@vger.kernel.org>; Thu, 24 Aug 2023 18:18:54 +0000 (UTC)
Received: from gsdft-exhy01.ad.twosigma.com (172.22.36.110) by
 gsdft-exhy02.ad.twosigma.com (172.22.36.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 24 Aug 2023 18:18:54 +0000
Received: from dsdft-exet01.dft.dmz.twosigma.com (172.22.49.105) by
 gsdft-exhy01.ad.twosigma.com (172.22.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30 via Frontend Transport; Thu, 24 Aug 2023 18:18:54 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (172.22.49.240)
 by edge1.twosigma.com (172.22.49.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 24 Aug 2023 18:18:54 +0000
Received: from DM6PR08MB4699.namprd08.prod.outlook.com (2603:10b6:5:13::32) by
 CH3PR08MB9226.namprd08.prod.outlook.com (2603:10b6:610:1c0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Thu, 24 Aug 2023 18:18:41 +0000
Received: from DM6PR08MB4699.namprd08.prod.outlook.com
 ([fe80::200c:ed21:6c92:b18e]) by DM6PR08MB4699.namprd08.prod.outlook.com
 ([fe80::200c:ed21:6c92:b18e%2]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 18:18:40 +0000
From:   Thor Simon <Thor.Simon@twosigma.com>
To:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Andrew Brown <Andrew.Brown@twosigma.com>,
        Terron Mann <Terron.Mann@twosigma.com>,
        Jon Stumpf <Jon.Stumpf@twosigma.com>,
        "Thomas Walker" <Thomas.Walker@twosigma.com>
Subject: netvsc device errors followed by unkillable Linux guest VM lockup?
Thread-Topic: netvsc device errors followed by unkillable Linux guest VM
 lockup?
Thread-Index: AdnWtzRltLGP+gcCTVCKMqrpHmGcqA==
Date:   Thu, 24 Aug 2023 18:18:40 +0000
Message-ID: <DM6PR08MB4699E9C56C1AFB4E07D09FA6F11DA@DM6PR08MB4699.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=twosigma.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR08MB4699:EE_|CH3PR08MB9226:EE_
x-ms-office365-filtering-correlation-id: 1cbb103a-d603-43e3-51be-08dba4ce8b16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ixsl+RejKn2RGRZVE0Rryo+T552YA4z1QBlF0wEPlM1T0WOAi0ebNKmzyUp3qhkWWnO/2GzJOQXRKFxuK9hOXBCqZDl0kFUZGybWPXPga/Z2P/dVSWGerSyu3Z18s96K4fxCK+rdyIPMTbUGLDLdR+R9XHTLgo8yQPB7t8HKWuq0TBXcFAbJ5W0Yt2Z8Y3HzF8AadGKnUu/KRYC81PDU0kXRxyEYsGLuRtYMo5PWXfm362lVDbtoJjl98RZ3UvCz7USjJXYxbCVHVb/RV7QxBAJM5D2xSn9jR5DVZFVS/nSiSuO2WjWONFHf0yTDUx4twJLD61OEBwNyYm1qxiPCqCTvkTFgnG0Pxl8Z+4l6wP2uWHsxfEwFcwVvWA5w8kvf8agB/s/EW2u41fsAOstiV6HqoPcDTCdGrpAtkOZeCIQLykRvnVaCN9NQSX/v7Ohe459fvGanpp84g9zdZRxVtKobZGcHCWNT3pgfNwfvaFUFiBThrqTyKrKP2CZejFvbufUvIDa5ZKZN4yzBNtIIyzMqB5wBP7Qim6+hy2TlbcLYvTDh5BWwfQOVY8zEKnc+sqqNnAYpcOWs/Jyq4ikhPcl3vsY0PNNqTDOSNeTxcyZKqBNkzJIq8TYWGxYoQw2J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR08MB4699.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(346002)(39850400004)(451199024)(1800799009)(186009)(33656002)(86362001)(122000001)(38070700005)(38100700002)(66899024)(6506007)(7696005)(71200400001)(478600001)(5660300002)(52536014)(54906003)(316002)(6916009)(76116006)(2906002)(4326008)(8676002)(8936002)(64756008)(55016003)(26005)(9686003)(83380400001)(66946007)(66476007)(66446008)(66556008)(41300700001)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5oFrf5xHYdMrHduRbpxWlLDRU3gO1oEQIAEa7SrxvGIv7Q+CNxJjqc8j2H?=
 =?iso-8859-1?Q?0Oa/HVG6iQq06fpxtX7v6UzfSS2dhkDA+fW7uIssvc1ngGI8hnmRLEuHMx?=
 =?iso-8859-1?Q?Zcw1tFjMEXLQc16ABxqz1/uCXYA9O3axu4TGrOtcf8ENpYNH7XvMD+Xr+j?=
 =?iso-8859-1?Q?ou66WcGz5ubksrD+I0wL5P+R2mkOTJ6qBg68DtgawozFkib6waWXmxfWsV?=
 =?iso-8859-1?Q?7C6XFp7BNmYB+6Z621Qebnfc9auGyJnWraemFmhChVNM1y+F1Wgr9QN8pj?=
 =?iso-8859-1?Q?CvHUPWZe2LTXL+0f/lYa6+CUYJ+3zEwmNeY0/Xe0D1j8AIxOU5pPM1GrVW?=
 =?iso-8859-1?Q?TBvyl71bO/kyE92ePNMgZz7dKhQ7D0aN8l/Yr+3EV3uK9dlziFtqNNN/ho?=
 =?iso-8859-1?Q?80sTauacZ1QYd4D6+MfG81z/Z033fGt0NSU0gfh62Aqlo9BSgQFEf28sog?=
 =?iso-8859-1?Q?WcSre9APqtbmdOLpNdspAVSw2Y+qiy3GixQtBVMGCxps5FHVqYWZ+CkqDW?=
 =?iso-8859-1?Q?HM8Xhvl/4UNLOkJDTLTK5ou///Cb8gt3fmToRPL1PPgQaibOe2TRCzyrt/?=
 =?iso-8859-1?Q?PgKNWEpsyie2RHrntJBirTktiebGxj8m36GfqYeZrrwvB/uVDZXbOO4lLj?=
 =?iso-8859-1?Q?Kc1+z5K+xRSqHWkzkRFlcNk50mVrVqF5RqttX0Pd5wlcWiZn+lUNZj4hZU?=
 =?iso-8859-1?Q?3iQmsh31Wn2qdbVBLuHMi+7lFcQ+9962v85oUk3fBU3UYbxZCtWFNUdyAZ?=
 =?iso-8859-1?Q?iSK85PdQgwD20lwYfAeHJwkYCOd3qpNefLqiJqcPsYreBZd6uojd3t86p2?=
 =?iso-8859-1?Q?H5/EzYX1omfzu0TZqU6ZDlkusz+PzzM6Tp/3SYFIOnnuYCgnv+bH2iGUsV?=
 =?iso-8859-1?Q?Ll6DXvc6GmqHG1R4vK34lFdsQqsii/GX38HlPdWFGjVnybiJUwiEa1yO2E?=
 =?iso-8859-1?Q?Kp5sP+vFUsLQJaiSDQED27ClKn/MGjt8OWe1jEGQYM3AWaPCz//A6e9jmr?=
 =?iso-8859-1?Q?6DAD2ZjRryOK11Fuk0L6ay6kmdgOrP6G/rNHmCoO9PXxIq1fqtXfoUlJGq?=
 =?iso-8859-1?Q?HEqCqLFxDUEDpUs9UN5/0CJD3GzFiZS2055NgOQv3lG4VlO8lYLfI4dWYy?=
 =?iso-8859-1?Q?QgMkn/aW9bTFoOQJxWnpni75I+QipLl/06wxq4m6AzWtBBf8YCYDIxtYgB?=
 =?iso-8859-1?Q?fmsDGpV7cbmii4ZtwpdM43Nej225Bfp0WFwjzYmSSGIxmrfwGB8laphv9W?=
 =?iso-8859-1?Q?3H10ghmuR2L4LAPuA30VuIfcwtyZhlHaDDZDvMFs23RZpyONjvvHQwbohM?=
 =?iso-8859-1?Q?jjpykBesjlGa6qrZXfoIk8Z6LHnMcy4jQcuiIP73gXkTl8BhN2/Fqgy7f0?=
 =?iso-8859-1?Q?N6r5iVt/buaGM75MpN5gESxd9WaXKrlOI60wN2SapTzhcCADJTE5zegplu?=
 =?iso-8859-1?Q?dEJdzFeExdp+oP9mbNf/WcGMgk7PUQ2kZRzZsFV7aAyJVRW5u3PZur9gdf?=
 =?iso-8859-1?Q?C8x6ZhzC9jwFipancH+UmS/4wVCFSgfH7topdpg39BY5Eh7/ZSvq3ZD/2e?=
 =?iso-8859-1?Q?BIgHYpti9sqg6uIcgeDUWGB7fr1bwEbAgIsbwG7G/nx2tNudibyQPw4LOZ?=
 =?iso-8859-1?Q?7j4S7dAkgZNHRTj4Df8HuuyT/C1YpYFm7w?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rtxi+VLnq+HRhpbEIPUa3do1BvSyhsgl156FSfdgYH9IN1CAaRNYfOurquLH1jk9vZMMo+GQPcDmA3eUAt4qLZUkdNGxImvVxQB19/4UJF2xkskNAZ/dvNrlWmWPnvjwjKOzRo4J8GxEfe44osOKm7XQPhGw2ZoPeig2I1cKpKhiqFubMJUaKffjyL0AhUkweVbUf1MS9ueR/mBgxyKQDZM0rsVFzm3Xf4ja0befhtga6Pwo4HTkr16pkUAnbVwKL1wkNWVSz4FyZpcY8tRC8+CKwYEevf2Gr5JjqxEmWMt5Vt8DlebizEgiMVanBBYuqvKg5oUUeHx9c0O8q7mgUA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebJYLmKoiiJGSFm4r/l/1HkoMdZ2/1IquKr9YQfiO80=;
 b=XKn+xLcR2/ons1Gp3qSFdui6PcT95QU6otr4BVlVVyeKzLcaUxxKqyi6CpSbIATwcVSVnDaZM6GtgoC3zL5YB2y10Abq4jWCB93EbczXG8eUM88MZzxTVQXBHcePtyBxT7igQtiAzkyrqtayHlRYNMEGmtVGzR1uYD8BaGjlhxDuws7tHT8w6QWLSz5iZmxHSefFqfSG35WKwn0E6vtk7B46FXoMlAmpvfAce5nbAV63ln1tL2xyTcMYSY4DspIcA2bHuzQ/R8ODQb2NaPNnWBidn26G8v6E1DdE5TtvV/AxzHN/qg2xertz4kGTDuGlybCDaJx+VgeSm1TDNNb2GA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=twosigma.com; dmarc=pass action=none header.from=twosigma.com;
 dkim=pass header.d=twosigma.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=twosigmainternal.onmicrosoft.com;
 s=selector1-twosigmainternal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebJYLmKoiiJGSFm4r/l/1HkoMdZ2/1IquKr9YQfiO80=;
 b=uneE8FwbmjRnYwAZXkfvPywsUUqV0QUMkJedVvCb/mNJcazeyBkz+NRUSp0pM3tNEZ541TKX1NiDHfAJYCD2XmP1I5uvnF7iUecCDktSkeSnQydwiTTRH6jvuumwfM65vJEuiFwlLy03ZjJadQfYAIRRvYt4n8RLBmotz6/LJn8=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: DM6PR08MB4699.namprd08.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 1cbb103a-d603-43e3-51be-08dba4ce8b16
x-ms-exchange-crosstenant-originalarrivaltime: 24 Aug 2023 18:18:40.6482 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 43fb3c01-4eda-479a-96f3-4fb85967560f
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: YxiJDiRW8b6RWt4T+Oenr+WKMI2ATFYzKooMuNtkU6Tau7+mh/GW3hiyVCa2YUxjsKZi+EYkxrdISKLft9Zp3g==
x-ms-exchange-transport-crosstenantheadersstamped: CH3PR08MB9226
x-originatororg: twosigma.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

We've been seeing something quite odd recently on some of our Windows syste=
ms with Linux guests.  Once every day or two, with no obvious immediate cau=
se, the Linux kernel will emit a stream of errors:
       "hv_netvsc <UUID elided> eth2: unable to close device (ret -11)".

The VM then quickly becomes unkillable - attempts to "Turn Off" or "Reset" =
from the Hyper-V GUI or force-stop from PowerShell hang indefinitely and su=
bsequent efforts throw errors about the VM failing to enter the requested s=
tate.
Within the Linux guest (before attempting to "Turn Off" etc. via Hyper-V) n=
etwork-related commands like "ifconfig" hang, and an attempt to reboot will=
 result in the same hung-unkillable guest symptom.

Only a Windows reboot seems to cure the issue.

These VMs have three virtual interfaces.  "eth2" is connected to a virtual =
switch which is connected to the physical ethernet interface of the Windows=
 host.  We've never seen this problem on the other interfaces, which are, r=
espectively, connected to the Windows host itself (eth1) and the Windows ho=
st's wireless interface (eth0).

The Linux kernel is what's currently shipped with Debian 12 (Bookworm): 6.1=
.0-11-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.38-4 (2023-08-08) x86_64 GNU/=
Linux .  Windows is 21H2 (Os Build 19044.3208).

These Linux guests were recently upgraded from Debian Stretch, which had ol=
der kernels (4.x - 5.x over the past few years).  On a few systems, after t=
he Bookworm upgrade we saw some curious data-corruption problems on eth1 (t=
he interface plumbed through to Windows, as distinct from eth2 where we are=
 seeing the netvsc errors reported above) which after a great deal of exper=
imentation we worked-around with "ethtool -offload eth1 scatter-gather off"=
.  We'd never seen any issues like this (nor the issue we are currently see=
ing with eth2!) with the older kernels used with Stretch.  However, I shoul=
d note that we do routinely apply Windows updates so it's possible that wha=
tever has gone wrong is on the Windows side, not with the Linux guest's net=
vsc driver.

There is one unusual fact about the configuration of these systems.  Becaus=
e their users routinely plug and unplug different physical Ethernet adapter=
s from them, but we want to present only a single Ethernet to the Linux gue=
st, we run a small Windows service which connects the virtual switch that i=
s attached to eth2 of this guest to whichever physical interface of the hos=
t Windows system has most recently presented carrier (according to WMI).  H=
owever, the service never monkeys with the connection of the guest VM itsel=
f to the vswitch.  We've been running this service in one form or another s=
ince 2016 and it hasn't changed lately; it seems unlikely to me it's involv=
ed in what's suddenly gone wrong here; but I figured I should mention it fo=
r completeness.

Does anyone have any idea what might be going on resulting in what looks li=
ke the sudden disappearance of eth2's netvsc, or how to debug?

Thanks!

Thor

