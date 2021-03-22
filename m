Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749FA343E89
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Mar 2021 11:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhCVKz4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Mar 2021 06:55:56 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:41625 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhCVKz2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Mar 2021 06:55:28 -0400
Received: by mail-wm1-f43.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso9005021wmi.0;
        Mon, 22 Mar 2021 03:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sxl+KhjjK3uZP0v/Sih9iAH77v3CqskINxPgqG3H8RU=;
        b=r4s5lpykuH+PObWEJ+uITzXlCs9YHRyup7IGW5OG+eht3beqIcXXS8A9XBoeZHgwSA
         q4GlpwGakYBoasFe67awKr7jTcyM7K3jrtV6DTMdVNdk94+acveuwOs6Y9VL/5olJZCd
         m3FDwzaZjYnZNfVBazg83wUDO5nySezNf0tewwEFIWKBaKqp6c0eYeY2LrpARdsVVDSn
         l/4cFo8vSs+4LC3OBT1GidPWUBqU9jPK/VAfFkhYu2ATDbyBopWbOqWpLtyxqW7oxz3j
         LI0w8DWBQve9KbowZDgZRYh6zCTWlMqyjBZ9PjDEclUlLBWWq3d0CI7w2BNiMXcqGBy4
         X/bA==
X-Gm-Message-State: AOAM532k4LY8aVuKOsClazzbmmjrIj4oRoXeq7lyPt6FFBECsjvx9goS
        bBQBbI42asGY8jb6oQyLbGJ8LJObmok=
X-Google-Smtp-Source: ABdhPJzyQ/XGrWkXDs90neNJnuA6zwtgOoAwoR+haufQGoHdCD4cJVgvJffBhhLQEy6Xf+Wp/g6MWQ==
X-Received: by 2002:a05:600c:4151:: with SMTP id h17mr15499497wmm.68.1616410526726;
        Mon, 22 Mar 2021 03:55:26 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id p18sm18963388wrs.68.2021.03.22.03.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 03:55:26 -0700 (PDT)
Date:   Mon, 22 Mar 2021 10:55:24 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vasanth <vasanth3g@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers: hv: Fix EXPORT_SYMBOL and tab spaces issue
Message-ID: <20210322105524.ulrqtriygzqy6lq2@liuwe-devbox-debian-v2>
References: <20210310052155.39460-1-vasanth3g@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310052155.39460-1-vasanth3g@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 10, 2021 at 10:51:55AM +0530, Vasanth wrote:
> 1.Fixed EXPORT_SYMBOL should be follow immediately function/variable.
> 2.Fixed code tab spaces issue.
> 
> Signed-off-by: Vasanth M <vasanth3g@gmail.com>

Applied to hyperv-next.
