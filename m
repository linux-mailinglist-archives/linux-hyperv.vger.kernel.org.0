Return-Path: <linux-hyperv+bounces-5661-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B98AC3C44
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 May 2025 11:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42304175548
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 May 2025 09:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4261F03F3;
	Mon, 26 May 2025 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyVr5SJO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE8B1DE3DC
	for <linux-hyperv@vger.kernel.org>; Mon, 26 May 2025 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748250119; cv=none; b=RiOK1C/aYVmH+HlbNOYzU+mECQLBT2uSZfA7vNeqXucNh/Te9jJNbw9EZwHD7x2G/RfS+CSNY8d0n/wMe0QsMQRt5kRgL3nCNkYc8Ew5BZgyAEjIUgf/KwD6m4VqAGVWQ3KlwARJHZuJYq4wdo38wu1p9uhupVnDkcY0T9Hj+Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748250119; c=relaxed/simple;
	bh=nmXboQQCUu01/xiEDjIBc+fgApQJh0IAbcu4AwvDqfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZBfLXHaZ9RUaIzdycS3KFY+KwPS6qZsnt2Dd97emeQCpQqQ/2ADlebhekvGnQFBrhaZCrkPC2RDKyiSS81ac/xC63ZO8xeeNO9LMC68Eqi33gNjnyZv3CRP2uUlbKKNWuZ+6FpV4CanxXWW68gXdqFVP+v862iEK4bX96NCuPq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iyVr5SJO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748250113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XpqFq1Cn/q29H6M8GbCwazfqpbC4oULqm059siADfdQ=;
	b=iyVr5SJOd6PvKN7lka0JZp0GCp2wUxcOheV5kcHN/LYFNi0XbWdKlkGEVzwiWvaXqyKgtL
	zNP+QPjERv7XNVjc/YZ2zQFKh6bGzfKwC7JSQ1NHwADTkaBV8QHQoUNKYDboDTd4GnFDRn
	vpmQ8ROLD7iVK8GHMcEFJ9hKVKTf6Zo=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-ZcK9gTerNqigOUaOpfJ-pg-1; Mon, 26 May 2025 05:01:50 -0400
X-MC-Unique: ZcK9gTerNqigOUaOpfJ-pg-1
X-Mimecast-MFC-AGG-ID: ZcK9gTerNqigOUaOpfJ-pg_1748250109
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7391d68617cso2307615b3a.0
        for <linux-hyperv@vger.kernel.org>; Mon, 26 May 2025 02:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748250109; x=1748854909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpqFq1Cn/q29H6M8GbCwazfqpbC4oULqm059siADfdQ=;
        b=JK3D4F5FJ5qnR7RMYUZdRkWjTPl1Qw9t2ImJMYYrwvwX5OTMUzcVyLz5Kivm5XgOzV
         HZvjLb6U3CWSMuKbNp+l/PWmNJMpaXhgS06uS1aDKk8l4j+qaHca8So4PH/ubtYM5F9R
         omjWPDEOiDhrMQN9SRw6Bt4GCxVGxHPcH6TdVYna768fIVjMhYTIQFevp07vXBLikyFz
         HlYq9+rqACFRKJ9DjuRYiC3gdVdjsXvFlSmskZsnwgD7aS4g+4HQ9JHH/C498A98ngvU
         UEwVOJk926J9LNcIOhIVByTKSfchX0lZiISac4Gml0o1izXgcci2xQjstMzzqKWF2Lku
         34ng==
X-Forwarded-Encrypted: i=1; AJvYcCVOMrQEN02U2wxiWgX2ZuHrYJEizyOvrK/VTYlrMTxMIqe9VyMLY2c94M/XWhCRmdYXsUMmLsCPMcjc1fE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb7Rq2aQKa3Ctb/e6uiqgFt3ABIbMyarI5OK/AIok99p+nXONX
	Ai+n5qErAfG/Hopj9ajUmQt67EqW5zWr1Kvl3yIgh0lsuwdWYBVJeZF6Vfef05/m6zksCZ7NSdh
	JCdPjOvWMg5Yfz6GwIafyjgidfN0JYu95CtjsSRZLG/iWpdMmEigakCvh3r9CN6PCbQ==
X-Gm-Gg: ASbGncsnVR8ZL5WKeBDQSCKH/nSYIFTmYXyzJLzUBMx2TpmcWuvVhLG4ReMYqMyPbAI
	JazqiVdyDY816E0SNhf4zo2ZyMnhcHH1erE5o0Bu+CiLOZUa12+5dE3EMhHlEkoFL5PYkzGQD4T
	GNmFTWsPL07ghorux31MoY7nUgejJL3ChGXpGkp2zHfTYdPoGfzdqBFSUojqGDEUsDmFXUu1ecF
	NUK6FlyfESps75B2aoOTeyRFnI3BiNT0FhW3ZxKYS360SeyJxu4YUAAwJBv640T29tEYBnQ1gJ8
	LVNzTtxKtwt9
X-Received: by 2002:a05:6a21:3390:b0:1f5:8cf7:de4b with SMTP id adf61e73a8af0-2188b6edb8amr12702084637.16.1748250109589;
        Mon, 26 May 2025 02:01:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg0OYyfVBPgdKD2DLb50UwcWBJCWgjQ/A2N0sS7L7e5vajyw7pe8MKb0ud18NgI98tWZxDgQ==
X-Received: by 2002:a05:6a21:3390:b0:1f5:8cf7:de4b with SMTP id adf61e73a8af0-2188b6edb8amr12702050637.16.1748250109169;
        Mon, 26 May 2025 02:01:49 -0700 (PDT)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9878b53sm16575092b3a.152.2025.05.26.02.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 02:01:48 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: drawat.floss@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	jfalempe@redhat.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH RFC drm-misc-next v2 0/1] Add support for drm_panic
Date: Mon, 26 May 2025 18:01:04 +0900
Message-ID: <20250526090117.80593-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.49.0
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

v2:
- Re-write codes with regular atomic helper. The driver was implemented
  with simple KMS. So replace it with regular atomic helper in [1],
  implement this feature on it.

[1] https://lore.kernel.org/all/20250427101825.812766-1-ryasuoka@redhat.com/

v1:
https://lore.kernel.org/lkml/20250402084351.1545536-1-ryasuoka@redhat.com/

Ryosuke Yasuoka (1):
  drm/hyperv: Add support for drm_panic

 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 36 +++++++++++++++++++++
 1 file changed, 36 insertions(+)


base-commit: c06cb85ad1412c6ff34792b028b2f89495761398
-- 
2.49.0


