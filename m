Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C921C40E490
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Sep 2021 19:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244497AbhIPREn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 16 Sep 2021 13:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347849AbhIPRAo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 16 Sep 2021 13:00:44 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533D3C0363CE;
        Thu, 16 Sep 2021 09:17:24 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id ay33so8045326qkb.10;
        Thu, 16 Sep 2021 09:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9bNXzT+QjdczaR0NrtTvu7baFnr9KybQD65y/vUcaD8=;
        b=WbzRt/2SFYXzgn8/y8QfQ7UAZErvt4gH4M35TM24D3BawYcEwMA3SqYkqrE29LEaqB
         y+7curn9JBBi0dUk1oPYcmuY/tq/H2nwVga8lOkUd9zozL8Y0Fumyr+l90XPU3v6eQXr
         H1yqBJhL0rWzBNYYc3PiABr9Ri4F476YWnXZNs49aQ7CCaQ9Xh/pSheeRXe68aSb+MLI
         f8X6zLQI3vVDCVYPMZuJWuFpzPHXZj0HdOyrGj/9Pi2xDG9daQgWLSdKpgu/I8YjYqsP
         YwIkwhYuTPa1DSZ/pHeU8qws7sEIej9K8FAUl+759UG41h24FR1RuOCaFmPmmrtdLgfI
         jUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9bNXzT+QjdczaR0NrtTvu7baFnr9KybQD65y/vUcaD8=;
        b=OlZmHOX2q7EmiYBj1ocr6JKe8n4GHZsuT27rjAM7Y9i2OEzqMMnxHEmkgs7tm0J27S
         TIe1XcfiSkETqDo9jIkmwkOaHhoI0CqxAZ8pHqYyaieoNE444uz4xhOutxGaWQq3MPxY
         i1TGFILH4y+JjU2hDsJLfIJ3tGeuKchX0YbFcev4n3lBDesi6cDk6inc7ylXILw7Ycpo
         kajwuHGvOQmEbY0a79qGDbrdZBHBhEo24XtcE42UC0mH+9tYsnpb/kMP7gmX41WNuvw3
         4n6l5i7ZmfWbrKqK8wA0Mznm7dCXosF03Mo1jKZ3uB/k3ACKOypnmLzPiOyJDjk6M9I7
         K4fw==
X-Gm-Message-State: AOAM530pUwvsCySkpaouUR9SUMEwRf/FHUyqsgfQqViYCi5NjwiiG/A8
        uPcAOW6Bu9lvlzOOrJJdQBL5jbuTV+LcBiVZAgM+scYadUwlZw==
X-Google-Smtp-Source: ABdhPJwuTIIoaeKG5dah6ds3dwC87mVmoHxHQgUXPL/pWtyxLdI8wqN2wE6Jbq5pE2WGwUWTwVCGFex7KyziEFRAG4w=
X-Received: by 2002:a25:9906:: with SMTP id z6mr7954873ybn.373.1631809043295;
 Thu, 16 Sep 2021 09:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210913182645.17075-1-decui@microsoft.com> <CAHFnvW0iX1FMTcJzQQtjHGosavSJ6-9wkRb7C0Ljv3c+BBUEXQ@mail.gmail.com>
 <BYAPR21MB1270C4427C264D14F151A0CCBFDB9@BYAPR21MB1270.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB1270C4427C264D14F151A0CCBFDB9@BYAPR21MB1270.namprd21.prod.outlook.com>
From:   Deepak Rawat <drawat.floss@gmail.com>
Date:   Thu, 16 Sep 2021 09:17:12 -0700
Message-ID: <CAHFnvW3J-9LGCUSP_5mvYFyiUMCy63=egu1X3Uv9GrecfOJvRQ@mail.gmail.com>
Subject: Re: [PATCH] drm/hyperv: Fix double mouse pointers
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

HI Dexuan, thanks for confirming. Could you please add this as a
comment to the function.

Reviewed-by: Deepak Rawat <drawat.floss@gmail.com>

On Tue, Sep 14, 2021 at 11:59 PM Dexuan Cui <decui@microsoft.com> wrote:
>
> > From: Deepak Rawat <drawat.floss@gmail.com>
> > Sent: Tuesday, September 14, 2021 8:59 AM
> > ...
> > > +/* Send mouse pointer info to host */
> > > +int hyperv_send_ptr(struct hv_device *hdev)
> > > +{
> > > +       struct synthvid_msg msg;
> > > +
> > > +       memset(&msg, 0, sizeof(struct synthvid_msg));
> > > +       msg.vid_hdr.type = SYNTHVID_POINTER_POSITION;
> > > +       msg.vid_hdr.size = sizeof(struct synthvid_msg_hdr) +
> > > +               sizeof(struct synthvid_pointer_position);
> > > +       msg.ptr_pos.is_visible = 1;
> >
> > "is_visible" should be 0 since you want to hide the pointer. Maybe
> > better, accept these from the caller.
>
> According to my test, "is_visible = 0" doesn't work, i.e. can't hide the
> unwanted HW mouse poiner. It looks like the field is for some very old
> legacy Windows VMs like Windows Vista.
>
> Haiyang also replied in another email, saying "is_visible = 0" doesn't
> work.
>
> > > +       msg.ptr_pos.video_output = 0;
> > > +       msg.ptr_pos.image_x = 0;
> > > +       msg.ptr_pos.image_y = 0;
> > > +       hyperv_sendpacket(hdev, &msg);
> > > +
> > > +       memset(&msg, 0, sizeof(struct synthvid_msg));
> > > +       msg.vid_hdr.type = SYNTHVID_POINTER_SHAPE;
> > > +       msg.vid_hdr.size = sizeof(struct synthvid_msg_hdr) +
> > > +               sizeof(struct synthvid_pointer_shape);
> > > +       msg.ptr_shape.part_idx = SYNTHVID_CURSOR_COMPLETE;
> > > +       msg.ptr_shape.is_argb = 1;
> > > +       msg.ptr_shape.width = 1;
> > > +       msg.ptr_shape.height = 1;
> > > +       msg.ptr_shape.hot_x = 0;
> > > +       msg.ptr_shape.hot_y = 0;
> > > +       msg.ptr_shape.data[0] = 0;
> > > +       msg.ptr_shape.data[1] = 1;
> > > +       msg.ptr_shape.data[2] = 1;
> > > +       msg.ptr_shape.data[3] = 1;
> > > +       hyperv_sendpacket(hdev, &msg);
> > > +
> >
> > Is it necessary to send SYNTHVID_POINTER_SHAPE here? Perhaps we should
>
> According to my test, yes. If I don't send a SYNTHVID_POINTER_SHAPE message,
> the unwanted mouse pointer can't be hidden. As we know, the protocol between
> the VSC and the VSP is not well documented to us. I can ask Hyper-V
> team for some clarification on this, but it's probably we can just use the current
> version of hiding the mouse pointer as-is -- this has been used for 10+ years
> in the hyperv_fb driver without any issue. :-)
>
> > separate SYNTHVID_POINTER_POSITION and SYNTHVID_POINTER_SHAPE into
> > different functions.
>
> Since the 2 messages are only used here, I suggest we keep it as-is.
>
> Thanks,
> -- Dexuan
