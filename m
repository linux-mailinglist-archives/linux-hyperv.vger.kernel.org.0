Return-Path: <linux-hyperv+bounces-5645-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F199BAC274E
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 May 2025 18:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50EB57B9E63
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 May 2025 16:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EE4293457;
	Fri, 23 May 2025 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cp6jWiUr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B89C2DCBE0;
	Fri, 23 May 2025 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748016945; cv=none; b=B3YAQLRfKWCbeCcQpIB4extO+iHN6nRk/NSKtzjo6hCpXDpKCtU9O3ZqwHkja3d/U0Njyolx+WE07i8iMt7pVV23oif7hddyZefezQwro/KvsJzC1Hfu5DsAKTOuHjyqe4pa2WISEscdsx8kcd+bU9dP0fFE49DbMkk4UqgHRTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748016945; c=relaxed/simple;
	bh=3wdedpDzqcbxUVOIt3ElR+2fnWpQvTv0IrlmfOx2kaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GQtnq3gIihHctbmzpkX3+UME2YBJEyDaGczSSSicGLFVbvnO4HJytf0bXTO84ohHyWMnD6qT5dMqOXkMYe1cCo9pLi3+2YXyL5QJVll+pdZah4g7RA+rwchKMQECvCDb/B7oa3nS03HHjDzls5XtThL1FDFTIvP9GATVmKhUjso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cp6jWiUr; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31107f4833fso99876a91.0;
        Fri, 23 May 2025 09:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748016942; x=1748621742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ls243XxE58XUFIhUPSeMMfbElJjdBNkZybvfZFLuLmk=;
        b=cp6jWiUrrNqK6HG/b9Cm6J6fqw5N3ontxA+uNk3AsEwBRhBAkX3yWS1csvtPAK4zRG
         tlz6xbR6HM44580YF5P2bMGxMY8dLXqFbBd8wCv9gkOjZFdRSKmZgp8DlWMZaq2DIZ+t
         QVQD6fHWwSy3iiiCJqd+mU5YzqoG1OUvvdRJmQjhjpk/UEYTVhopoYtlQ+U5ueGyprPA
         MgQoKKib387v+pGpytdqGQcY8OpZ7tWunQMLcsQN7NT2T+bHd3a8VXd0Ybf5DaRi3L7Q
         ISs6fRP9/wjaaIfoH5AjpsKXWIA163Z9Li/Nz8I4eZndNd/0K5eZMRQy4IkWoF/QEHt4
         oYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748016942; x=1748621742;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ls243XxE58XUFIhUPSeMMfbElJjdBNkZybvfZFLuLmk=;
        b=SeDggmMH0Gq4klHGrFYvM6XjJ/eaUBwPqa2Yhst4buWHat2oQmOUCa4ZW0vR4pPfJL
         MuC2LyLDsD3XoLhzffGizJGWvg3kXQHh+tlueBqtNzODNsQGClG4VhFqUguNlqMJKWQC
         MzvyTRVVSH1nGI6O5vaiZfoLcuo9men0y2tk6Myi0tkI3O0j06xsBaKDno1aqey+nIvx
         Pu7mi2kAy/sofYaeD+SLjKcyWq/hmpw/H6Yds1yjVhLoykEe8bmRTBnYWt3oJMV1Jh5p
         72RW8OxYyJL7XRJ78aslHqzl9ASGWB7mAvOteP6E1RAiGtEisA+rA6JVIH3zng7IyyEF
         wNJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9C5InxSMLCHU0E6y4MZTpTmEtK4khPdTNEsXVPuCFcUx7jiK7hE9K6E2AbX+mzltTaSqWFn/WCdNCEcz8@vger.kernel.org, AJvYcCVKncHhsr1NtFFz8PFpXhm9JEd0i6oqTtZ6YF5tnvhRdLuRY6tURQ85zL1xRSGTiBd9jvlkZkcbb3vrVfDT@vger.kernel.org, AJvYcCX4iw9njlMiWhLNp6i44OvkQNxW3zjKFGl8z0bXXJMJyOdX8ZkkZsJs4jYpZLD+tV7bW6g5rextmwnqdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqKy01WD7eeUlCv3d/KuXUY84v4R+O/CFOhD542XTqjajBwO+0
	I1J3T9kSw5khK2jp7iB0mpP0tIpmibrlKMU2LZmGSACns979dN5Ejih4
