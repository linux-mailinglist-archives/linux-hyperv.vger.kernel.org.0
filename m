Return-Path: <linux-hyperv+bounces-3066-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99489984F1C
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Sep 2024 01:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B75B28231B
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Sep 2024 23:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B43146A7B;
	Tue, 24 Sep 2024 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="QFDGv8WI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CC617557
	for <linux-hyperv@vger.kernel.org>; Tue, 24 Sep 2024 23:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727221811; cv=none; b=BeSmbQWqNxEN5bSyfs5DIfJxIercvsPkrg17K7bFs6NbvTB/7dLEBOzpiVH+tpmpADAFNit4srhjnYoBGXpt5r2enBeiFH7KUcwWa2gDPJAhIvYIpcI84FBIsFHlnH4l91XlXbBenjaxJMuWk4+wWt2PxH8eU8Y1GPS+VR01xE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727221811; c=relaxed/simple;
	bh=a8Z5mmnu+VQJLis1hyP5wTPbRslAt4ObomSNIgtp2Mg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=et56zK3n7O4qyKiM3+qS8QpE1qIWECmQVU6YMal/c4WbIfPr1cNm+4HaE6s05bnhxyDBy6aCI07L7YGlb6Wt3qliK71RM8CII4iVMm/rLTUctqFD0U1AznAMfKhIgAxWFj0fosceHcVPt2NRFwgjzTTrSTByd3QgHL2FV11A+fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=QFDGv8WI; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71b0722f221so619634b3a.3
        for <linux-hyperv@vger.kernel.org>; Tue, 24 Sep 2024 16:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727221809; x=1727826609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ETCN/PQccI3mGV1t1V6gEzjBaIIiFLibedrAaSu0lxQ=;
        b=QFDGv8WI4V3KHRnrQ902fcUFEUSwDkdEhYjpPYsmtQ/BB/sXlahxFuTe8vSen/Qe57
         h79s0lqYbKuWLhyoxNFFhZdf+70uyQwEEhsf1quFHyl6KYznSm942G9J2/fpSEHkl/ld
         eCcMrf+JDltBYG3K33Xu7SfIi8VjkGuqyBfnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727221809; x=1727826609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETCN/PQccI3mGV1t1V6gEzjBaIIiFLibedrAaSu0lxQ=;
        b=m9vkSSXNKGM1DxAldLVUmoVvPbxIRcZbY1BSWPFNq3QdqTdXax3tympnpAsdzlougt
         uJd/E5G3RDSvj1dPtLLKZqk9FkF5ceS8hp1tAp5CFEV/9IE7vaAw9tV7LHWahHRn/W8J
         3Ch3cVEj7Pk9KXPlrEikNfIKZMdH/4jjK7BN+TRRTIAYyBs1TDO9sW9dxo00W/et2j6z
         psppcFGOcv60pT669vdhnLXvEMQSYH1xWw1U6ZuEJ1/Zg24TGM0tZLTuMaoAAa+Bqldf
         uu54lBiHEUQQ4+WAb0WX5uNsKA0+mCwgbKgZb8tmwNFW+0I4z+ZCONRD5WmE5Qdawq6m
         r3Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWCCrod5MVmrKWsnqMxeq7PMEBYe5bMJpHyBWsCnkLvZs6URXJ9owYKzHEl+ACydE2npSDO4RLgxfpa3Io=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw++i6B8nVhzrH5m086IXJIDOX7z2pFcNaaBrIYivooVbCMLVAf
	KMpHa4k0p11h/xhJNwi72n34M054qa1r6+Owktbvg4rEoiK+0KYgq92mRHR2wEc=
X-Google-Smtp-Source: AGHT+IGabz/BkSHAXY9l/2tIxLKDQaWWJM8cFi5pyhdcllv6X47I+AJ9UrIwFqEsDgVFeMO8JhjfwA==
X-Received: by 2002:a05:6a20:d489:b0:1cf:440a:d447 with SMTP id adf61e73a8af0-1d4c6f3071cmr1194891637.6.1727221809704;
        Tue, 24 Sep 2024 16:50:09 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc834c3dsm1684269b3a.30.2024.09.24.16.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 16:50:09 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Eric Dumazet <edumazet@google.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Wei Liu <wei.liu@kernel.org>,
	linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next 0/1] hyperv: Link queues to NAPIs
Date: Tue, 24 Sep 2024 23:48:50 +0000
Message-Id: <20240924234851.42348-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

I've only compile tested this series; I don't have the software for testing
this so I am hoping some one from Microsoft can review and test this
following the instructions below :)

This change allows users to query the mapping of queues to NAPIs using
the netdev-genl interface.

Once this patch has been applied, this can be tested using the cli included
in the kernel tree like this:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump queue-get --json='{"ifindex": 2}'

Substituing the ifindex above for the correct ifindex on your system (which
is, presumably, a hyper-V VM).

A sample of expected output would look like:

[{'id': 0, 'ifindex': 2, 'napi-id': 145, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 145, 'type': 'tx'}]

Which shows a mapping of queue ID (0) to NAPI ID (145) for both RX and TX
queues. Having this mapping is extremely useful for user apps for a variety
of use cases, including epoll-based busy poll which relies on the NAPI ID.

It would be really great to add support for this API to hyper-V so that
applications (including CI and automated testing facilities) could make use
of this API in VMs.

Sorry, I don't know much at all about hyper-V, but please let me know if
there is anything I can do to help.

Thanks,
Joe

Joe Damato (1):
  hv_netvsc: Link queues to NAPIs

 drivers/net/hyperv/netvsc.c       | 11 ++++++++++-
 drivers/net/hyperv/rndis_filter.c |  9 +++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

-- 
2.34.1


