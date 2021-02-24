Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80CE324372
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Feb 2021 19:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbhBXSAV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 24 Feb 2021 13:00:21 -0500
Received: from mxo2.nje.dmz.twosigma.com ([208.77.214.162]:51411 "EHLO
        mxo2.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbhBXSAU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 24 Feb 2021 13:00:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTP id 4Dm3bF1k4vz8sZf
        for <linux-hyperv@vger.kernel.org>; Wed, 24 Feb 2021 17:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=twosigma.com;
        s=202008; t=1614189577;
        bh=XQVwTUEAfEojWIHvm8MterzILbnis5fTSQnEiriF90U=;
        h=From:To:Subject:Date:From;
        b=INE/K2TQLtfRh6DaI9z9KgMEMochK/22kJGXAuUapgb2qElmdbs7mAcCCGRi+BKP3
         KbgDmvtxaUtwId+7sh7O3gQwMekJBmsQtUtYqX5nhiR9oqw+afKNX2jIQQHTqk3Hed
         kPDzKC3Xb241OA92NcMx1+QczzyW/TPOGscqPX9qPMIqu7bKK+X//ICkDAZVM8GC0q
         /cdVupI0Emd6n8tbvlRZ7iggRioN7FLwzfPtXCiLcDnr/yMOehmn4bgpKg4zV1hOQr
         4b++GA/aNK4UWdXcj2QHL4wbMkNsBd2LdhuYpHkGyBkLfqhzeRAeUE9MuMcyJZmSPK
         bt5vyfIzxbnMQ==
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2m_fKdxypfZ2 for <linux-hyperv@vger.kernel.org>;
        Wed, 24 Feb 2021 17:59:37 +0000 (UTC)
Received: from exmbdft8.ad.twosigma.com (exmbdft8.ad.twosigma.com [172.22.2.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTPS id 4Dm3bF1C5sz8sYy
        for <linux-hyperv@vger.kernel.org>; Wed, 24 Feb 2021 17:59:37 +0000 (UTC)
Received: from EXMBDFT10.ad.twosigma.com (172.23.127.159) by
 exmbdft8.ad.twosigma.com (172.22.2.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 24 Feb 2021 17:59:36 +0000
Received: from EXMBDFT11.ad.twosigma.com (172.23.162.14) by
 EXMBDFT10.ad.twosigma.com (172.23.127.159) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 24 Feb 2021 17:59:36 +0000
Received: from EXMBDFT11.ad.twosigma.com ([fe80::8d66:2326:5416:86a9]) by
 EXMBDFT11.ad.twosigma.com ([fe80::8d66:2326:5416:86a9%19]) with mapi id
 15.00.1497.000; Wed, 24 Feb 2021 17:59:36 +0000
From:   Thor Simon <Thor.Simon@twosigma.com>
To:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: hv_utils PTP support and hypervisor suspend/resume
Thread-Topic: hv_utils PTP support and hypervisor suspend/resume
Thread-Index: AdcK1rMGEmqDtCUwTh+l9idWk7cw2g==
Date:   Wed, 24 Feb 2021 17:59:34 +0000
Message-ID: <18e9886a971e42a08fdd1256ff04d560@EXMBDFT11.ad.twosigma.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.23.150.131]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The TimeSync support in hv_utils presently has a "fail safe" limit of 600 s=
econds.=A0 I'm sure in a datacenter server context, where the hypervisor's =
time is expected to be tightly controlled - and continuous - this is sensib=
le.

Unfortunately, this causes linux VMs to lose time sync unrecoverably in the=
 not-uncommon case where the hypervisor's running on a laptop or desktop sy=
stem that is suspended (or hibernated) and resumed.

Does Hyper-V provide any interface by which we could detect this has occurr=
ed and override the test for time too far out of sync?=A0 Or, if not, would=
 adding a module option to suppress the test be acceptable?

