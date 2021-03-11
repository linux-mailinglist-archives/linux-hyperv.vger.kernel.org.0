Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4802A337AA3
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Mar 2021 18:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhCKRTt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 11 Mar 2021 12:19:49 -0500
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:50235 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhCKRTT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 11 Mar 2021 12:19:19 -0500
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Mar 2021 12:19:19 EST
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id 4DxFsZ5Cwdz8scH;
        Thu, 11 Mar 2021 17:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=twosigma.com;
        s=202008; t=1615482834;
        bh=2DZMVcocvELIAZOcoQOMe3Tl7Gr1Jdjw5VysgZ52fGE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=cwIJ2UnXZi2egX/22TDrej+cM+RaxFiZ4JJjsOPuE2oV87BBhcUMyET2hBjs2e2Y+
         b5IHfektYFs3szR0tUvM0gQZNYHPt6GdTOEbow4NkptODQ8EmIkld9hFTy5CdPrWfs
         vM53Gp9OpngC5eWPdVc9zSTgEAdmzuzKTtj1eDXCL1zRFrHT6XNn3M94nmODwJBi1M
         AXnhb2o4GgIdzCZbkuAM0SJKx/gUFHW5SZPdQQbHAleAvgs9cTCDuy+AlgvSVBG989
         rqAttfeAgg2ypPQVKA5iK9a4ilagXn1PqzYjcYlECKVTNrVtNe2OfOt9B6CqFTME3U
         J35Sha1D2RDHg==
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yNiQHmch3D_y; Thu, 11 Mar 2021 17:13:54 +0000 (UTC)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id 4DxFsZ4cqgz8sZL;
        Thu, 11 Mar 2021 17:13:54 +0000 (UTC)
Received: from EXMBDFT10.ad.twosigma.com (172.23.127.159) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 11 Mar 2021 17:13:54 +0000
Received: from EXMBDFT10.ad.twosigma.com ([fe80::5821:6415:3fad:203e]) by
 EXMBDFT10.ad.twosigma.com ([fe80::5821:6415:3fad:203e%19]) with mapi id
 15.00.1497.012; Thu, 11 Mar 2021 17:13:54 +0000
From:   Thor Simon <Thor.Simon@twosigma.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Thomas Walker <Thomas.Walker@twosigma.com>
Subject: RE: hv_utils PTP support and hypervisor suspend/resume
Thread-Topic: hv_utils PTP support and hypervisor suspend/resume
Thread-Index: AdcK1rMGEmqDtCUwTh+l9idWk7cw2gAJXzFQAudd+2A=
Date:   Thu, 11 Mar 2021 17:13:54 +0000
Message-ID: <a9c1cf9e386d480283412f90719f1a4b@EXMBDFT10.ad.twosigma.com>
References: <18e9886a971e42a08fdd1256ff04d560@EXMBDFT11.ad.twosigma.com>
 <MWHPR21MB159349176C48D2D85BFABEA2D79F9@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB159349176C48D2D85BFABEA2D79F9@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.23.151.105]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Thanks, Michael - I'd convinced myself that the _behavior_ was consistent w=
ith the 600 second magic number even though I couldn't see from the control=
 flow exactly how it would apply.  We'll try this and report back.

Thor

-----Original Message-----
From: Michael Kelley <mikelley@microsoft.com>=20
Sent: Wednesday, February 24, 2021 5:39 PM
To: Thor Simon <Thor.Simon@twosigma.com>; linux-hyperv@vger.kernel.org
Subject: RE: hv_utils PTP support and hypervisor suspend/resume

From: Thor Simon <Thor.Simon@twosigma.com> Sent: Wednesday, February 24, 20=
21 10:00 AM
>=20
> The TimeSync support in hv_utils presently has a "fail safe" limit of=20
> 600 seconds.=A0 I'm sure in a datacenter server context, where the=20
> hypervisor's time is expected to be tightly controlled - and continuous -=
 this is sensible.
>=20
> Unfortunately, this causes linux VMs to lose time sync unrecoverably=20
> in the not-uncommon case where the hypervisor's running on a laptop or=20
> desktop system that is suspended (or
> hibernated) and resumed.
>=20
> Does Hyper-V provide any interface by which we could detect this has=20
> occurred and override the test for time too far out of sync?=A0 Or, if=20
> not, would adding a module option to suppress the test be acceptable?

There is a known bug with 5.8 and earlier kernel versions that can cause Li=
nux timesync with the Hyper-V host to get hung, so that the timesync stops =
happening.  The problem can occur after the Hyper-V host is hibernated and =
resumed, or if the guest is paused and resumed. The known problem is fixed =
by this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/d=
rivers/hv/hv_util.c?id=3Db46b4a8a57c377b72a98c7930a9f6969d2d4784e

I've just reviewed the code again, and I don't think the 600 second "fail s=
afe"
limit is coming into play in the scenario you describe.   With the above pa=
tch in
place, after Hyper-V is resumed after hibernation, the first timesync packe=
t sent by Hyper-V will set the host_ts.ref_time value to a very current tim=
e.  The ICTIMESYNCFLAG_SYNC flag will also be set, so hv_set_host_time() is=
 called via work_struct adj_time_work.  hv_set_host_time() will call hv_get=
_adj_host_time(), which will find that host_ts.ref_time is very close to th=
e value from hv_read_reference_counter().  So the 600 second test won't be =
triggered.

So my guess is that you experiencing the known bug that I initially describ=
ed.
But let me know if I'm misunderstanding, or if you are seeing a failure pat=
h that I'm missing.

Michael
