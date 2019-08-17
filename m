Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5180912C6
	for <lists+linux-hyperv@lfdr.de>; Sat, 17 Aug 2019 21:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfHQT7i (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 17 Aug 2019 15:59:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfHQT7h (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 17 Aug 2019 15:59:37 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 999002075E;
        Sat, 17 Aug 2019 19:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566071976;
        bh=eo8wd+qEiFVyD5xnO7seiI6TxyLC7qiAllt20mVsk8A=;
        h=From:Date:To:Cc:Cc:Cc:Cc:Cc:Subject:From;
        b=Hi+H+ome4eHNn6aF8zh/EVdbyf7G/dYOPhAvKEgop6a87xDgvZDDGN4c0gqP4U2cM
         wYMNHT+OqMPt63xxEhnQCLPCmtQ7QKjYlac7zJavSMbPeN2IRFmHIFOxV6WY7NVRAE
         DiNuPJSFrdPJ4rllNbB77eX/4uPikKXmMCoIIi+4=
From:   Sasha Levin <sashal@kernel.org>
Date:   Sat, 17 Aug 2019 15:59:35 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@microsoft.com
Cc:     linux-hyperv@vger.kernel.org
Cc:     kys@microsoft.com
Cc:     sthemmin@microsoft.com
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] Hyper-V fixes for v5.3-rc
Message-Id: <20190817195936.999002075E@mail.kernel.org>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

for you to fetch changes up to bafe1e79e05de725e26b3f60c90b49e635b686b9:

  MAINTAINERS: Fix Hyperv vIOMMU driver file name (2019-08-17 15:29:39 -0400)

- ----------------------------------------------------------------
- - A few fixes for the userspace hyper-v tools from Adrian Vladu.
- - A fix for the hyper-v MAINTAINERs entry from Lan Tianyu.
- - Fix for SPDX license identifier in the userspace tools from Nishad
Kamdar.

- ----------------------------------------------------------------
Adrian Vladu (3):
      tools: hv: fixed Python pep8/flake8 warnings for lsvmbus
      tools: hv: fix KVP and VSS daemons exit code
      tools: hv: fix typos in toolchain

Lan Tianyu (1):
      MAINTAINERS: Fix Hyperv vIOMMU driver file name

Nishad Kamdar (1):
      tools: hv: Use the correct style for SPDX License Identifier

 MAINTAINERS                  |  2 +-
 drivers/hv/hv_trace.h        |  2 +-
 tools/hv/hv_get_dhcp_info.sh |  2 +-
 tools/hv/hv_kvp_daemon.c     |  8 +++--
 tools/hv/hv_set_ifconfig.sh  |  2 +-
 tools/hv/hv_vss_daemon.c     |  4 ++-
 tools/hv/lsvmbus             | 75 +++++++++++++++++++++++++-------------------
 7 files changed, 54 insertions(+), 41 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAl1YXDEACgkQ3qZv95d3
LNwzQxAAlJgFE5AQ0etqM4ns/wx05AOePVHR90ua+FCU0W3umL5vGeYxCbl9dJ08
zYUhnoq/y4nbccIH7edJlrxb/J9+Slsp0FxWBbPSGjvbLK0yjaxHup8bcdyq6/pP
UM/fvaPzd7NnK/LPehDlV1l2skqbsimm2wbv7P1sXYZ8aQwowXxJkeVeKvfipiCw
MAB1KMCZGJg1n9w6xi2j+wnV4cuRgcMX/n+0C5Qc2AfFAVPrPzEJoGiRJBhQgqf0
JDg1+hWKrAyTAJvKHQf8o/8EsvLr/Itm1t9Q+s3eQUFqbvVPilbFR8OltSgPHgUM
PJG+Kur49jjOpUR1OJ8MeRQXqblRqSxpe7POsjP1vnGTCvuO/sLSHiCDT7+3YIEN
+bXaONOTCQSH5j8KgNE6MN/wfGIpoSEgMJEoN16OyELsQa2zIhRCwHdz72DkojJq
QzrGkChLwAz8Dw3Ul/NX36MJMAyT9DTM3GE1IXY4LzOL0381JRbvms1vwP2dIkL4
c3+tGJ7iBi23KEfkBdD3fq2JBs3KVCucIMOZX9RWDqbRhl61015GKPSALAD7r9vR
BKYo3hdaDxk7DpSTHTupUds/EmSnkS+7poaXl2iY2jVJTUXXIyg7Ig3IBI7Vqhc9
3SgunAaaKdgrh60JxkVTJ7WQUAPbOf3h/a/P1WAhSrpkxHB0XXI=
=BevR
-----END PGP SIGNATURE-----
