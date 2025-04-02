Return-Path: <linux-hyperv+bounces-4774-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD85EA78A3F
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Apr 2025 10:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142BD188B9F0
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Apr 2025 08:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEE0231A57;
	Wed,  2 Apr 2025 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaWO8izr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7811AAA29
	for <linux-hyperv@vger.kernel.org>; Wed,  2 Apr 2025 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743583458; cv=none; b=YAxeX9bL+lNMnf9TFMGJPm3qc5X8bB7BPvXf/Zmzr5aeSIAtDRe+Fcpk/K3LjYZ8dzglB95Jmoo6GoWlkZ4GIUy+E7PhHquMYeK+ET4wYCqxHnnP1+lgdSkL+lhnhyo0kkObiiOa7K/vkUiXuatx9HGVzAZeb18H5FfCv0hgHgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743583458; c=relaxed/simple;
	bh=GK0cE3xz50/nbORy/xXM8huvYEH0V94OY8UWdC/2KO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u4AV0Cng0jqS7l69SUjk9ZXDy9RmYZzh9Pu45XC0sSQTYFY6L3Xy70bZEzyxc0IlYFkg1eoICmQZKKm+KVduTUlyY6Yyw81K7s4K5Bwx5Co6CB89uT28N59QNY0kwxFF+7BhTN+UQtpN/Afx7mkiGCEDiBytT38/GXA0vtcCpVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LaWO8izr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743583455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RQ9F23d/E9HJNDDDljLarJECPDlSPcnwq/hZlSgkDp4=;
	b=LaWO8izrUeFi43GhzjkptUfIG/h+EMUX7E7jLc3Yl1k+8w8OKwm6o9f7RdLN9JHPKQU0Y2
	hsZYIz6csWbtLXAqvQEm9p0roGKnzKNpC00dQ1h60lTvUZryUq8xUMdZp1Mjlkp/o2VuCG
	b82m0oMHKaC2GM411cSYCi3EyybFSfs=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-iQ42xkpKMaqu3r6rMDs1pg-1; Wed, 02 Apr 2025 04:44:13 -0400
X-MC-Unique: iQ42xkpKMaqu3r6rMDs1pg-1
X-Mimecast-MFC-AGG-ID: iQ42xkpKMaqu3r6rMDs1pg_1743583453
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-227a8cdd272so108635525ad.2
        for <linux-hyperv@vger.kernel.org>; Wed, 02 Apr 2025 01:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743583453; x=1744188253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RQ9F23d/E9HJNDDDljLarJECPDlSPcnwq/hZlSgkDp4=;
        b=AjKI4p0OhZR900/GkUhKiivzNm4NOc1d/rpjAArp0CG/woFne3rq4XUYtcVyc3YA+U
         f3y6rvyFZqV6sR0Qj0zHK0yFNkpJIis79qx+2WOfGuB9XUc+P9ZAFn0cL2fu8fGSpCDd
         IZEoXD32ZbPIrJzx1ciu3nCNFUhigM+Hz+08Uk4g8XMZ3qQSB0O/d/GqQ32EnQC8SRu5
         QEujBKpDej5ptylUig3UDDcZNLHtHuBlpWTzzH47Fc2jxsAc3xb5eh0fhcVFTEsVgFR6
         7/MOF0vOeVs5ZVXt24jn2AKHYmSPnlV58UWbffepo3GxBXUKdvaoLz91qNQhwiTAiprS
         pJHw==
X-Forwarded-Encrypted: i=1; AJvYcCX+/yNILyiKvtSf6DyMYbm/lN2P2Rs6d+973JYuVhq/EIg4DVEsjF9ePpH7i9to2nSP+L8gHqQiIOprFhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzprIVBMbnAaoMxIpnxOJkMEkFvO4FKoXif4rmBzzWiRaCWb5GV
	tMHfbAiplPpu4YFvzQHTNds03y6A087vIOiI9I2/DYNWtP+SKX2s4LwIJ+TN2iphF908KhKN2OW
	9k2R6WzgRYn25VbscST68XCVqssjhdUBwaYPm4GTwTKC0pwLWy6i/f5EXI8c/Bg==
X-Gm-Gg: ASbGnctuPbJALv5MkECWjQSsc4eYdieaqYonXrvbK3UhdqGYHjAG1Pxnv0xi9e5gK9L
	B67sJmWJ74YuF0OWlbJXvh03iW/eReGwUT0C6fEK1UWYLInu7AxrU0xDLNq2PNagYRgi7IUu624
	33GRQUGerUj5qpWonKPATsmXi9RI3+WZK090qr8UMVQayQ3lcZsWW/wTsmKyUmN1mH/zSV0JgjJ
	q4DoDrDh/rwoiz856tIdi8e7sAocsINlMbVrP4kWegpeamjYOgYPSktZZkCM3QoYIGt32dxqSNa
	H9+qrYrCGXN1G9cC
X-Received: by 2002:a17:902:d2cc:b0:21f:2ded:76ea with SMTP id d9443c01a7336-2292f9d4e12mr213521445ad.36.1743583452653;
        Wed, 02 Apr 2025 01:44:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6cYnX2gSNL4YcbMp3FSSrc8XCOSZrJOBdqY+cHTmSYJDx7efPUiNv5+ClDhwWFeSdIiQTdQ==
X-Received: by 2002:a17:902:d2cc:b0:21f:2ded:76ea with SMTP id d9443c01a7336-2292f9d4e12mr213521185ad.36.1743583452281;
        Wed, 02 Apr 2025 01:44:12 -0700 (PDT)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1f7394sm102202645ad.225.2025.04.02.01.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 01:44:11 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	drawat.floss@gmail.com,
	jfalempe@redhat.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH RFC drm-next 0/1] Add support for drm_panic
Date: Wed,  2 Apr 2025 17:43:48 +0900
Message-ID: <20250402084351.1545536-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds drm_panic support for hyperv-drm driver. This function
works but it's still needed to brush up. Let me hear your opinions.

Once kernel panic occurs we expect to see a panic screen. However, to
see the screen, I need to close/re-open the graphic console client
window. As the panic screen shows correctly in the small preview
window in Hyper-V manager and debugfs API for drm_panic works correctly,
I think kernel needs to send signal to Hyper-V host that the console
client refreshes, but I have no idea what kind of signal is needed.

This patch is tested on Hyper-V 2022.

Ryosuke Yasuoka (1):
  drm/hyperv: Add support for drm_panic

 drivers/gpu/drm/drm_simple_kms_helper.c     | 26 +++++++++++++
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 42 +++++++++++++++++++++
 include/drm/drm_simple_kms_helper.h         | 22 +++++++++++
 3 files changed, 90 insertions(+)


base-commit: cf05922d63e2ae6a9b1b52ff5236a44c3b29f78c
-- 
2.48.1