X-Gm-Gg: ASbGncuhynXkh6kLqm+lXZUKlcNEf3bwHJziUq/yz8M78ncY7ml2dlXYU8PG/R08I9p
	9pnHtU2PP1JWYvgWD6bEmdPvNYQjJpEyNyerSz4W7+eV7/rJ62l7w3bM49naztDgCz+bI8VlfDR
	etW8uIAORiAMYXPqhIjfEPJvTdJLq7pT81LVYlx5K1An7bVjPDwRrXeq8DkkTDCzi63ghElVTBa
	ULJGAYfXXFTgCmqqcSSfJjFLv7VoLjMumM9fUaEqCtOQ99DP/VSuB7NwPRToCgjzF/EKhV8vFVx
	R7uuhzgN0xLuv51AdwWg36G/wSyLBOZhmPeBJA8tS7Sl1dM3VjkJw2mN6rKhL7RQKahnmEjvQ61
	xI9YKNtmF3lDsa0J9SIJ9nV9v+IwVuw==
X-Google-Smtp-Source: AGHT+IFm/aBR27COrCfUEG1WEEW/VaW4o7v7eFIsjnnSJARIe9dfY945CATNH/PdlGnGpUKKevkX5Q==
X-Received: by 2002:a17:90b:54d0:b0:305:2d68:8d57 with SMTP id 98e67ed59e1d1-30e830ca02bmr37165622a91.5.1748016942269;
        Fri, 23 May 2025 09:15:42 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365d46ffsm7526565a91.25.2025.05.23.09.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 09:15:42 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: simona@ffwll.ch,
	deller@gmx.de,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	akpm@linux-foundation.org
Cc: weh@microsoft.com,
	tzimmermann@suse.de,
	hch@lst.de,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 0/4] fbdev: Add deferred I/O support for contiguous kernel memory framebuffers
Date: Fri, 23 May 2025 09:15:18 -0700
Message-Id: <20250523161522.409504-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Current deferred I/O code works only for framebuffer memory that is
allocated with vmalloc(). The code assumes that the underlying page
refcount can be used by the mm subsystem to manage each framebuffer
page's lifecycle, which is consistent with vmalloc'ed memory, but not
with contiguous kernel memory from alloc_pages() or similar. When used
with contiguous kernel memory, current deferred I/O code eventually
causes the memory free lists to be scrambled, and a kernel panic ensues.
The problem is seen with the hyperv_fb driver when mmap'ing the
framebuffer into user space, as that driver uses alloc_pages() for the
framebuffer in some configurations. This patch set fixes the problem
by supporting contiguous kernel memory framebuffers with deferred I/O.

Patch 1 exports a 'mm' subsystem function needed by Patch 3.

Pathc 2 defines the FBINFO_KMEMFB flag for use by Patches 3 and 4.

Patch 3 is the changes to the fbdev deferred I/O code. More details
are in the commit message of Patch 3.

Patch 4 updates the hyperv_fb driver to use the new functionality
from Patch 3.

Michael Kelley (4):
  mm: Export vmf_insert_mixed_mkwrite()
  fbdev: Add flag indicating framebuffer is allocated from kernel memory
  fbdev/deferred-io: Support contiguous kernel memory framebuffers
  fbdev: hyperv_fb: Fix mmap of framebuffers allocated using
    alloc_pages()

 drivers/video/fbdev/core/fb_defio.c | 128 +++++++++++++++++++++++-----
 drivers/video/fbdev/hyperv_fb.c     |   1 +
 include/linux/fb.h                  |   1 +
 mm/memory.c                         |   1 +
 4 files changed, 111 insertions(+), 20 deletions(-)

-- 
2.25.1


