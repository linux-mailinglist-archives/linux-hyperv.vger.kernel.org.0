Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D7E264330
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Sep 2020 12:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgIJKEF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 10 Sep 2020 06:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729781AbgIJKD5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 10 Sep 2020 06:03:57 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330A0C061573;
        Thu, 10 Sep 2020 03:03:57 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id r9so6437284ioa.2;
        Thu, 10 Sep 2020 03:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y2JcHZ6MFjyHAlvpoNmjBZx8lY6aHDHdPBn5/fOR/C0=;
        b=SHjrnz+amdW+kH6msAJS1SjMD4qKf//Oke1bSThNY6pdCjvbQ+x27OU9YlV9B+SYEj
         x4WGit+P6lzFULpqfB7FM8A7DBakbna0aDoBRBFhMpId+FTvnxVfdSZkL+7UBKf6R7Li
         Qcwq03DQg64ECu81QBftLC7POFMrjdMmsyy3+USM1cM0a37HSojGGcOCLkCDzAtOUwGK
         CIURbhZ42k7j/+YCP7SNIquHjrH+i0bOrZQqdbBLNZOfz6En+Jn7mMcXdMSqXCC+jQZD
         lYjq+VOUPTp8EL0T/MjzHs07HO7C27K2v1VXkWq9+vJ2IE9wwkcgALGw9zQQ/fsUdMbG
         yKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y2JcHZ6MFjyHAlvpoNmjBZx8lY6aHDHdPBn5/fOR/C0=;
        b=eqkKb3q/k0KPTurrPFsz/XQHlr3eoD9uwTT91lNrSHalFDowkik302pJW3vnTzUT8z
         yYq6o1Lm6njI9GGPCJEvpfZrDkdDIlqp60qT480a6/NOuHQUdEq1K6xoOfPZNAV7ATDs
         +krvct4Wy8RBusCo5Dq0SlUlAIgfRpvMV+XcVQVO72e5yTseWlVrQZAACSQ8JHuw3jbo
         t0Wd+9+00AqunpNGI2c/qWAN0sqcpWY/5+b3wOCRnpVDp95FNfj5bd2tjyqFZXajosGi
         7Vune+DZJInZTjI/W7z1BirwMUQZaUYhmAj3/jvQsEq+H1VVHppz/BxP6MdRcRTRKkkD
         w6ZQ==
X-Gm-Message-State: AOAM533qR4iGZNs3/0jCRcC19D/Bv4FwnlKG1ADm0ZZIU1Yf/SwfUz4T
        jG4fRSMyumEUuJomZNjc/hkXNeEQJ0cHP8J/fvY=
X-Google-Smtp-Source: ABdhPJyLZcGsxd4Zx+mCdXy45ufEwo0KPMGwBXhtsOyHb64xVG7npyu9cbgFOz4UWOemWTgujXWUOhR54K4+16Md/2Y=
X-Received: by 2002:a5d:8b4c:: with SMTP id c12mr6859868iot.167.1599732236621;
 Thu, 10 Sep 2020 03:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200910091340.8654-1-david@redhat.com> <20200910091340.8654-5-david@redhat.com>
In-Reply-To: <20200910091340.8654-5-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 10 Sep 2020 12:03:45 +0200
Message-ID: <CAM9Jb+j=8-Fpyg2fizM_3FenF649y2AKA8rsWaQzwCgX8Da7+g@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] mm/memory_hotplug: MEMHP_MERGE_RESOURCE to specify
 merging of System RAM resources
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux MM <linux-mm@kvack.org>, linux-hyperv@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-s390@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Julien Grall <julien@xen.org>, Baoquan He <bhe@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Looks good to me.

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
