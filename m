Return-Path: <linux-hyperv+bounces-11721-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3L0oCD9JRWpZ+AoAu9opvQ
	(envelope-from <linux-hyperv+bounces-11721-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 19:07:11 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3236F028A
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 19:07:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=kElTGzGz;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11721-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11721-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D8B5302E0FA
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A10C38839E;
	Wed,  1 Jul 2026 17:05:41 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0A7385D67
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 17:05:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925541; cv=none; b=nJgT3RbaShb/FhNM9kmXmxSurtdHtfyGdH3qOUitsW07xWKBnUKQC7albsjGbJVAIyXI/kZwkKNwmhJgjfcAGiNXidvKoBfWrmHmMC+PX7GFA5IXvCHOvG0T+7t2jvMQy2dUiyDJrNPMn7fF5d7pCTJnGGPaABXJftQDzh8oiRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925541; c=relaxed/simple;
	bh=rwvGk64/KqGl/3VwHg3DfEAfs9Xz+w5wS4bol/ORnhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A59tvifR4/TeaPv1Ufa+EChnsRnSvL1xEmf5yfCiDuXKwKaE1EQjd+4l7FcQuL9Xj9+0Auplezgn4zeeByhqzUsBn3ATGdVlgMKwJYJACHDFoqmQKH1DFFGCI957bpjcDPTCQMVOH2Q9rFFzfpwzUNR2/4FORzpDgf6cIxPvCcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=kElTGzGz; arc=none smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-470174001a0so766282f8f.0
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 10:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782925537; x=1783530337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HrG3PRlY2nI3ihDFK93hWp4oS9XsKzt4hSWU1Z2kul8=;
        b=kElTGzGzefxrrxxsey3nSWRwEeTPCX2cpXlMIZKaLXQS7VSFIDvi7tEtdSOMnAZwIn
         NXLBlA+nmJCmbLeiWNWFnRzltxMP6hFVS9cWJ2GakKjnJOvFT4fGCQjuX8SWlqrH8MHK
         MWJhod3daoOLLENyHO6Mcgj62u3+pKorVhcVNjEEQtsgErNhtrdPWZ/CWzNgd/HsJTrD
         Nc2bvLEAZJjBC+X3x8mDJPdr5jIVzGNB4FzmxR7nq4Ymf0CLcnAFSyfrZ86wIVWSqUh8
         LXtT+CEni7kU8ruM4Yb5OWFYTr9lNI+WpEqYoBZhA1g0mt3u2PsoQJxdp9gEN7sn3nUy
         Z/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782925537; x=1783530337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrG3PRlY2nI3ihDFK93hWp4oS9XsKzt4hSWU1Z2kul8=;
        b=SwqOSyX4osMK36qoYNC9xVHU0TXAMn5V1CvJU1aZAzOgUnppWWhQmYdRzAEZ4IHuwn
         r2C3zqy9etRzxV0mIAzRhqq4EttDjFGCRE00EC0HUuSS4rnMrloePhHn6371rNrJmTO3
         S/cBcsvqQC9hEVmI613uHN8cy0rpuiz3cUBoYa4Rknog5WEw38psP+4d9RFQf0EkGCmz
         F5Zylw4Y+GF8WccgvPQdlnN4riD4ATPfKYX3IORTn6y+qkCLh2CaGv9XVLtht2CsSKs7
         uMqWTSpLGyCx11bXhR71eS/ZCwDUUjJxKvChtfCSbDHsLHC00FatItj5K+R8NArJ2t9J
         0Iwg==
X-Gm-Message-State: AOJu0YzljItvETQQMqamIqDRq3s8T/p0EoKucnUI8Db7VXrFQw1JQ4Vr
	Lflw5NkNfKTkunRSHSbAc1nWde4YNqod9+akElYB+AGSe/xJqbZ7a11BqjnuwbKNMOA=
X-Gm-Gg: AfdE7ck464ttayrZ08aV/ujBd7LIsA04wIcfUowK+/ZmtyvXUwR5rQ+e8IC2AHqen79
	aShxSXlFMYj5kj4OyH2VnoRcqBA1NerecV4cAmVCJXFg5K1uQtzQ9AAgXRj9Ao0/eO1PEJKOL7F
	vB4ibts/QxMKNdEra3ba8OScZFzleprJC6G27u/HNDl2rCqFimtQCVPPu7CiNggVRr7eBSlEHCK
	EMIwQWsojIM/E7ga63slggbxhQU8gf/j/6kliZP1N+LyFQXoqjiNhogBUOVLiJFU6ZtIE0hjcIf
	5slIEWs0hj8c2J7CDr+UP4D8FqRjX5iQLZQgnuJpxZdvM5qYFaDcaD2jvvSyBoZcRUXdAgYqvVe
	9xLMPEpH5KU+V3vUUnq+ELkQk3yh4dwzScLC6FO22EBv1K7ocTUQY10Wb4/JB3v4VbJ8h5F+qyA
	mBk6DZzJvR0U//FSChxNwcc3P0/qfLvOhrXg5trNqI2y3ID9//cR0yorwbgMpKEts4IfI3VnMtQ
	Qlp
X-Received: by 2002:a05:6000:178d:b0:46f:7127:9f70 with SMTP id ffacd0b85a97d-477b3889564mr2285598f8f.18.1782925536585;
        Wed, 01 Jul 2026 10:05:36 -0700 (PDT)
Received: from localhost (p200300f65f47db044d4849b7c2d3c964.dip0.t-ipconnect.de. [2003:f6:5f47:db04:4d48:49b7:c2d3:c964])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-477db3dba0esm1205869f8f.7.2026.07.01.10.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 10:05:36 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Deepak Rawat <drawat.floss@gmail.com>
Cc: linux-hyperv@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] drm/hyperv: A fix and a few cleanups
Date: Wed,  1 Jul 2026 19:05:18 +0200
Message-ID: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=830; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=rwvGk64/KqGl/3VwHg3DfEAfs9Xz+w5wS4bol/ORnhA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqRUjORN26Upk1BzKM8GBO2F3OHSluAPF8+Oom2 Ia+fLtfEJGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakVIzgAKCRCPgPtYfRL+ TmZJB/9MIsOpFCpH2Rs80TZubgLNnhh/OdPfNkjQEQ54y8TfXuR6VUxMRhZzPjOQiuXPs49rQm+ z1ivVlCY/u6Is6tVLa3+Carp56kKNfUwFVsbHUiBrn+s2k4zcwED+S1Z/S3njUeulnGjoZ1dubU 6FwB/Qd+ttLWD/n4yolloc3o+EQUW5krvjPnJLZHaTQiN7Ncj8oULnqRf+6e+725pHwNtxNXCaE qlGu3muHkBBH8cXpua7Csfpoiv1xNfNfE3gPtLjjXyAyAwYpNsZe4jqjVH8ME6rseUD5YOtI6VY bslewLxFNQYDzbrqHi+0Dn6wZ+/u+jri4Az/aJxLA8I5ZxDH
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FREEMAIL_TO(0.00)[microsoft.com,linux.microsoft.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:decui@microsoft.com,m:longli@microsoft.com,m:ssengar@linux.microsoft.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:drawat.floss@gmail.com,m:linux-hyperv@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:drawatfloss@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[u.kleine-koenig@baylibre.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11721-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[baylibre.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F3236F028A

Hello,

while working on a tree-wide cleanup I found a few issues in the
drm/hyperv driver that are addressed here.

While the first patch is a fix, the issue is so old (from 2021, included
in v5.14-rc1) that applying the series during the next merge window is
probably the right choice.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (4):
  drm/hyperv: Unregister pci driver in error path before module unload
  drm/hyperv: Explicitly set subvendor and subdevice for pci match array
  drm/hyperv: Drop useless empty remove callback
  drm/hyperv: Move MODULE_DEVICE_TABLE to the device_id arrays

 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)


base-commit: be5c93fa674f0fc3c8f359c2143abce6bbb422e6
-- 
2.55.0.11.g153666a7d9bb


